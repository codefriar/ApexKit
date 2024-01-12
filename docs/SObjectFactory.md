`APIVERSION: 58`

`STATUS: ACTIVE`

a factory class for generating test data.
This class auto populates required fields and, by default, generates a plausible but fake ID for the record.
You can use this class directly, or use one of the associated builder classes for generating
complex data structures.
This class has the ability to set default values for fields in 3, hierarchical ways.

1. The default values passed into the SObjectFactory via the sObject prototype.
2. The default values defined by the custom default class specified by the usingDefaultsClassName parameter.
3. The default values found in the 'org-wide' defaults class defined in the SObjectFactoryDefaults' subclasses.
   It's important to note that _nothing_ overwrites field values specified in the SObject prototype.
   Some profiling information:
   | Action | Avg of 10 test executions |
   |-----------|------------------------|
   | Create 10 Single SObject w/ fake Id | 58ms |
   | Create 10 Single SObjects w/ fake Id and Custom Defaults | 73ms |
   | Create 10 Single SObjects & insert them | 550ms |
   | Create list of 200 SObjects w/ fake Id | 115ms |
   | Create list of 200 SObjects & insert them | 1216ms |

## Methods

### `public static SObject createSObject(SObject prototype)`

convenience method allowing you to specify just the prototype

#### Parameters

| Param       | Description         |
| ----------- | ------------------- |
| `prototype` | SObject any SObject |

#### Returns

| Type      | Description                                      |
| --------- | ------------------------------------------------ |
| `SObject` | A created SObject with required fields populated |

### `public static SObject createSObject(SObject prototype, String usingDefaultsClassName)`

Convenience method for creating SObjects using just the prototype and a custom defaults class

#### Parameters

| Param                    | Description                                                     |
| ------------------------ | --------------------------------------------------------------- |
| `prototype`              | SObject - any constructed SObject                               |
| `usingDefaultsClassName` | String - the name of the class to use for custom default values |

#### Returns

| Type      | Description                                      |
| --------- | ------------------------------------------------ |
| `SObject` | A created SObject with required fields populated |

### `public static SObject createSObject(SObject prototype, Boolean forceInsert)`

### `public static SObject createSObject(SObject prototype, String usingDefaultsClassName, Boolean forceInsert)`

### `private static SObject internalCreateSObject(SObject prototype, String usingDefaultsClassName)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count, Boolean forceInsert)`

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName, Boolean forceInsert)`

---

## Interfaces

### FieldDefaults

Use the FieldDefaults interface to set up field/value keys you want to routinely impose on your
factory generated objects.

#### Methods

##### `public Map&lt;Schema.SObjectField,Object&gt; getFieldDefaults()`

Interface used by implementing classes to define defaults.

###### Returns

| Type                                    | Description                              |
| --------------------------------------- | ---------------------------------------- |
| `Map&lt;Schema.SObjectField,Object&gt;` | `Map&lt;Schema.SObjectField, Object&gt;` |

---
