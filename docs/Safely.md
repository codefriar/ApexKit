`STATUS: ACTIVE`

Class wraps DML Calls in FLS / Crud checks.

## Fields

### `private allOrNothing` → `Boolean`

`TESTVISIBLE`

### `private throwIfRemovedFields` → `Boolean`

`TESTVISIBLE`

---

## Methods

### `public Safely allOrNothing()`

Triggers the flag to throw an exception if fields are removed

#### Returns

| Type     | Description                                       |
| -------- | ------------------------------------------------- |
| `Safely` | Safely - the current instance of the Safely class |

### `public Safely throwIfRemovedFields()`

Sets the throwIfRemovedFields flag to true

#### Returns

| Type     | Description                                       |
| -------- | ------------------------------------------------- |
| `Safely` | Safely - the current instance of the Safely class |

### `public List<Database.SaveResult> doInsert(List<SObject> records)`

A method for safely inserting a list of records

#### Parameters

| Param     | Description           |
| --------- | --------------------- |
| `records` | the records to insert |

#### Returns

| Type                        | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| `List<Database.SaveResult>` | List<Database.saveResult> - the results of the insert |

### `public List<Database.SaveResult> doInsert(SObject record)`

A method for safely inserting a single record

#### Parameters

| Param    | Description                    |
| -------- | ------------------------------ |
| `record` | SObject - the record to insert |

#### Returns

| Type                        | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| `List<Database.SaveResult>` | List<Database.SaveResult> - the results of the insert |

### `public List<Database.SaveResult> doUpdate(List<SObject> records)`

A method for safely updating a list of records

#### Parameters

| Param     | Description                           |
| --------- | ------------------------------------- |
| `records` | List<SObject> - the records to update |

#### Returns

| Type                        | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| `List<Database.SaveResult>` | List<Database.SaveResult> - the results of the update |

### `public List<Database.SaveResult> doUpdate(SObject record)`

a method for safely updating a single record

#### Parameters

| Param    | Description                    |
| -------- | ------------------------------ |
| `record` | SObject - the record to update |

#### Returns

| Type                        | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| `List<Database.SaveResult>` | List<Database.SaveResult> - the results of the update |

### `public List<Database.UpsertResult> doUpsert(List<SObject> records)`

A method for safely upserting a list of records

#### Parameters

| Param     | Description                           |
| --------- | ------------------------------------- |
| `records` | List<SObject> - the records to upsert |

#### Returns

| Type                          | Description                                             |
| ----------------------------- | ------------------------------------------------------- |
| `List<Database.UpsertResult>` | List<Database.UpsertResult> - the results of the upsert |

### `public List<Database.UpsertResult> doUpsert(SObject record)`

a method for safely upserting a single record

#### Parameters

| Param    | Description                    |
| -------- | ------------------------------ |
| `record` | SObject - the record to upsert |

#### Returns

| Type                          | Description                                             |
| ----------------------------- | ------------------------------------------------------- |
| `List<Database.UpsertResult>` | List<Database.UpsertResult> - the results of the upsert |

### `public List<Database.DeleteResult> doDelete(List<SObject> records)`

a method for safely deleting a list of records

#### Parameters

| Param     | Description                           |
| --------- | ------------------------------------- |
| `records` | List<SObject> - the records to delete |

#### Returns

| Type                          | Description                                             |
| ----------------------------- | ------------------------------------------------------- |
| `List<Database.DeleteResult>` | List<Database.DeleteResult> - the results of the delete |

### `public List<Database.DeleteResult> doDelete(SObject record)`

a method for safely deleting a single record

#### Parameters

| Param    | Description                    |
| -------- | ------------------------------ |
| `record` | SOBject - the record to delete |

#### Returns

| Type                          | Description                                                  |
| ----------------------------- | ------------------------------------------------------------ |
| `List<Database.DeleteResult>` | List<Database.DeleteResult> - the results of the delete call |

### `public List<SObject> doQuery(String query)`

A method for safely querying records

#### Parameters

| Param   | Description                   |
| ------- | ----------------------------- |
| `query` | String - the query to execute |

#### Returns

| Type            | Description                              |
| --------------- | ---------------------------------------- |
| `List<SObject>` | List<SObject> - the results of the query |

### `private List<Database.SaveResult> doDML(System accessType, List<SObject> records)`

A method for safely performing DML

#### Parameters

| Param        | Description                                                          |
| ------------ | -------------------------------------------------------------------- |
| `accessType` | AccessType - the type of access to check for                         |
| `records`    | List<SObject> - the records to perform a Security Access Decision on |

#### Returns

| Type                        | Description                                             |
| --------------------------- | ------------------------------------------------------- |
| `List<Database.SaveResult>` | List<Database.SaveResult> - the results of the DML call |

### `private SObjectAccessDecision guardAgainstRemovedFields(System accessType, List<SObject> records)`

method guards against removed fields by throwing an exception, if throwIfRemovedFields is enabled

#### Parameters

| Param        | Description                                                          |
| ------------ | -------------------------------------------------------------------- |
| `accessType` | AccessType - the type of access to check for                         |
| `records`    | List<SObject> - the records to perform a Security Access Decision on |

#### Returns

| Type                    | Description                                                         |
| ----------------------- | ------------------------------------------------------------------- |
| `SObjectAccessDecision` | SObjectAccessDecision - the results of the Security Access Decision |

---

## Classes

### RemovedFieldsException

A custom exception that is thrown from the safely class

**Inheritance**

RemovedFieldsException

---
