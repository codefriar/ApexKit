`APIVERSION: 58`

`STATUS: ACTIVE`

This class contains helper methods used by the SObjectFactory.
While a bit of an anti-pattern, this class' contents allow SObjectFactory to be more-focused.

**See** [SObjectFactory](https://github.com/codefriar/ApexKit/wiki/SObjectFactory)

## Fields

### `private MEMOIZED_AUTO_NUMBER_NAME_FIELD` → `Map<Schema.SObjectType,Boolean>`

Memoizes the result of a describe call for same-transaction caching

### `private NAME_FIELD_OVERRIDE_MAP` → `Map<Schema.SObjectType,Schema.SObjectField>`

While the vast majority of Salesforce objects have a Name field, some objects do not. This map allows you to override the default name field for a given object type and covers the two standard objects that do not have a name field.

---

## Methods

### `public static SObject mutateCloneToRespectNameAndAutonumberRules(SObject clonedSObject, Boolean fakeId, Integer iterationCounter)`

responsible for enforcing a cloned SObject's values honor uniqueness rules for name and autonumber fields

#### Parameters

| Param              | Description                                                         |
| ------------------ | ------------------------------------------------------------------- |
| `clonedSObject`    | SObject a cloned version of the prototyped SObject                  |
| `fakeId`           | Boolean Populates a fakeId on the object unless it's to be inserted |
| `iterationCounter` | Integer Counter for ensuring name uniqueness                        |

#### Returns

| Type      | Description                                                                           |
| --------- | ------------------------------------------------------------------------------------- |
| `SObject` | SObject a mutated version of the cloned object with unique name and autonumber fields |

### `public static void insertIfForced(List<SObject> objectsToInsert, Boolean forceInsert)`

responsible for inserting a list of SObjects into the database.

#### Parameters

| Param             | Description                                                       |
| ----------------- | ----------------------------------------------------------------- |
| `objectsToInsert` | List<SObject> a list of SObjects to be inserted into the database |
| `forceInsert`     | Boolean a flag to force insert the objects into the database      |

### `public static SObject applyOrgWideObjectDefaults(SObject prototype)`

responsible for applying org-wide field defaults to a SObject.

#### Parameters

| Param       | Description                     |
| ----------- | ------------------------------- |
| `prototype` | SObject a SObject to be mutated |

#### Returns

| Type      | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| `SObject` | SObject a mutated version of the prototype object with field defaults applied |

### `public static SObject applyCustomDefaults(SObject prototype, String usingDefaultsClassName)`

responsible for applying custom field defaults to a SObject.

#### Parameters

| Param                    | Description                                                |
| ------------------------ | ---------------------------------------------------------- |
| `prototype`              | SObject a SObject to be mutated                            |
| `usingDefaultsClassName` | String the name of the class to be used for field defaults |

#### Returns

| Type      | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| `SObject` | SObject a mutated version of the prototype object with field defaults applied |

### `private static String calculateNameField(SObject prototype)`

### `private static Boolean nameFieldIsAutoNumber(SObject prototype, String nameField)`

### `private static SObjectFactory getFieldDefaultsInstanceFromName(String nameOfClassToInstantiate)`

### `private static SObject applyFieldDefaults(SObject prototype, Map<Schema.SObjectField,Object> defaults)`

---
