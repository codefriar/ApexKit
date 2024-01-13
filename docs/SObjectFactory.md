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

**See** [SObjectFactoryHelper](https://github.com/codefriar/ApexKit/wiki/SObjectFactoryHelper)

**See** [SObjectFactoryDefaults](https://github.com/codefriar/ApexKit/wiki/SObjectFactoryDefaults)

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

#### Example

```apex
`Account testAccount = (Account) SObjectFactory.createSObject(new Account());`
```

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

#### Example

```apex
`Account testAccount = (Account) SObjectFactory.createSObject(new Account(), 'SomeDefaultsClass');`
```

### `public static SObject createSObject(SObject prototype, Boolean forceInsert)`

Create sObject variant supporting just the prototype and forceInsert params.

#### Parameters

| Param         | Description                                                                             |
| ------------- | --------------------------------------------------------------------------------------- |
| `prototype`   | SObject any SObject to create the SObject from                                          |
| `forceInsert` | Boolean if true, results in the record being inserted before returning from the method. |

#### Returns

| Type      | Description                                          |
| --------- | ---------------------------------------------------- |
| `SObject` | A created SObject with the required fields populated |

#### Example

```apex
`Account testAccount = (Account) SObjectFactory.createSObject(new Account(), true);`
```

### `public static SObject createSObject(SObject prototype, String usingDefaultsClassName, Boolean forceInsert)`

Create SObject variant supporting prototype, custom defaults class and the forceInsert boolean

#### Parameters

| Param                    | Description                                                                               |
| ------------------------ | ----------------------------------------------------------------------------------------- |
| `prototype`              | SObject the prototype sobject to start from                                               |
| `usingDefaultsClassName` | String name of the class to instantiate for defaults                                      |
| `forceInsert`            | Boolean if true, results in the record being inserted prior to returning from the method. |

#### Returns

| Type      | Description                                          |
| --------- | ---------------------------------------------------- |
| `SObject` | A Created SObject with the required fields populated |

#### Example

```apex
`Account testAccount = (Account) SObjectFactory.createSObject(new Account(), );`
```

### `private static SObject internalCreateSObject(SObject prototype, String usingDefaultsClassName)`

This is an internal version of the createSObject method used by the param-complete public version of createSObject, and consequently by every method in this class. It's responsible for applying default values to fields in the following order: 1. Custom Default class, if specified 2. The 'org wide' defaults stored in SObjectFactoryDefaults' subclasses.

#### Parameters

| Param                    | Description                                                   |
| ------------------------ | ------------------------------------------------------------- |
| `prototype`              | SObject the prototype object to start from                    |
| `usingDefaultsClassName` | String the name of a Defaults Class to attempt to instantiate |

#### Returns

| Type      | Description                                                  |
| --------- | ------------------------------------------------------------ |
| `SObject` | SObject A Created SObject with the required fields populated |

### `public static List<SObject> createSObjects(SObject prototype, Integer count)`

A method to generate a list of SObjects from a single prototype supporting just the prototype, and count params.

#### Parameters

| Param       | Description                                |
| ----------- | ------------------------------------------ |
| `prototype` | SObject The prototype object to build from |
| `count`     | Integer number of objects to generate      |

#### Returns

| Type            | Description                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------- |
| `List<SObject>` | List<SObject> A generated list of constructed SObjects with default field values specified. |

#### Example

```apex
`List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200);`
```

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName)`

A method to generate a list of SObjects from a single prototype supporting just the prototype, count and custom default params

#### Parameters

| Param                    | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| `prototype`              | SObject The prototype object to build from                   |
| `count`                  | Integer number of objects to generate                        |
| `usingDefaultsClassName` | String the name of a class to instantiate for default values |

#### Returns

| Type            | Description                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------- |
| `List<SObject>` | List<SObject> A generated list of constructed SObjects with default field values specified. |

#### Example

```apex
`List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, 'SomeDefaultsClass');`
```

### `public static List<SObject> createSObjects(SObject prototype, Integer count, Boolean forceInsert)`

A method to generate a list of SObjects from a single prototype supporting just the prototype, count and forceInsert params

#### Parameters

| Param         | Description                                                                             |
| ------------- | --------------------------------------------------------------------------------------- |
| `prototype`   | SObject The prototype object to build from                                              |
| `count`       | Integer number of objects to generate                                                   |
| `forceInsert` | Boolean If true, results in the list being inserted before the method returns the list. |

#### Returns

| Type            | Description                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------- |
| `List<SObject>` | List<SObject> A generated list of constructed SObjects with default field values specified. |

#### Example

```apex
`List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, false);`
```

### `public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName, Boolean forceInsert)`

A method to generate a list of SObjects from a single prototype

#### Parameters

| Param                    | Description                                                                             |
| ------------------------ | --------------------------------------------------------------------------------------- |
| `prototype`              | SObject The prototype object to build from                                              |
| `count`                  | Integer number of objects to generate                                                   |
| `usingDefaultsClassName` | String name of a class to instantiate for custom default values                         |
| `forceInsert`            | Boolean If true, results in the list being inserted before the method returns the list. |

#### Returns

| Type            | Description                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------- |
| `List<SObject>` | List<SObject> A generated list of constructed SObjects with default field values specified. |

#### Example

```apex
`List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, 'SomeDefaultsClass', false);`
```

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
