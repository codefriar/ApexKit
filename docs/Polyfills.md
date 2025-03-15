opinionated, and these represent the best solutions i&#x27;ve found to the gnarly problems i&#x27;ve come across.

## Methods

### `classNameFromInstance(obj)`

Used to determine what the Class name
of the passed in Object is. There are many mostly
accurate ways of doing this, but this is the only
one that works in all cases.

#### Signature

```apex
public static String classNameFromInstance(Object obj)
```

#### Parameters

| Name | Type   | Description                                 |
| ---- | ------ | ------------------------------------------- |
| obj  | Object | Object the object whose class name you want |

#### Return Type

**String**

String the name of the class of the passed in object.

---

### `typeObjFromInstance(obj)`

Method returns a Type object from an object instance. This is useful for reflection operations

#### Signature

```apex
public static Type typeObjFromInstance(Object obj)
```

#### Parameters

| Name | Type   | Description                   |
| ---- | ------ | ----------------------------- |
| obj  | Object | The object to get the type of |

#### Return Type

**Type**

Type the type of the passed in object

---

### `getSObjectTypeFromListsFirstObject(sObjects)`

Method determines the type of a list from it&#x27;s first element.
This is potentially incorrect, if your List is defined `List<SObject>` rather than `List<Account>`
or some other specific SObject

#### Signature

```apex
public static String getSObjectTypeFromListsFirstObject(List<SObject> sObjects)
```

#### Parameters

| Name     | Type                | Description        |
| -------- | ------------------- | ------------------ |
| sObjects | List&lt;SObject&gt; | A list of SObjects |

#### Return Type

**String**

String the name of the SObject type of the first element in the list

---

### `idMapFromCollectionByKey(key, incomingList)`

Method is responsible for building a map out of a list where you can specify the key. This is
useful for drying up your code, as generating maps by a non-record-id key is ... common.

Note: you&#x27;ll need to cast this on the calling side.

#### Signature

```apex
public static Map<Id,SObject> idMapFromCollectionByKey(String key, List<SObject> incomingList)
```

#### Parameters

| Name                                                                                        | Type                | Description                                                                    |
| ------------------------------------------------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------ |
| key                                                                                         | String              | String the name of the field to use as the key. ** This must be an ID field ** |
| However, it doesn&#x27;t have to be the record id. It can be any field that is an ID field. |
| incomingList                                                                                | List&lt;SObject&gt; | List&lt;SObject&gt; the list of SObjects to build the map from                 |

#### Return Type

**Map&lt;Id,SObject&gt;**

Map&lt;Id, SObject&gt; the map of the passed in list, keyed by the passed in key

---

### `stringMapFromCollectionByKey(key, incomingList)`

Method is responsible for building a map out of a list where you can specify the key. This is
useful for drying up your code, as generating maps by a non-record-id key is ... common.

Note: you&#x27;ll need to cast this on the calling side.

#### Signature

```apex
public static Map<String,SObject> stringMapFromCollectionByKey(String key, List<SObject> incomingList)
```

#### Parameters

| Name         | Type                | Description                                                                        |
| ------------ | ------------------- | ---------------------------------------------------------------------------------- |
| key          | String              | String the name of the field to use as the key. ** This must be an STRING field ** |
| incomingList | List&lt;SObject&gt; | List&lt;SObject&gt; the list of SObjects to build the map from                     |

#### Return Type

**Map&lt;String,SObject&gt;**

Map&lt;Id, SObject&gt; the map of the passed in list, keyed by the passed in key

---

### `mapFromCollectionWithCollectionValues(key, incomingList)`

This method is responsible for building a map out of a list where you can specify the key. However
this method is designed to help you group records by common keys. For instance, you can use this method to group
a list of contacts by their accountIds by passing in &#x27;AccountId&#x27; as the key.

Note: you&#x27;ll need to cast this on the calling side. The key used here must be an ID field.

#### Signature

```apex
public static Map<Id,List<SObject>> mapFromCollectionWithCollectionValues(String key, List<SObject> incomingList)
```

#### Parameters

| Name         | Type                | Description                                                                    |
| ------------ | ------------------- | ------------------------------------------------------------------------------ |
| key          | String              | String the name of the field to use as the key. ** This must be an ID field ** |
| incomingList | List&lt;SObject&gt; | List&lt;SObject&gt; the list of SObjects to build the map from                 |

#### Return Type

**Map&lt;Id,List&lt;SObject&gt;&gt;**

Map&lt;Id, List&lt;SObject&gt;&gt; the map of the passed in list, grouped by the passed in key

---

### `generateStackTrace()`

This method will give you a stack trace you can inspect. It&#x27;s useful for debugging, and for things
like determining the call stack of a method.

#### Signature

```apex
public static String generateStackTrace()
```

#### Return Type

**String**

String The stack trace of the current execution context.

---

### `pluckFieldFromList(fieldName, incomingList)`

Similar to the pluck method in lodash, this method will return a list of strings from a list of
SObjects, based on the field name you pass in.

#### Signature

```apex
public static List<String> pluckFieldFromList(String fieldName, List<SObject> incomingList)
```

#### Parameters

| Name         | Type                | Description                                       |
| ------------ | ------------------- | ------------------------------------------------- |
| fieldName    | String              | String the name of the field to &#x27;pluck&#x27; |
| incomingList | List&lt;SObject&gt; | List&lt;SObject&gt; list of objects to pluck from |

#### Return Type

**List&lt;String&gt;**

List&lt;String&gt; list containing the string value of the field you passed in from every record in the,[object Object],incoming list

---

### `setContainsAnyItemFromList(setToCheck, listOfPossibleOptions)`

Well, as much as I&#x27;d like to make this a generic method, I can&#x27;t
Apex doesn&#x27;t provide a way to dynamically cast a list of one type
to another type. So, this is a method that will only work for Ids
Future versions of this class might include methods of the same
name but with different parameters to handle other types

This makes me sad.

#### Signature

```apex
public static Boolean setContainsAnyItemFromList(Set<String> setToCheck, List<String> listOfPossibleOptions)
```

#### Parameters

| Name                  | Type               | Description                                                   |
| --------------------- | ------------------ | ------------------------------------------------------------- |
| setToCheck            | Set&lt;String&gt;  | A set of strings to check                                     |
| listOfPossibleOptions | List&lt;String&gt; | List&lt;String&gt; a list of strings that might be in the set |

#### Return Type

**Boolean**

Boolean True if any of the strings in the list are in the set

---

### `generateUUID()`

Generates a UUIDv4 string. This is useful for generating unique identifiers for things.

#### Signature

```apex
public static String generateUUID()
```

#### Return Type

**String**

String a UUIDv4 string

---

### `concatenateBlobAndString(someFile, supplementalText)`

this method is useful for appending a string to a blob. Polyfill for the lack of Blob.append(String)

#### Signature

```apex
public static Blob concatenateBlobAndString(Blob someFile, String supplementalText)
```

#### Parameters

| Name             | Type   | Description                             |
| ---------------- | ------ | --------------------------------------- |
| someFile         | Blob   | Blob a file to append a string to       |
| supplementalText | String | String the string to append to the blob |

#### Return Type

**Blob**

Blob the blob with the string appended to it

---

### `getStringifiedBlob(someFile)`

Returns the string value of a blob. Polyfill for the lack of String.valueOf(Blob)

#### Signature

```apex
public static String getStringifiedBlob(Blob someFile)
```

#### Parameters

| Name     | Type | Description                |
| -------- | ---- | -------------------------- |
| someFile | Blob | Blob the blob to stringify |

#### Return Type

**String**

A string representation of the blob

## Classes

### GuaranteedNotToExist Class

Class exists to reserve an object type that cannot be instantiated. It is used for generating stack
traces on demand, and other reflection operations.

### GuaranteedNotToExistException Class

Exception used internally to throw exceptions that
are intentional and used for unofficial reflection
operations.
