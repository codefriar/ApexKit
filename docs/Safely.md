## Fields

### `allOrNothing`

`TESTVISIBLE`

#### Signature

```apex
private allOrNothing
```

#### Type

Boolean

---

### `throwIfRemovedFields`

`TESTVISIBLE`

#### Signature

```apex
private throwIfRemovedFields
```

#### Type

Boolean

## Methods

### `allOrNothing()`

Triggers the flag to throw an exception if fields are removed

#### Signature

```apex
public Safely allOrNothing()
```

#### Return Type

**[Safely](Safely.md)**

Safely - the current instance of the Safely class

---

### `throwIfRemovedFields()`

Sets the throwIfRemovedFields flag to true

#### Signature

```apex
public Safely throwIfRemovedFields()
```

#### Return Type

**[Safely](Safely.md)**

Safely - the current instance of the Safely class

---

### `doInsert(records)`

A method for safely inserting a list of records

#### Signature

```apex
public List<Database.SaveResult> doInsert(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description           |
| ------- | ------------------- | --------------------- |
| records | List&lt;SObject&gt; | the records to insert |

#### Return Type

**List&lt;Database.SaveResult&gt;**

List&lt;Database.saveResult&gt; - the results of the insert

---

### `doInsert(record)`

A method for safely inserting a single record

#### Signature

```apex
public List<Database.SaveResult> doInsert(SObject record)
```

#### Parameters

| Name   | Type    | Description                    |
| ------ | ------- | ------------------------------ |
| record | SObject | SObject - the record to insert |

#### Return Type

**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - the results of the insert

---

### `doUpdate(records)`

A method for safely updating a list of records

#### Signature

```apex
public List<Database.SaveResult> doUpdate(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                 |
| ------- | ------------------- | ------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; - the records to update |

#### Return Type

**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - the results of the update

---

### `doUpdate(record)`

a method for safely updating a single record

#### Signature

```apex
public List<Database.SaveResult> doUpdate(SObject record)
```

#### Parameters

| Name   | Type    | Description                    |
| ------ | ------- | ------------------------------ |
| record | SObject | SObject - the record to update |

#### Return Type

**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - the results of the update

---

### `doUpsert(records)`

A method for safely upserting a list of records

#### Signature

```apex
public List<Database.UpsertResult> doUpsert(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                 |
| ------- | ------------------- | ------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; - the records to upsert |

#### Return Type

**List&lt;Database.UpsertResult&gt;**

List&lt;Database.UpsertResult&gt; - the results of the upsert

---

### `doUpsert(record)`

a method for safely upserting a single record

#### Signature

```apex
public List<Database.UpsertResult> doUpsert(SObject record)
```

#### Parameters

| Name   | Type    | Description                    |
| ------ | ------- | ------------------------------ |
| record | SObject | SObject - the record to upsert |

#### Return Type

**List&lt;Database.UpsertResult&gt;**

List&lt;Database.UpsertResult&gt; - the results of the upsert

---

### `doDelete(records)`

a method for safely deleting a list of records

#### Signature

```apex
public List<Database.DeleteResult> doDelete(List<SObject> records)
```

#### Parameters

| Name    | Type                | Description                                 |
| ------- | ------------------- | ------------------------------------------- |
| records | List&lt;SObject&gt; | List&lt;SObject&gt; - the records to delete |

#### Return Type

**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - the results of the delete

---

### `doDelete(record)`

a method for safely deleting a single record

#### Signature

```apex
public List<Database.DeleteResult> doDelete(SObject record)
```

#### Parameters

| Name   | Type    | Description                    |
| ------ | ------- | ------------------------------ |
| record | SObject | SOBject - the record to delete |

#### Return Type

**List&lt;Database.DeleteResult&gt;**

List&lt;Database.DeleteResult&gt; - the results of the delete call

---

### `doQuery(query)`

A method for safely querying records

#### Signature

```apex
public List<SObject> doQuery(String query)
```

#### Parameters

| Name  | Type   | Description                   |
| ----- | ------ | ----------------------------- |
| query | String | String - the query to execute |

#### Return Type

**List&lt;SObject&gt;**

List&lt;SObject&gt; - the results of the query

---

### `doDML(accessType, records)`

A method for safely performing DML

#### Signature

```apex
private List<Database.SaveResult> doDML(System.AccessType accessType, List<SObject> records)
```

#### Parameters

| Name       | Type                | Description                                                                |
| ---------- | ------------------- | -------------------------------------------------------------------------- |
| accessType | System.AccessType   | AccessType - the type of access to check for                               |
| records    | List&lt;SObject&gt; | List&lt;SObject&gt; - the records to perform a Security Access Decision on |

#### Return Type

**List&lt;Database.SaveResult&gt;**

List&lt;Database.SaveResult&gt; - the results of the DML call

---

### `guardAgainstRemovedFields(accessType, records)`

method guards against removed fields by throwing an exception, if throwIfRemovedFields is enabled

#### Signature

```apex
private SObjectAccessDecision guardAgainstRemovedFields(System.AccessType accessType, List<SObject> records)
```

#### Parameters

| Name       | Type                | Description                                                                |
| ---------- | ------------------- | -------------------------------------------------------------------------- |
| accessType | System.AccessType   | AccessType - the type of access to check for                               |
| records    | List&lt;SObject&gt; | List&lt;SObject&gt; - the records to perform a Security Access Decision on |

#### Return Type

**SObjectAccessDecision**

SObjectAccessDecision - the results of the Security Access Decision

## Classes

### RemovedFieldsException Class

A custom exception that is thrown from the safely class
