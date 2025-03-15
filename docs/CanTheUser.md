current use can create, read, edit, or delete objects as well as
determining if the user has access or update permissions on specific fields.
This class name was chosen to facilitate easy-to-understand and read code.
Whenever you need to check FLS or CRUD access your code reads like this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.
&lt;br&gt;
This class&#x27; name was chosen to facilitate easy-to-understand and read
code. Whenever you need to check FLS or CRUD access your code reads like
this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.

## Fields

### `MEMOIZED_FLS_RESULTS`

This variable stores, within the same transaction, all previously calculated
FLS results for an object. This prevents multiple calls to this library within the same
transaction from executing more than a single describe call.

#### Signature

```apex
private static final MEMOIZED_FLS_RESULTS
```

#### Type

Map&lt;String,Map&lt;FLSType,Boolean&gt;&gt;

## Methods

### `crud(obj, permission)`

`TESTVISIBLE`

A method to determine if the running user can perform the specified CRUD operation on the specified
object, or object type.

#### Signature

```apex
private static Boolean crud(SObject obj, CrudType permission)
```

#### Parameters

| Name       | Type                    | Description                    |
| ---------- | ----------------------- | ------------------------------ |
| obj        | SObject                 | the object type to check       |
| permission | [CrudType](CrudType.md) | create, read, update or delete |

#### Return Type

**Boolean**

Boolean true if the user can perform the specified CRUD operation on the specified object

#### Example

System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READABLE));

---

### `crud(objs, permission)`

`TESTVISIBLE`

a list accepting version of the crud method. It returns CRUD results for the first object in the
list. Use this method to see if the running user can, for instance, Create an Account, Contact, or Opportunity

#### Signature

```apex
private static Boolean crud(List<SObject> objs, CrudType permission)
```

#### Parameters

| Name       | Type                    | Description                                       |
| ---------- | ----------------------- | ------------------------------------------------- |
| objs       | List&lt;SObject&gt;     | List&lt;SObject&gt; the list of SObjects to check |
| permission | [CrudType](CrudType.md) | CrudType the CRUD type to check ie: Create        |

#### Return Type

**Boolean**

Boolean true if the user can perform the specified CRUD operation on the first object in the list

---

### `crud(objectName, permission)`

`TESTVISIBLE`

A method to determine if the running user can perform the specified CRUD operation on the specified
object, or object type.

#### Signature

```apex
private static Boolean crud(String objectName, CrudType permission)
```

#### Parameters

| Name       | Type                    | Description                                |
| ---------- | ----------------------- | ------------------------------------------ |
| objectName | String                  | String the name of the object to check     |
| permission | [CrudType](CrudType.md) | CrudType the CRUD type to check ie: Create |

#### Return Type

**Boolean**

Boolean true if the user can perform the specified CRUD operation on the specified object

---

### `create(obj)`

convenience api for determining if the running user can create the specified object

#### Signature

```apex
public static Boolean create(SObject obj)
```

#### Parameters

| Name | Type    | Description                                |
| ---- | ------- | ------------------------------------------ |
| obj  | SObject | Object type to check create permissions on |

#### Return Type

**Boolean**

Boolean true if the user can create the specified object

#### Example

System.debug(CanTheUser.create(new Account()));

---

### `create(objs)`

convenience api for determining if the running user can create the specified object

#### Signature

```apex
public static Boolean create(List<SObject> objs)
```

#### Parameters

| Name                                 | Type                | Description                                                                            |
| ------------------------------------ | ------------------- | -------------------------------------------------------------------------------------- |
| objs                                 | List&lt;SObject&gt; | list of objects. Only the first will be checked. (logically, a list is of uniform type |
| and, and if the user can create one) |

#### Return Type

**Boolean**

Boolean true if the user can create the first object in the list

---

### `create(objName)`

convenience api for determining if the running user can create the specified object

#### Signature

```apex
public static Boolean create(String objName)
```

#### Parameters

| Name    | Type   | Description                                |
| ------- | ------ | ------------------------------------------ |
| objName | String | Object type to check create permissions on |

#### Return Type

**Boolean**

Boolean true if the user can create the specified object

#### Example

System.debug(CanTheUser.create(&#x27;Account&#x27;));

---

### `read(obj)`

convenience api for determining if the running user can read / access the specified object

#### Signature

```apex
public static Boolean read(SObject obj)
```

#### Parameters

| Name | Type    | Description                              |
| ---- | ------- | ---------------------------------------- |
| obj  | SObject | object type to check read permissions on |

#### Return Type

**Boolean**

Boolean true if the user can read the specified object

#### Example

System.debug(CanTheUser.read(new Account()));

---

### `read(objs)`

convenience api for determining if the running user can read / access the specified objects

#### Signature

```apex
public static Boolean read(List<SObject> objs)
```

#### Parameters

| Name | Type                | Description                              |
| ---- | ------------------- | ---------------------------------------- |
| objs | List&lt;SObject&gt; | object type to check read permissions on |

#### Return Type

**Boolean**

Boolean true if the user can read the specified object

---

### `read(objName)`

convenience api for determining if the running user can read the specified object

#### Signature

```apex
public static Boolean read(String objName)
```

#### Parameters

| Name    | Type   | Description                              |
| ------- | ------ | ---------------------------------------- |
| objName | String | Object type to check read permissions on |

#### Return Type

**Boolean**

Boolean true if the user can read the specified object

#### Example

System.debug(CanTheUser.read(&#x27;Account&#x27;));

---

### `edit(obj)`

convenience api for determining if the running user can edit / update the specified object

#### Signature

```apex
public static Boolean edit(SObject obj)
```

#### Parameters

| Name | Type    | Description                              |
| ---- | ------- | ---------------------------------------- |
| obj  | SObject | object type to check edit permissions on |

#### Return Type

**Boolean**

Boolean true if the user can edit the specified object

#### Example

System.debug(CanTheUser.edit(new Account()));

---

### `edit(objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Signature

```apex
public static Boolean edit(List<SObject> objs)
```

#### Parameters

| Name | Type                | Description                              |
| ---- | ------------------- | ---------------------------------------- |
| objs | List&lt;SObject&gt; | object type to check edit permissions on |

#### Return Type

**Boolean**

Boolean true if the user can edit the specified object

---

### `edit(objName)`

convenience api for determining if the running user can edit the specified object

#### Signature

```apex
public static Boolean edit(String objName)
```

#### Parameters

| Name    | Type   | Description                              |
| ------- | ------ | ---------------------------------------- |
| objName | String | Object type to check edit permissions on |

#### Return Type

**Boolean**

Boolean true if the user can edit the specified object

#### Example

System.debug(CanTheUser.edit(&#x27;Account&#x27;));

---

### `ups(obj)`

convenience api for determining if the running user can upsert (insert and update) the specified objects

#### Signature

```apex
public static Boolean ups(SObject obj)
```

#### Parameters

| Name | Type    | Description                              |
| ---- | ------- | ---------------------------------------- |
| obj  | SObject | object type to check edit permissions on |

#### Return Type

**Boolean**

Boolean true if the user can upsert the specified object

#### Example

System.debug(CanTheUser.ups(new Account()));

---

### `ups(objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Signature

```apex
public static Boolean ups(List<SObject> objs)
```

#### Parameters

| Name | Type                | Description                                |
| ---- | ------------------- | ------------------------------------------ |
| objs | List&lt;SObject&gt; | object type to check upsert permissions on |

#### Return Type

**Boolean**

Boolean true if the user can upsert the specified object

---

### `ups(objName)`

convenience api for determining if the running user can upsert the specified object

#### Signature

```apex
public static Boolean ups(String objName)
```

#### Parameters

| Name    | Type   | Description                                |
| ------- | ------ | ------------------------------------------ |
| objName | String | Object type to check upsert permissions on |

#### Return Type

**Boolean**

Boolean true if the user can upsert the specified objects

#### Example

System.debug(CanTheUser.ups(&#x27;Account&#x27;));

---

### `destroy(obj)`

convenience api for determining if the running user can delete/destroy the specified object

#### Signature

```apex
public static Boolean destroy(SObject obj)
```

#### Parameters

| Name | Type    | Description                                 |
| ---- | ------- | ------------------------------------------- |
| obj  | SObject | object type to check destroy permissions on |

#### Return Type

**Boolean**

Boolean true if the user can delete the specified object

#### Example

System.debug(CanTheUser.destroy(new Account()));

---

### `destroy(objs)`

convenience api for determining if the running user can delete the specified object

#### Signature

```apex
public static Boolean destroy(List<SObject> objs)
```

#### Parameters

| Name | Type                | Description                                |
| ---- | ------------------- | ------------------------------------------ |
| objs | List&lt;SObject&gt; | Object type to check delete permissions on |

#### Return Type

**Boolean**

Boolean true if the user can delete the specified object

---

### `destroy(objName)`

convenience api for determining if the running user can delete the specified object

#### Signature

```apex
public static Boolean destroy(String objName)
```

#### Parameters

| Name    | Type   | Description                                |
| ------- | ------ | ------------------------------------------ |
| objName | String | Object type to check create permissions on |

#### Return Type

**Boolean**

Boolean true if the user can delete the specified object

#### Example

System.debug(CanTheUser.destroy(&#x27;Account&#x27;));

---

### `flsAccessible(obj, field)`

public static method to determine if a given field on a given object is Accessible (readable)

#### Signature

```apex
public static Boolean flsAccessible(String obj, String field)
```

#### Parameters

| Name  | Type   | Description                                |
| ----- | ------ | ------------------------------------------ |
| obj   | String | the object in question, in string form     |
| field | String | the field in question in SObjectField form |

#### Return Type

**Boolean**

Boolean true if the user can read the specified field on the specified object

#### Example

System.debug(CanTheUser.flsAccessible(&#x27;Account&#x27;, &#x27;Name&#x27;));

---

### `bulkFLSAccessible(obj, fields)`

bulk form of flsAccessible

#### Signature

```apex
public static Map<String,Boolean> bulkFLSAccessible(String obj, Set<String> fields)
```

#### Parameters

| Name   | Type              | Description                               |
| ------ | ----------------- | ----------------------------------------- |
| obj    | String            | Obj name on which to check                |
| fields | Set&lt;String&gt; | Set of Fields to check for accessibility. |

#### Return Type

**Map&lt;String,Boolean&gt;**

,[object Object], where the key is the field name and the value is the accessibility

#### Example

String[] fields &#x3D; new String[]{&#x27;Name&#x27;, &#x27;ShippingStreet&#x27;};
System.debug(CanTheUser.bulkFLSAccessible(&#x27;Account&#x27;, fields));

---

### `flsUpdatable(obj, field)`

public static method to determine if a given field on a given object is Updatable.

#### Signature

```apex
public static Boolean flsUpdatable(String obj, String field)
```

#### Parameters

| Name  | Type   | Description                          |
| ----- | ------ | ------------------------------------ |
| obj   | String | the string version of an object name |
| field | String | the field to check                   |

#### Return Type

**Boolean**

Boolean true if the user can update the specified field on the specified object

#### Example

System.debug(CanTheUser.flsUpdatable(&#x27;Account&#x27;, &#x27;Name&#x27;));

---

### `bulkFLSUpdatable(obj, fields)`

bulk form of flsUpdatable call

#### Signature

```apex
public static Map<String,Boolean> bulkFLSUpdatable(String obj, Set<String> fields)
```

#### Parameters

| Name   | Type              | Description                 |
| ------ | ----------------- | --------------------------- |
| obj    | String            | Name of the object          |
| fields | Set&lt;String&gt; | Set of Field names to check |

#### Return Type

**Map&lt;String,Boolean&gt;**

,[object Object], where the key is the field name and the value is the updatability

#### Example

String[] fields &#x3D; new String[]{&#x27;Name&#x27;, &#x27;ShippingStreet&#x27;};
System.debug(CanTheUser.bulkFLSUpdatable(&#x27;Account&#x27;, fields));

---

### `getFLSForFieldOnObject(obj, field, checkType)`

Abstracted method for retrieving or calculating (memoization) of the FLS for a given field on a given object.

#### Signature

```apex
private static Boolean getFLSForFieldOnObject(String obj, String field, FLSType checkType)
```

#### Parameters

| Name      | Type                  | Description                            |
| --------- | --------------------- | -------------------------------------- |
| obj       | String                | String version of object name to check |
| field     | String                | String version of the field to check   |
| checkType | [FLSType](FLSType.md) | Enum of Accessible or Updatable.       |

#### Return Type

**Boolean**

,[object Object]

---

### `calculateFLS(objType)`

Calculates the FLS for a given object type

#### Signature

```apex
private static Map<String,Map<FLSType,Boolean>> calculateFLS(String objType)
```

#### Parameters

| Name    | Type   | Description                    |
| ------- | ------ | ------------------------------ |
| objType | String | String name of the object type |

#### Return Type

**Map&lt;String,Map&lt;FLSType,Boolean&gt;&gt;**

,[object Object]

## Enums

### CrudType Enum

An ENUM specifying the various types of CRUD operations

#### Values

| Value      | Description |
| ---------- | ----------- |
| CREATEABLE |             |
| READABLE   |             |
| EDITABLE   |             |
| DELETABLE  |             |
| UPSERTABLE |             |

### FLSType Enum

An ENUM specifying the various types of FLS operations available.

#### Values

| Value      | Description |
| ---------- | ----------- |
| ACCESSIBLE |             |
| UPDATABLE  |             |
