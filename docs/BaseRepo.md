Virtual base repository that every Repository must extend from. This class provides base implementations for common repository CRUD operations.
More specific implementations must be added to the extending classes.
No SObject specific queries are to be added to this base class. SObject specific queries are to be added to the extending classes.
All SObject specific queries are to be done WITH USER_MODE.
All SObject specific queries are to contain a Limit Statement.

There are now overloads provided for all DML operations that allow unsafe DML operations to be performed
but they require certain criteria be met as follows.

1. Create an instance of this class using the overloaded constructor to permit unsafe DML operations.
2. The calling code must provide an

**Justification**

ApexDoc annotation explaining why unsafe DML is required. 3. The code must be reviewed &amp; approved.

## Fields

### `sObjectType`

`TESTVISIBLE`

SObject type of the repo.

#### Signature

```apex
private final sObjectType
```

#### Type

Schema.SObjectType

---

### `defaultSelectFields`

defaultFields set in the fetchById methods.

#### Signature

```apex
protected defaultSelectFields
```

#### Type

Set&lt;String&gt;

## Properties

### `allOrNone`

Boolean Sets the all Or none unless users explicitly set the allOrNone member to false, logic for the Create update upsert and delete methods.

#### Signature

```apex
public allOrNone
```

#### Type

Boolean

---

### `allowUnsafe`

Boolean Sets the allowUnsafe switch to true to allow, with required justifications, unsafe DML operations.
Defaults to false

#### Signature

```apex
private final allowUnsafe
```

#### Type

Boolean

## Constructors

### `BaseRepo(sObjectType)`

Constructor for virtual base repository. Sets the allOrNone boolean for DML to true by default
and allowUnsafe to false by default, prohibiting DML statements executed in System Mode.

#### Signature

```apex
protected BaseRepo(Schema.SObjectType sObjectType)
```

#### Parameters

| Name        | Type               | Description                                                               |
| ----------- | ------------------ | ------------------------------------------------------------------------- |
| sObjectType | Schema.SObjectType | String determines the sObjectType that the Repository is associated with. |

---

### `BaseRepo(sObjectType, allowUnsafe)`

Constructor for virtual base repository. Sets the allOrNone boolean for DML to true by default
and allowUnsafe to input parameter.

#### Signature

```apex
protected BaseRepo(Schema.SObjectType sObjectType, Boolean allowUnsafe)
```

#### Parameters

| Name        | Type               | Description                                                                                                                                                                                                    |
| ----------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| sObjectType | Schema.SObjectType | String determines the sObjectType that the Repository is associated with.                                                                                                                                      |
| allowUnsafe | Boolean            | Boolean that dictates if unsafe DML operations are allowed for this Repo instance.,[object Object], By default, it is false so this overloading of ctor is only required when unsafe DML is required (so true) |

## Methods

### `fetchById(recordId)`

gets a record with the ID passed into the method.

#### Signature

```apex
public SObject fetchById(Id recordId)
```

#### Parameters

| Name     | Type | Description                        |
| -------- | ---- | ---------------------------------- |
| recordId | Id   | Id of the record we want to fetch. |

#### Return Type

**SObject**

SObject

---

### `fetchById(recordId, additionalFields)`

gets a record with the ID passed into the method.

#### Signature

```apex
public SObject fetchById(Id recordId, Set<String> additionalFields)
```

#### Parameters

| Name             | Type              | Description                                                              |
| ---------------- | ----------------- | ------------------------------------------------------------------------ |
| recordId         | Id                | Id of the record we want to fetch.                                       |
| additionalFields | Set&lt;String&gt; | Set&lt;String&gt; Additional fields that get added the select statement. |

#### Return Type

**SObject**

SObject

---

### `fetch(queryString, bindParams)`

Safely queries the database enforces UserMode.

#### Signature

```apex
protected SObject fetch(String queryString, Map<String,Object> bindParams)
```

#### Parameters

| Name        | Type                     | Description                                                                                                                                   |
| ----------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| queryString | String                   | query string passed to the database method.                                                                                                   |
| bindParams  | Map&lt;String,Object&gt; | Map&lt;String, Object&gt; key value map that binds the key to the value in the query. e.g &#x27;recordId&#x27; &#x3D;&gt; &#x27;abcdefg&#x27; |

#### Return Type

**SObject**

SObject[] Collection of SObject records.

---

### `fetch(queryString)`

Safely queries the database enforces UserMode.

#### Signature

```apex
protected SObject fetch(String queryString)
```

#### Parameters

| Name        | Type   | Description                                 |
| ----------- | ------ | ------------------------------------------- |
| queryString | String | query string passed to the database method. |

#### Return Type

**SObject**

SObject[] Collection of SObject records.

---

### `calculateSelectClause(fields)`

Calculates the select clause by joining the strings in the defaultSelectFields List with commas.

#### Signature

```apex
protected String calculateSelectClause(Set<String> fields)
```

#### Parameters

| Name   | Type              | Description                                                |
| ------ | ----------------- | ---------------------------------------------------------- |
| fields | Set&lt;String&gt; | Set&lt;String&gt; fields to be added to the select clause. |

#### Return Type

**String**

String Returns SELECT Field1, Field2.... statement

---

### `calculateFromClause()`

Utility for generating the FROM Clase

#### Signature

```apex
protected String calculateFromClause()
```

#### Return Type

**String**

String returns the FROM OBJECT clause.

---

### `doCreate(records)`

Bulk insert method that can be overridden. Assures that all inserts are all or none and run in the context of the running user.

#### Signature

```apex
public virtual Database.SaveResult doCreate(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                                 |
| ------- | ------------------- | ----------------------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; list of SObject records to be inserted. |

#### Return Type

**Database.SaveResult**

Database.SaveResult[] Save results that contain info on the transaction.

---

### `doCreate(record)`

Singular insert method that can be overridden. Assures that all inserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.SaveResult doCreate(SObject record)
```

#### Parameters

| Name   | Type    | Description                   |
| ------ | ------- | ----------------------------- |
| record | SObject | SObject record to be inserted |

#### Return Type

**Database.SaveResult**

Database.SaveResult Singular Save Result that contains info on the transaction.

---

### `doUpdate(records)`

Bulk update method that can be overridden. Assures that all updates are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.SaveResult doUpdate(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                               |
| ------- | ------------------- | ----------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be updated |

#### Return Type

**Database.SaveResult**

Database.SaveResult[] Save results that contain info on the transaction.

---

### `doUpdate(record)`

singular method that can be overridden. Assures that all updates are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.SaveResult doUpdate(SObject record)
```

#### Parameters

| Name   | Type    | Description                   |
| ------ | ------- | ----------------------------- |
| record | SObject | SObject record to be updated. |

#### Return Type

**Database.SaveResult**

Database.SaveResult Singular Save Result that contains info on the transaction.

---

### `doUpsert(records)`

Bulk method that can be overridden. Assures that all upserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.UpsertResult doUpsert(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                 |
| ------- | ------------------- | ------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be upserted. |

#### Return Type

**Database.UpsertResult**

Database.UpsertResult[] Upsert results that contain info on the transaction.

---

### `doUpsert(record)`

Singular method that can be overridden. Assures that all upserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.UpsertResult doUpsert(SObject record)
```

#### Parameters

| Name   | Type    | Description                   |
| ------ | ------- | ----------------------------- |
| record | SObject | SObject record to be upserted |

#### Return Type

**Database.UpsertResult**

Database.UpsertResult Singular upsert result that contains info on the transaction.

---

### `doDelete(records)`

Bulk method for record deletion that can be overridden. Assures all deletes are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.DeleteResult doDelete(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                               |
| ------- | ------------------- | ----------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be deleted |

#### Return Type

**Database.DeleteResult**

Database.DeleteResult[] Delete results that contain info on the transaction.

---

### `doDelete(record)`

Singular method for record deletion that can be overridden. Assures all deletes are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.

#### Signature

```apex
public virtual Database.DeleteResult doDelete(SObject record)
```

#### Parameters

| Name   | Type    | Description                  |
| ------ | ------- | ---------------------------- |
| record | SObject | SObject record to be deleted |

#### Return Type

**Database.DeleteResult**

Database.DeleteResult Singular Delete result that contains info on the transaction.

---

### `fetchByIdUnsafe(recordId)`

Overloads for all DML methods to execute in SYSTEM_MODE (unsafe mode). These methods should be
used judiciously and require valid reason and approval to ensure there are no alternative options.
Explicitly, they require the invoking code to be annotated in ApexDoc with custom annotation
justification providing a description as to the need for unsafe DML operation.

#### Signature

```apex
protected SObject fetchByIdUnsafe(Id recordId)
```

#### Parameters

| Name     | Type | Description |
| -------- | ---- | ----------- |
| recordId | Id   |             |

#### Return Type

**SObject**

---

### `fetchByIdUnsafe(recordId, additionalFields)`

gets a record with the ID passed into the method, query executed in SYSTEM_MODE.
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected SObject fetchByIdUnsafe(Id recordId, Set<String> additionalFields)
```

#### Parameters

| Name             | Type              | Description                                                              |
| ---------------- | ----------------- | ------------------------------------------------------------------------ |
| recordId         | Id                | Id of the record we want to fetch.                                       |
| additionalFields | Set&lt;String&gt; | Set&lt;String&gt; Additional fields that get added the select statement. |

#### Return Type

**SObject**

SObject containing the requested additionalFields and default fields for our SObject.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `fetchUnsafe(queryString, bindParams)`

Queries the database explicitly overriding User Mode

#### Signature

```apex
protected SObject fetchUnsafe(String queryString, Map<String,Object> bindParams)
```

#### Parameters

| Name        | Type                     | Description                                                                                                                                   |
| ----------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| queryString | String                   | query string passed to the database method.                                                                                                   |
| bindParams  | Map&lt;String,Object&gt; | Map&lt;String, Object&gt; key value map that binds the key to the value in the query. e.g &#x27;recordId&#x27; &#x3D;&gt; &#x27;abcdefg&#x27; |

#### Return Type

**SObject**

SObject[] Collection of SObject records.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `fetchUnsafe(queryString)`

Queries the database explicitly overriding User Mode.
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected SObject fetchUnsafe(String queryString)
```

#### Parameters

| Name        | Type   | Description                                 |
| ----------- | ------ | ------------------------------------------- |
| queryString | String | query string passed to the database method. |

#### Return Type

**SObject**

SObject[] Collection of SObject records.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doCreateUnsafe(records)`

Bulk insert method that can be overridden. Assures that all inserts are all or none
and runs in system context, overriding the standard USER_MODE requirement.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.SaveResult doCreateUnsafe(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                                 |
| ------- | ------------------- | ----------------------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; list of SObject records to be inserted. |

#### Return Type

**Database.SaveResult**

Database.SaveResult[] Save results that contain info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doCreateUnsafe(record)`

Bulk insert method that can be overridden. Insert is executed in the system context
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.SaveResult doCreateUnsafe(SObject record)
```

#### Parameters

| Name   | Type    | Description                    |
| ------ | ------- | ------------------------------ |
| record | SObject | SObject record to be inserted. |

#### Return Type

**Database.SaveResult**

Database.SaveResult Save results that contain info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doUpdateUnsafe(records)`

Bulk update method that can be overridden. Assures that all updates are all or none
unless users explicitly set the allOrNone member to false, and run in system context
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.SaveResult doUpdateUnsafe(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                               |
| ------- | ------------------- | ----------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be updated |

#### Return Type

**Database.SaveResult**

Database.SaveResult[] Save results that contains info on the transactions.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doUpdateUnsafe(record)`

Bulk insert method that can be overridden. Update is executed in the system context
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.SaveResult doUpdateUnsafe(SObject record)
```

#### Parameters

| Name   | Type    | Description                   |
| ------ | ------- | ----------------------------- |
| record | SObject | SObject record to be updated. |

#### Return Type

**Database.SaveResult**

Database.SaveResult Save results that contain info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doUpsertUnsafe(records)`

Bulk method that can be overridden. Assures that all upserts are all or none unless users
explicitly set the allOrNone member to false, and run in system context.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.UpsertResult doUpsertUnsafe(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                 |
| ------- | ------------------- | ------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be upserted. |

#### Return Type

**Database.UpsertResult**

Database.UpsertResult[] Upsert results that contains info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doUpsertUnsafe(record)`

Singular method that can be overridden. Assures that all upserts are all or none unless users
explicitly set the allOrNone member to false, and run in the system context
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.UpsertResult doUpsertUnsafe(SObject record)
```

#### Parameters

| Name   | Type    | Description                   |
| ------ | ------- | ----------------------------- |
| record | SObject | SObject record to be upserted |

#### Return Type

**Database.UpsertResult**

Database.UpsertResult Singular upsert result that contains info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doDeleteUnsafe(records)`

Bulk method for record deletion that can be overridden. Assures all deletes are all or none
unless users explicitly set the allOrNone member to false, and run in system context.

WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.DeleteResult doDeleteUnsafe(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                               |
| ------- | ------------------- | ----------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; records to be deleted |

#### Return Type

**Database.DeleteResult**

Database.DeleteResult[] Delete results that contains info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

---

### `doDeleteUnsafe(record)`

Singular method for record deletion that can be overridden. Assures all deletes are all or none
unless users explicitly set the allOrNone member to false, and run in the system context
NOTE: Checking that allow unsafe operations is enabled in overloaded
method that we invoke.
WARNING: Calling code must provide an

**Justification**

ApexDoc annotation.

#### Signature

```apex
protected Database.DeleteResult doDeleteUnsafe(SObject record)
```

#### Parameters

| Name   | Type    | Description                  |
| ------ | ------- | ---------------------------- |
| record | SObject | SObject record to be deleted |

#### Return Type

**Database.DeleteResult**

Database.DeleteResult Singular Delete result that contains info on the transaction.

#### Throws

UnsafeDmlAttemptedException: if this repository was NOT instantiated with unsafe operations enabled

## Classes

### UnsafeDmlAttemptedException Class

Exception to be thrown when an attempt to execute Unsafe DML is made without configuring
Repo correctly &amp; providing required documentation/config.
