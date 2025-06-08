# QueueableProcess Framework

The QueueableProcess framework provides an elegant way to chain Salesforce Queueable jobs together, allowing you to create complex asynchronous processes with data passing between steps. This implementation is similar to a Promise pattern but designed specifically for Salesforce's asynchronous execution model.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Quick Start](#quick-start)
- [Core Concepts](#core-concepts)
- [Creating Process Steps](#creating-process-steps)
- [Data Passing Between Steps](#data-passing-between-steps)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)
- [Examples](#examples)
- [API Reference](#api-reference)

## Overview

The QueueableProcess framework allows developers to:
- Chain multiple asynchronous operations together
- Pass data between process steps
- Handle errors at the step level or globally
- Maintain execution history and context
- Create reusable process components

## Key Features

- **Fluent API**: Chain steps together using the `then()` method
- **Data Passing**: Return values from each step become input for the next
- **Error Handling**: Per-step and global exception handling
- **Execution History**: Automatic tracking of QueueableContext and FinalizerContext
- **Callout Support**: Built-in support for HTTP callouts via `Database.AllowsCallouts`
- **Transaction Finalizers**: Automatic handling of step transitions and error recovery

## Quick Start

Here's a simple example of creating and running a QueueableProcess chain:

```apex
// Create a process chain using your custom step classes
// Note: MyFirstStep, MySecondStep, and MyThirdStep are classes YOU must create
// that extend QueueableProcess. The constructor parameters are up to you to define.
QueueableProcess process = new MyFirstStep('some-id')
    .then(new MySecondStep('another-id'))
    .then(new MyThirdStep('final-id'));

// Start the process with initial data (can be any Object)
// This Object will be available to MyFirstStep as this.dataPassthrough
Id jobId = process.start(0);
```

**Important**: You must create your own step classes that extend `QueueableProcess`. Each step class must:
- Extend `QueueableProcess`
- Have a no-argument constructor
- Implement the `execute()` method that returns an `Object`
- Define constructor parameters as needed for your business logic

## Core Concepts

### QueueableProcess Abstract Class

All process steps must extend the `QueueableProcess` abstract class and implement the `execute()` method:

```apex
public class MyProcessStep extends QueueableProcess {
    private String recordId;
    
    public MyProcessStep(String recordId) {
        this.recordId = recordId;
    }
    
    public override Object execute() {
        // Your business logic here
        // Return data for the next step
        return someResult;
    }
}
```

### Data Flow

1. **Initial Data**: Passed when calling `start(initialData)`
2. **Step Processing**: Each step receives data via `this.dataPassthrough`
3. **Return Value**: What you return becomes input for the next step
4. **Chain Execution**: Steps execute sequentially, not concurrently

### Required Methods

- **Constructor**: Must have a no-argument constructor for error handling
- **execute()**: Abstract method that returns `Object` for next step

## Creating Process Steps

### Basic Step Structure

```apex
public class ProcessStepExample extends QueueableProcess {
    private Id recordId;
    
    // No-arg constructor required for error handling
    public ProcessStepExample() {}
    
    // Your business constructor
    public ProcessStepExample(Id recordId) {
        this.recordId = recordId;
    }
    
    public override Object execute() {
        // Access data from previous step
        Integer previousValue = (Integer) this.dataPassthrough;
        
        // Perform your business logic
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :recordId];
        acc.NumberOfEmployees = previousValue + 1;
        update acc;
        
        // Return data for next step
        return acc.NumberOfEmployees;
    }
}
```

### Constructor Requirements

Every QueueableProcess implementation **must** have a no-argument constructor:

```apex
public class MyStep extends QueueableProcess {
    private String data;
    
    // REQUIRED: No-arg constructor for error handling
    public MyStep() {}
    
    // Your business constructor
    public MyStep(String data) {
        this.data = data;
    }
}
```

This no-arg constructor is used by the framework when instantiating your class for error handling.

## Data Passing Between Steps

### Accessing Previous Step Data

```apex
public override Object execute() {
    // Check if data was passed from previous step
    if (this.dataPassthrough != null) {
        String previousResult = (String) this.dataPassthrough;
        // Use the data...
    }
    
    // Return data for next step
    return "Result for next step";
}
```

### Data Type Handling

The framework uses `Object` for maximum flexibility. You're responsible for casting:

```apex
public override Object execute() {
    // Safe casting with null check
    Integer count = this.dataPassthrough != null ? 
        (Integer) this.dataPassthrough : 0;
    
    // Return appropriate type for next step
    return count + 1;
}
```

### Complex Data Structures

You can pass complex objects between steps:

```apex
public class ProcessData {
    public String accountId;
    public Integer count;
    public List<String> results;
}

public override Object execute() {
    ProcessData data = (ProcessData) this.dataPassthrough;
    // Process the data...
    
    ProcessData nextData = new ProcessData();
    nextData.accountId = data.accountId;
    nextData.count = data.count + 1;
    nextData.results = new List<String>{'Step completed'};
    
    return nextData;
}
```

## Error Handling

### Per-Step Error Handling

Override the `handleException()` method for custom error handling:

```apex
public class MyProcessStep extends QueueableProcess {
    public override Object execute() {
        // Your logic that might throw an exception
        return result;
    }
    
    public override void handleException(Exception e) {
        // Custom error handling for this step
        Log.get().publish(new LogMessage('Step failed: ' + e.getMessage()));
        
        // You could also create compensating transactions,
        // send notifications, etc.
    }
}
```

### Global Error Handling

If a step doesn't implement `handleException()`, the framework falls back to the default handler, which logs the exception.

### Error Recovery

When an exception occurs:
1. The framework identifies the failing step
2. Calls the step's `handleException()` method if implemented
3. Falls back to default handling if not implemented
4. The process chain stops execution

## Best Practices

### 1. Keep Steps Focused

Each step should have a single responsibility:

```apex
// Good: Focused responsibility
public class ValidateAccountStep extends QueueableProcess {
    public override Object execute() {
        // Only validate account data
        return validationResult;
    }
}

// Avoid: Multiple responsibilities
public class ProcessAccountAndSendEmailAndUpdateRecords extends QueueableProcess {
    // Too much in one step
}
```

### 2. Handle Null Data Gracefully

Always check for null data from previous steps:

```apex
public override Object execute() {
    String data = this.dataPassthrough != null ? 
        (String) this.dataPassthrough : 'default';
    
    // Continue processing...
    return result;
}
```

### 3. Use Meaningful Return Values

Return data that the next step actually needs:

```apex
public override Object execute() {
    Account acc = processAccount();
    
    // Return what the next step needs, not everything
    return acc.Id; // If next step only needs the ID
    
    // Or return a structured object for complex data
    return new ProcessResult(acc.Id, acc.Name, someCalculatedValue);
}
```

### 4. Implement Error Handling

Always implement error handling for production code:

```apex
public override void handleException(Exception e) {
    // Log the error
    Log.get().publish(new LogMessage('Process failed', e));
    
    // Handle cleanup or notifications
    notifyAdministrators(e);
    
    // Don't throw from here unless you want to escalate
}
```

### 5. Use Descriptive Class Names

Name your steps clearly to indicate their purpose:

```apex
public class ValidateAccountDataStep extends QueueableProcess { }
public class CalculateCommissionStep extends QueueableProcess { }
public class SendWelcomeEmailStep extends QueueableProcess { }
```

## Examples

### Example 1: Account Processing Chain

```apex
public class AccountProcessingExample {
    public static void processAccount(Id accountId) {
        QueueableProcess process = new ValidateAccountStep(accountId)
            .then(new CalculateMetricsStep(accountId))
            .then(new UpdateRelatedRecordsStep(accountId))
            .then(new SendNotificationStep(accountId));
            
        process.start(accountId);
    }
}

public class ValidateAccountStep extends QueueableProcess {
    private Id accountId;
    
    public ValidateAccountStep() {}
    
    public ValidateAccountStep(Id accountId) {
        this.accountId = accountId;
    }
    
    public override Object execute() {
        Account acc = [SELECT Id, Name, Type FROM Account WHERE Id = :accountId];
        
        if (String.isBlank(acc.Name)) {
            throw new ProcessException('Account name is required');
        }
        
        return new ValidationResult(true, 'Account validated');
    }
}
```

### Example 2: Data Processing with Accumulation

```apex
public class DataProcessingChain {
    public static void processData() {
        QueueableProcess process = new LoadDataStep()
            .then(new TransformDataStep())
            .then(new ValidateDataStep())
            .then(new SaveDataStep());
            
        process.start(null);
    }
}

public class LoadDataStep extends QueueableProcess {
    public LoadDataStep() {}
    
    public override Object execute() {
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 100];
        return accounts;
    }
}

public class TransformDataStep extends QueueableProcess {
    public TransformDataStep() {}
    
    public override Object execute() {
        List<Account> accounts = (List<Account>) this.dataPassthrough;
        
        for (Account acc : accounts) {
            acc.Name = acc.Name.toUpperCase();
        }
        
        return accounts;
    }
}
```

### Example 3: Error Handling and Recovery

```apex
public class RobustProcessStep extends QueueableProcess {
    private String recordId;
    
    public RobustProcessStep() {}
    
    public RobustProcessStep(String recordId) {
        this.recordId = recordId;
    }
    
    public override Object execute() {
        try {
            // Risky operation
            Account acc = [SELECT Id FROM Account WHERE Id = :recordId];
            acc.Name = 'Updated';
            update acc;
            
            return 'Success';
        } catch (DmlException e) {
            // Let the framework handle this
            throw new ProcessException('Failed to update account: ' + e.getMessage());
        }
    }
    
    public override void handleException(Exception e) {
        // Log the error
        System.debug('Step failed: ' + e.getMessage());
        
        // Create a compensating transaction
        createErrorRecord(recordId, e.getMessage());
        
        // Notify administrators
        sendErrorNotification(e);
    }
    
    private void createErrorRecord(String recordId, String errorMessage) {
        // Implementation to track the error
    }
    
    private void sendErrorNotification(Exception e) {
        // Implementation to notify admins
    }
}
```

## API Reference

For detailed API documentation, refer to the QueueableProcess class documentation.

### Common Patterns

#### Conditional Step Execution

```apex
public override Object execute() {
    String condition = (String) this.dataPassthrough;
    
    if (condition == 'proceed') {
        // Normal processing
        return processNormally();
    } else {
        // Skip processing but pass data through
        return this.dataPassthrough;
    }
}
```

#### Step Validation

```apex
public override Object execute() {
    if (this.dataPassthrough == null) {
        throw new ProcessException('No data received from previous step');
    }
    
    ProcessData data = (ProcessData) this.dataPassthrough;
    if (String.isBlank(data.accountId)) {
        throw new ProcessException('Account ID is required');
    }
    
    // Continue processing...
    return result;
}
```

## Troubleshooting

### Common Issues

1. **Missing No-Arg Constructor**: Ensure every step has a parameterless constructor
2. **Null Data Handling**: Always check for null before casting `dataPassthrough`
3. **Exception Propagation**: Exceptions stop the chain unless handled
4. **Governor Limits**: Each step runs in its own transaction context

### Debugging Tips

1. Use the execution histories to trace process flow
2. Implement comprehensive error handling with logging
3. Test each step individually before chaining
4. Use smaller data sets for testing complex chains

This framework provides a powerful way to build complex asynchronous processes in Salesforce while maintaining clean, testable code. Follow the patterns and best practices outlined above for optimal results.