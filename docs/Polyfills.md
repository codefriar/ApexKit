`STATUS: ACTIVE`

This class is full of methods that _I_ think should be in the Apex language, but aren't. It's
opinionated, and these represent the best solutions i've found to the gnarly problems i've come across.

## Methods

### `public static String classNameFromInstance(Object obj)`

Used to determine what the Class name of the passed in Object is. There are many mostly accurate ways of doing this, but this is the only one that works in all cases.

#### Parameters

| Param | Description                                 |
| ----- | ------------------------------------------- |
| `obj` | Object the object whose class name you want |

#### Returns

| Type     | Description                                           |
| -------- | ----------------------------------------------------- |
| `String` | String the name of the class of the passed in object. |

### `public static Type typeObjFromInstance(Object obj)`

Method returns a Type object from an object instance. This is useful for reflection operations

#### Parameters

| Param | Description                   |
| ----- | ----------------------------- |
| `obj` | The object to get the type of |

#### Returns

| Type   | Description                           |
| ------ | ------------------------------------- |
| `Type` | Type the type of the passed in object |

### `public static String getSObjectTypeFromListsFirstObject(List<SObject> sObjects)`

Method determines the type of a list from it's first element. This is potentially incorrect, if your List is defined `List&lt;SObject&gt;` rather than `List&lt;Account&gt;` or some other specific SObject

#### Parameters

| Param      | Description        |
| ---------- | ------------------ |
| `sObjects` | A list of SObjects |

#### Returns

| Type     | Description                                                          |
| -------- | -------------------------------------------------------------------- |
| `String` | String the name of the SObject type of the first element in the list |

### `public static Map<Id,SObject> idMapFromCollectionByKey(String key, List<SObject> incomingList)`

Method is responsible for building a map out of a list where you can specify the key. This is useful for drying up your code, as generating maps by a non-record-id key is ... common. Note: you'll need to cast this on the calling side.

#### Parameters

| Param          | Description                                                                                                                                                           |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `key`          | String the name of the field to use as the key. ** This must be an ID field ** However, it doesn't have to be the record id. It can be any field that is an ID field. |
| `incomingList` | List<SObject> the list of SObjects to build the map from                                                                                                              |

#### Returns

| Type              | Description                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| `Map<Id,SObject>` | Map<Id, SObject> the map of the passed in list, keyed by the passed in key |

### `public static Map<String,SObject> stringMapFromCollectionByKey(String key, List<SObject> incomingList)`

Method is responsible for building a map out of a list where you can specify the key. This is useful for drying up your code, as generating maps by a non-record-id key is ... common. Note: you'll need to cast this on the calling side.

#### Parameters

| Param          | Description                                                                        |
| -------------- | ---------------------------------------------------------------------------------- |
| `key`          | String the name of the field to use as the key. ** This must be an STRING field ** |
| `incomingList` | List<SObject> the list of SObjects to build the map from                           |

#### Returns

| Type                  | Description                                                                |
| --------------------- | -------------------------------------------------------------------------- |
| `Map<String,SObject>` | Map<Id, SObject> the map of the passed in list, keyed by the passed in key |

### `public static Map<Id,List<SObject>> mapFromCollectionWithCollectionValues(String key, List<SObject> incomingList)`

This method is responsible for building a map out of a list where you can specify the key. However this method is designed to help you group records by common keys. For instance, you can use this method to group a list of contacts by their accountIds by passing in 'AccountId' as the key. Note: you'll need to cast this on the calling side. The key used here must be an ID field.

#### Parameters

| Param          | Description                                                                    |
| -------------- | ------------------------------------------------------------------------------ |
| `key`          | String the name of the field to use as the key. ** This must be an ID field ** |
| `incomingList` | List<SObject> the list of SObjects to build the map from                       |

#### Returns

| Type                    | Description                                                                        |
| ----------------------- | ---------------------------------------------------------------------------------- |
| `Map<Id,List<SObject>>` | Map<Id, List<SObject>> the map of the passed in list, grouped by the passed in key |

### `public static String generateStackTrace()`

This method will give you a stack trace you can inspect. It's useful for debugging, and for things like determining the call stack of a method.

#### Returns

| Type     | Description                                              |
| -------- | -------------------------------------------------------- |
| `String` | String The stack trace of the current execution context. |

### `public static List<String> pluckFieldFromList(String fieldName, List<SObject> incomingList)`

Similar to the pluck method in lodash, this method will return a list of strings from a list of SObjects, based on the field name you pass in.

#### Parameters

| Param          | Description                                 |
| -------------- | ------------------------------------------- |
| `fieldName`    | String the name of the field to 'pluck'     |
| `incomingList` | List<SObject> list of objects to pluck from |

#### Returns

| Type           | Description                                                                                                     |
| -------------- | --------------------------------------------------------------------------------------------------------------- |
| `List<String>` | List<String> list containing the string value of the field you passed in from every record in the incoming list |

### `public static Boolean setContainsAnyItemFromList(Set<String> setToCheck, List<String> listOfPossibleOptions)`

Well, as much as I'd like to make this a generic method, I can't Apex doesn't provide a way to dynamically cast a list of one type to another type. So, this is a method that will only work for Ids Future versions of this class might include methods of the same name but with different parameters to handle other types This makes me sad.

#### Parameters

| Param                   | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| `setToCheck`            | A set of strings to check                               |
| `listOfPossibleOptions` | List<String> a list of strings that might be in the set |

#### Returns

| Type      | Description                                                   |
| --------- | ------------------------------------------------------------- |
| `Boolean` | Boolean True if any of the strings in the list are in the set |

### `public static String generateUUID()`

Generates a UUIDv4 string. This is useful for generating unique identifiers for things.

#### Returns

| Type     | Description            |
| -------- | ---------------------- |
| `String` | String a UUIDv4 string |

### `public static Blob concatenateBlobAndString(Blob someFile, String supplementalText)`

this method is useful for appending a string to a blob. Polyfill for the lack of Blob.append(String)

#### Parameters

| Param              | Description                             |
| ------------------ | --------------------------------------- |
| `someFile`         | Blob a file to append a string to       |
| `supplementalText` | String the string to append to the blob |

#### Returns

| Type   | Description                                  |
| ------ | -------------------------------------------- |
| `Blob` | Blob the blob with the string appended to it |

### `public static String getStringifiedBlob(Blob someFile)`

Returns the string value of a blob. Polyfill for the lack of String.valueOf(Blob)

#### Parameters

| Param      | Description                |
| ---------- | -------------------------- |
| `someFile` | Blob the blob to stringify |

#### Returns

| Type     | Description                         |
| -------- | ----------------------------------- |
| `String` | A string representation of the blob |

---

## Classes

### GuaranteedNotToExist

Class exists to reserve an object type that cannot be instantiated. It is used for generating stack
traces on demand, and other reflection operations.

### GuaranteedNotToExistException

Exception used internally to throw exceptions that
are intentional and used for unofficial reflection
operations.

**Inheritance**

GuaranteedNotToExistException

---
