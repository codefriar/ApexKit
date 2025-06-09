# ULID - Universally Unique Lexicographically Sortable Identifier

The ULID class provides an Apex implementation of the [ULID specification](https://github.com/ulid/spec), generating universally unique identifiers that are lexicographically sortable. Think of ULIDs as UUIDs that can be sorted chronologically.

## Table of Contents

- [What is a ULID?](#what-is-a-ulid)
- [Why Use ULIDs?](#why-use-ulids)
- [When to Use ULIDs](#when-to-use-ulids)
- [Quick Start](#quick-start)
- [ULID Format](#ulid-format)
- [Comparison with Other Identifiers](#comparison-with-other-identifiers)
- [Usage Examples](#usage-examples)
- [Best Practices](#best-practices)
- [Performance Considerations](#performance-considerations)
- [API Reference](#api-reference)

## What is a ULID?

ULID stands for **Universally Unique Lexicographically Sortable Identifier**. It's a 128-bit identifier that combines:

- **48-bit timestamp** (millisecond precision)
- **80-bit randomness**

The result is a 26-character string that is:
- ✅ Universally unique (like UUIDs)
- ✅ Lexicographically sortable (chronologically ordered)
- ✅ Case insensitive
- ✅ URL safe
- ✅ Human readable (no ambiguous characters)

## Why Use ULIDs?

### Advantages over UUIDs

| Feature | ULID | UUID v4 | UUID v7 |
|---------|------|---------|---------|
| Sortable | ✅ Yes | ❌ No | ✅ Yes |
| Timestamp | ✅ Embedded | ❌ No | ✅ Embedded |
| Length | 26 chars | 36 chars | 36 chars |
| Case Sensitive | ❌ No | ✅ Yes | ✅ Yes |
| Ambiguous Chars | ❌ Excluded | ✅ Present | ✅ Present |
| URL Safe | ✅ Yes | ⚠️ Needs encoding | ⚠️ Needs encoding |

### Key Benefits

1. **Natural Sorting**: ULIDs sort chronologically without additional timestamp fields
2. **Compact**: 26 characters vs 36 for UUIDs
3. **Readable**: No ambiguous characters (0/O, 1/I/l, etc.)
4. **Database Friendly**: Better for indexing and clustering
5. **URL Safe**: No special characters requiring encoding

## When to Use ULIDs

### Perfect For:
- **Record IDs** where creation order matters
- **Log entries** and audit trails
- **Message queues** and event sourcing
- **File naming** with chronological ordering
- **API tokens** and session identifiers
- **Database primary keys** (better clustering than UUIDs)

### Consider Alternatives When:
- You need **shorter identifiers** (use incremental integers)
- **Security** is paramount and timestamp leakage is a concern
- **Legacy systems** require specific UUID formats
- **Deterministic** generation is needed (ULIDs are always random)

## Quick Start

The ULID class has a single public method that generates a new ULID:

```apex
// Generate a new ULID
String ulid = ULID.generate();
System.debug(ulid); // Output: 01H2YCGVJ8GQWXKR7F5ZQN6R2M
```

That's it! Each call to `generate()` produces a unique, sortable identifier.

## ULID Format

A ULID consists of two parts:

```
 01AN4Z07BY      79KA1307SR9X4MV3
|----------|    |----------------|
 Timestamp           Randomness
  48bits             80bits
```

### Timestamp Component (10 characters)
- Encodes Unix timestamp in milliseconds
- Provides natural chronological sorting
- Readable as base32 from the allowed character set

### Random Component (16 characters)
- Cryptographically random
- Ensures uniqueness even when generated at the same millisecond
- Uses Salesforce's `Crypto.getRandomLong()` for quality randomness

### Character Set
ULIDs use Crockford's Base32 encoding with ambiguous characters removed:
```
0123456789ABCDEFGHJKMNPQRSTVWXYZ
```

**Excluded characters**: `I`, `L`, `O`, `U` (to avoid confusion with 1, 1, 0, V)

## Comparison with Other Identifiers

### vs Salesforce IDs
```apex
// Salesforce ID (15/18 characters)
Account acc = new Account(Name = 'Test');
insert acc;
System.debug(acc.Id); // 001XX000004DGb2

// ULID (26 characters, sortable)
String ulid = ULID.generate();
System.debug(ulid);   // 01H2YCH9K5QMXR8F3ZVN9J2P4T
```

### vs UUIDs
```apex
// Traditional approach with UUID and timestamp
String uuid = 'a1b2c3d4-e5f6-7890-1234-567890abcdef';
DateTime timestamp = DateTime.now();

// ULID approach - timestamp embedded, naturally sortable
String ulid = ULID.generate();
```

## Usage Examples

### Example 1: Log Entry Identifiers

```apex
public class LogEntry {
    public String id;
    public String message;
    public DateTime createdAt;
    
    public LogEntry(String message) {
        this.id = ULID.generate();  // Sortable by creation time
        this.message = message;
        this.createdAt = DateTime.now();
    }
}

// Generate log entries
List<LogEntry> logs = new List<LogEntry>();
logs.add(new LogEntry('User login'));
logs.add(new LogEntry('Data processed'));
logs.add(new LogEntry('User logout'));

// IDs are naturally sorted chronologically
for (LogEntry log : logs) {
    System.debug(log.id + ': ' + log.message);
}
// Output:
// 01H2YCJ4K8QMXR8F3ZVN9J2P4T: User login
// 01H2YCJ4K9RMYS9G4AWO0K3Q5U: Data processed
// 01H2YCJ4KAQNZT0H5BXP1L4R6V: User logout
```

### Example 2: Custom Object External IDs

```apex
public class OrderProcessor {
    public void createOrder(Account customer, List<Product2> products) {
        Order__c order = new Order__c();
        order.External_ID__c = ULID.generate();  // Unique, sortable identifier
        order.Customer__c = customer.Id;
        order.Status__c = 'Draft';
        
        insert order;
        
        // Create order items with ULIDs
        List<OrderItem__c> items = new List<OrderItem__c>();
        for (Product2 product : products) {
            OrderItem__c item = new OrderItem__c();
            item.External_ID__c = ULID.generate();
            item.Order__c = order.Id;
            item.Product__c = product.Id;
            items.add(item);
        }
        insert items;
    }
}
```

### Example 3: Session and Token Management

```apex
public class SessionManager {
    public static String createSession(Id userId) {
        String sessionId = ULID.generate();
        
        Session__c session = new Session__c();
        session.Session_ID__c = sessionId;
        session.User__c = userId;
        session.Created_Date__c = DateTime.now();
        session.Expires_Date__c = DateTime.now().addHours(24);
        
        insert session;
        return sessionId;
    }
    
    public static Boolean isValidSession(String sessionId) {
        List<Session__c> sessions = [
            SELECT Id, Expires_Date__c 
            FROM Session__c 
            WHERE Session_ID__c = :sessionId 
            AND Expires_Date__c > :DateTime.now()
            LIMIT 1
        ];
        return !sessions.isEmpty();
    }
}
```

### Example 4: File and Document Naming

```apex
public class DocumentManager {
    public static String generateFileName(String originalName) {
        String extension = '';
        if (originalName.contains('.')) {
            Integer lastDot = originalName.lastIndexOf('.');
            extension = originalName.substring(lastDot);
            originalName = originalName.substring(0, lastDot);
        }
        
        // Create sortable filename with ULID
        String ulid = ULID.generate();
        return ulid + '_' + originalName + extension;
        // Example: 01H2YCK3J7PMXQ8E2YVM8I1N3S_document.pdf
    }
    
    public static void uploadDocument(String content, String originalName) {
        ContentVersion cv = new ContentVersion();
        cv.Title = originalName;
        cv.PathOnClient = generateFileName(originalName);
        cv.VersionData = Blob.valueOf(content);
        cv.IsMajorVersion = true;
        
        insert cv;
    }
}
```

### Example 5: Batch Processing with Tracking

```apex
public class BatchProcessor implements Database.Batchable<SObject> {
    private String batchId;
    
    public BatchProcessor() {
        this.batchId = ULID.generate();  // Track this batch execution
    }
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Log batch start
        BatchLog__c log = new BatchLog__c();
        log.Batch_ID__c = this.batchId;
        log.Status__c = 'Started';
        log.Started_At__c = DateTime.now();
        insert log;
        
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process records and log progress
        for (SObject record : scope) {
            ProcessingLog__c procLog = new ProcessingLog__c();
            procLog.Processing_ID__c = ULID.generate();  // Unique processing event
            procLog.Batch_ID__c = this.batchId;          // Link to batch
            procLog.Record_ID__c = record.Id;
            procLog.Processed_At__c = DateTime.now();
            // ... additional processing
        }
    }
    
    public void finish(Database.BatchableContext context) {
        // Update batch completion
        BatchLog__c log = [SELECT Id FROM BatchLog__c WHERE Batch_ID__c = :this.batchId];
        log.Status__c = 'Completed';
        log.Completed_At__c = DateTime.now();
        update log;
    }
}
```

## Best Practices

### 1. Use ULIDs for External Identifiers

```apex
// Good: ULID for external ID that needs to be sortable
Custom_Object__c obj = new Custom_Object__c();
obj.External_ID__c = ULID.generate();

// Avoid: Using ULIDs for internal relationships (use Salesforce IDs)
// obj.Parent_ULID__c = ULID.generate(); // Unnecessary
```

### 2. Index ULID Fields Appropriately

```apex
// When creating custom fields that will store ULIDs:
// - Set field type to Text(26)
// - Mark as External ID if used for lookups
// - Add database indexes for query performance
```

### 3. Store ULIDs in Consistent Format

```apex
public class ULIDHelper {
    // Always store ULIDs in uppercase for consistency
    public static String generateStandardized() {
        return ULID.generate().toUpperCase();
    }
    
    // Validate ULID format
    public static Boolean isValidULID(String ulid) {
        if (String.isBlank(ulid) || ulid.length() != 26) {
            return false;
        }
        
        // Check character set (basic validation)
        String allowedChars = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
        for (Integer i = 0; i < ulid.length(); i++) {
            if (!allowedChars.contains(ulid.substring(i, i + 1))) {
                return false;
            }
        }
        return true;
    }
}
```

### 4. Use ULIDs in Integration Scenarios

```apex
public class IntegrationService {
    public static void sendToExternalSystem(List<Account> accounts) {
        for (Account acc : accounts) {
            // Generate ULID for external system tracking
            String integrationId = ULID.generate();
            
            // Store for correlation
            acc.Integration_ID__c = integrationId;
            
            // Send to external system with ULID
            callExternalAPI(acc, integrationId);
        }
        update accounts;
    }
}
```

## Performance Considerations

### Generation Performance
- **Cost**: Very fast generation (single method call)
- **Randomness**: Uses cryptographically secure random number generation
- **Memory**: Minimal memory footprint
- **CPU**: Lightweight encoding operations

### Database Performance
- **Indexing**: ULIDs perform well in database indexes
- **Clustering**: Natural time-based clustering improves query performance
- **Storage**: 26 characters vs 36 for UUIDs (28% more efficient)

### Governor Limits
```apex
// ULIDs are safe to generate in bulk operations
List<String> ulids = new List<String>();
for (Integer i = 0; i < 10000; i++) {
    ulids.add(ULID.generate());  // No governor limit concerns
}
```

## API Reference

### ULID Class

The ULID class provides a single static method for generating ULIDs.

#### Methods

**`generate()`**
- **Description**: Generates a new ULID according to the ULID specification
- **Parameters**: None
- **Returns**: `String` - A 26-character ULID
- **Example**: `String ulid = ULID.generate();`

#### Properties

The ULID class contains several private constants used in generation:

- **`CHARACTER_SET`**: List of allowed characters (Crockford's Base32)
- **`TIME_LENGTH`**: Number of characters for timestamp encoding (10)
- **`RANDOM_LENGTH`**: Number of characters for random component (16)

### ULID Specification Compliance

This implementation follows the [official ULID specification](https://github.com/ulid/spec):

- ✅ 128-bit identifier
- ✅ 48-bit timestamp + 80-bit randomness
- ✅ Crockford's Base32 encoding
- ✅ Case insensitive
- ✅ Lexicographically sortable
- ✅ URL safe

### Thread Safety

The ULID class is thread-safe and can be called from any context:
- Static methods only
- No shared state
- Uses Salesforce's thread-safe `Crypto.getRandomLong()`

### Character Set Reference

```
Value  Symbol  Value  Symbol  Value  Symbol  Value  Symbol
  0      0       8      8      16      G      24      S
  1      1       9      9      17      H      25      T
  2      2      10      A      18      J      26      V
  3      3      11      B      19      K      27      W
  4      4      12      C      20      M      28      X
  5      5      13      D      21      N      29      Y
  6      6      14      E      22      P      30      Z
  7      7      15      F      23      Q      31      Z
```

**Note**: Characters I, L, O, U are excluded to avoid ambiguity.

## Troubleshooting

### Common Issues

1. **Case Sensitivity**: ULIDs are case-insensitive but this implementation generates uppercase
2. **Length Validation**: Always exactly 26 characters
3. **Character Validation**: Only uses the specified character set
4. **Sorting**: String comparison works for chronological sorting

### Integration Tips

- Store ULIDs in Text(26) fields
- Use External ID type for lookups
- Consider indexing for frequently queried ULID fields
- Always validate ULID format when receiving from external systems

The ULID class provides a powerful alternative to traditional UUIDs when you need identifiers that are both unique and naturally sortable by creation time.