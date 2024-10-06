`SUPPRESSWARNINGS`

`APIVERSION: 58`

`STATUS: ACTIVE`

This is a set of tests, unit and profile based for the SObject and User factories.
These _require_

## Methods

### `private static void profilingTestCreate10IndividualSObjectAccountNoInsertPositive()`

`ISTEST`

### `private static void profilingTestCreate10IndividualSObjectAccountNoInsertWithCustomDefaultsPositive()`

`ISTEST`

### `private static void profilingTestCreate10IndividualSObjectAccountWithInsertPositive()`

`ISTEST`

### `private static void profilingTestCreateListOf200SObjectsNoInsertPositive()`

`ISTEST`

### `private static void profilingTestCreateListOf200SObjectsWithInsertPositive()`

`ISTEST`

### `private static void funcTestCreateSObjectsWith200AccountsNoCustomDefaultsPositive()`

`ISTEST`

### `private static void funcTestCreateSObjectsWith200AccountsWithCustomDefaultsPositive()`

`ISTEST`

### `private static void funcTestCreateSObjectsWith200AccountsWithCustomDefaultsProvesUniqueIdsPositive()`

`ISTEST`

### `private static void funcTestCreateSObjectWithAccountAndInsertPositive()`

## `ISTEST`

## Classes

### SomeDefaultsClass

this is an example custom defaults class to instantiate in the tests

**Implemented types**

[SObjectFactory.FieldDefaults](SObjectFactory.FieldDefaults)

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface required method specifying field defaults

###### Returns

| Type                                    | Description                                                                 |
| --------------------------------------- | --------------------------------------------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | Map&lt;Schema.SObjectField, Object&gt; map of field names to default vaules |

---

---
