`STATUS: ACTIVE`

A reusable, intuitive library for determining whether or not the
current use can create, read, edit, or delete objects as well as
determining if the user has access or update permissions on specific fields.
This class name was chosen to facilitate easy-to-understand and read code.
Whenever you need to check FLS or CRUD access your code reads like this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.
<br>
This class' name was chosen to facilitate easy-to-understand and read
code. Whenever you need to check FLS or CRUD access your code reads like
this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.

## Fields

### `private MEMOIZED_FLS_RESULTS` → `Map<String,Map<FLSType,Boolean>>`

This variable stores, within the same transaction, all previously calculated FLS results for an object. This prevents multiple calls to this library within the same transaction from executing more than a single describe call.

---

## Methods

### `private static Boolean crud(SObject obj, CrudType permission)`

`TESTVISIBLE`

A method to determine if the running user can perform the specified CRUD operation on the specified object, or object type.

#### Parameters

| Param        | Description                    |
| ------------ | ------------------------------ |
| `obj`        | the object type to check       |
| `permission` | create, read, update or delete |

#### Returns

| Type    | Description                                                                               |
| ------- | ----------------------------------------------------------------------------------------- |
| Boolean | Boolean true if the user can perform the specified CRUD operation on the specified object |

#### Example

```apex
System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READABLE));
```

### `private static Boolean crud(List<SObject> objs, CrudType permission)`

`TESTVISIBLE`

a list accepting version of the crud method. It returns CRUD results for the first object in the list. Use this method to see if the running user can, for instance, Create an Account, Contact, or Opportunity

#### Parameters

| Param        | Description                                 |
| ------------ | ------------------------------------------- |
| `objs`       | List<SObject> the list of SObjects to check |
| `permission` | CrudType the CRUD type to check ie: Create  |

#### Returns

| Type    | Description                                                                                       |
| ------- | ------------------------------------------------------------------------------------------------- |
| Boolean | Boolean true if the user can perform the specified CRUD operation on the first object in the list |

### `private static Boolean crud(String objectName, CrudType permission)`

`TESTVISIBLE`

A method to determine if the running user can perform the specified CRUD operation on the specified object, or object type.

#### Parameters

| Param        | Description                                |
| ------------ | ------------------------------------------ |
| `objectName` | String the name of the object to check     |
| `permission` | CrudType the CRUD type to check ie: Create |

#### Returns

| Type    | Description                                                                               |
| ------- | ----------------------------------------------------------------------------------------- |
| Boolean | Boolean true if the user can perform the specified CRUD operation on the specified object |

### `public static Boolean create(SObject obj)`

convenience api for determining if the running user can create the specified object

#### Parameters

| Param | Description                                |
| ----- | ------------------------------------------ |
| `obj` | Object type to check create permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can create the specified object |

#### Example

```apex
System.debug(CanTheUser.create(new Account()));
```

### `public static Boolean create(List<SObject> objs)`

convenience api for determining if the running user can create the specified object

#### Parameters

| Param  | Description                                                                                                                 |
| ------ | --------------------------------------------------------------------------------------------------------------------------- |
| `objs` | list of objects. Only the first will be checked. (logically, a list is of uniform type and, and if the user can create one) |

#### Returns

| Type    | Description                                                      |
| ------- | ---------------------------------------------------------------- |
| Boolean | Boolean true if the user can create the first object in the list |

### `public static Boolean create(String objName)`

convenience api for determining if the running user can create the specified object

#### Parameters

| Param     | Description                                |
| --------- | ------------------------------------------ |
| `objName` | Object type to check create permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can create the specified object |

#### Example

```apex
System.debug(CanTheUser.create('Account'));
```

### `public static Boolean read(SObject obj)`

convenience api for determining if the running user can read / access the specified object

#### Parameters

| Param | Description                              |
| ----- | ---------------------------------------- |
| `obj` | object type to check read permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can read the specified object |

#### Example

```apex
System.debug(CanTheUser.read(new Account()));
```

### `public static Boolean read(List<SObject> objs)`

convenience api for determining if the running user can read / access the specified objects

#### Parameters

| Param  | Description                              |
| ------ | ---------------------------------------- |
| `objs` | object type to check read permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can read the specified object |

### `public static Boolean read(String objName)`

convenience api for determining if the running user can read the specified object

#### Parameters

| Param     | Description                              |
| --------- | ---------------------------------------- |
| `objName` | Object type to check read permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can read the specified object |

#### Example

```apex
System.debug(CanTheUser.read('Account'));
```

### `public static Boolean edit(SObject obj)`

convenience api for determining if the running user can edit / update the specified object

#### Parameters

| Param | Description                              |
| ----- | ---------------------------------------- |
| `obj` | object type to check edit permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can edit the specified object |

#### Example

```apex
System.debug(CanTheUser.edit(new Account()));
```

### `public static Boolean edit(List<SObject> objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Parameters

| Param  | Description                              |
| ------ | ---------------------------------------- |
| `objs` | object type to check edit permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can edit the specified object |

### `public static Boolean edit(String objName)`

convenience api for determining if the running user can edit the specified object

#### Parameters

| Param     | Description                              |
| --------- | ---------------------------------------- |
| `objName` | Object type to check edit permissions on |

#### Returns

| Type    | Description                                            |
| ------- | ------------------------------------------------------ |
| Boolean | Boolean true if the user can edit the specified object |

#### Example

```apex
System.debug(CanTheUser.edit('Account'));
```

### `public static Boolean ups(SObject obj)`

convenience api for determining if the running user can upsert (insert and update) the specified objects

#### Parameters

| Param | Description                              |
| ----- | ---------------------------------------- |
| `obj` | object type to check edit permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can upsert the specified object |

#### Example

```apex
System.debug(CanTheUser.ups(new Account()));
```

### `public static Boolean ups(List<SObject> objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Parameters

| Param  | Description                                |
| ------ | ------------------------------------------ |
| `objs` | object type to check upsert permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can upsert the specified object |

### `public static Boolean ups(String objName)`

convenience api for determining if the running user can upsert the specified object

#### Parameters

| Param     | Description                                |
| --------- | ------------------------------------------ |
| `objName` | Object type to check upsert permissions on |

#### Returns

| Type    | Description                                               |
| ------- | --------------------------------------------------------- |
| Boolean | Boolean true if the user can upsert the specified objects |

#### Example

```apex
System.debug(CanTheUser.ups('Account'));
```

### `public static Boolean destroy(SObject obj)`

convenience api for determining if the running user can delete/destroy the specified object

#### Parameters

| Param | Description                                 |
| ----- | ------------------------------------------- |
| `obj` | object type to check destroy permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can delete the specified object |

#### Example

```apex
System.debug(CanTheUser.destroy(new Account()));
```

### `public static Boolean destroy(List<SObject> objs)`

convenience api for determining if the running user can delete the specified object

#### Parameters

| Param  | Description                                |
| ------ | ------------------------------------------ |
| `objs` | Object type to check delete permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can delete the specified object |

### `public static Boolean destroy(String objName)`

convenience api for determining if the running user can delete the specified object

#### Parameters

| Param     | Description                                |
| --------- | ------------------------------------------ |
| `objName` | Object type to check create permissions on |

#### Returns

| Type    | Description                                              |
| ------- | -------------------------------------------------------- |
| Boolean | Boolean true if the user can delete the specified object |

#### Example

```apex
System.debug(CanTheUser.destroy('Account'));
```

### `public static Boolean flsAccessible(String obj, String field)`

public static method to determine if a given field on a given object is Accessible (readable)

#### Parameters

| Param   | Description                                |
| ------- | ------------------------------------------ |
| `obj`   | the object in question, in string form     |
| `field` | the field in question in SObjectField form |

#### Returns

| Type    | Description                                                                   |
| ------- | ----------------------------------------------------------------------------- |
| Boolean | Boolean true if the user can read the specified field on the specified object |

#### Example

```apex
System.debug(CanTheUser.flsAccessible('Account', 'Name'));
```

### `public static Map bulkFLSAccessible(String obj, Set<String> fields)`

bulk form of flsAccessible

#### Parameters

| Param    | Description                               |
| -------- | ----------------------------------------- |
| `obj`    | Obj name on which to check                |
| `fields` | Set of Fields to check for accessibility. |

#### Returns

| Type                | Description                                                                               |
| ------------------- | ----------------------------------------------------------------------------------------- |
| Map<String,Boolean> | `Map<String, Boolean>` where the key is the field name and the value is the accessibility |

#### Example

```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSAccessible('Account', fields));
```

### `public static Boolean flsUpdatable(String obj, String field)`

public static method to determine if a given field on a given object is Updatable.

#### Parameters

| Param   | Description                          |
| ------- | ------------------------------------ |
| `obj`   | the string version of an object name |
| `field` | the field to check                   |

#### Returns

| Type    | Description                                                                     |
| ------- | ------------------------------------------------------------------------------- |
| Boolean | Boolean true if the user can update the specified field on the specified object |

#### Example

```apex
System.debug(CanTheUser.flsUpdatable('Account', 'Name'));
```

### `public static Map bulkFLSUpdatable(String obj, Set<String> fields)`

bulk form of flsUpdatable call

#### Parameters

| Param    | Description                 |
| -------- | --------------------------- |
| `obj`    | Name of the object          |
| `fields` | Set of Field names to check |

#### Returns

| Type                | Description                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------- |
| Map<String,Boolean> | `Map<String, Boolean>` where the key is the field name and the value is the updatability |

#### Example

```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSUpdatable('Account', fields));
```

### `private static Boolean getFLSForFieldOnObject(String obj, String field, FLSType checkType)`

Abstracted method for retrieving or calculating (memoization) of the FLS for a given field on a given object.

#### Parameters

| Param       | Description                            |
| ----------- | -------------------------------------- |
| `obj`       | String version of object name to check |
| `field`     | String version of the field to check   |
| `checkType` | Enum of Accessible or Updatable.       |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

### `private static Map calculateFLS(String objType)`

Calculates the FLS for a given object type

#### Parameters

| Param     | Description                    |
| --------- | ------------------------------ |
| `objType` | String name of the object type |

#### Returns

| Type                             | Description                          |
| -------------------------------- | ------------------------------------ |
| Map<String,Map<FLSType,Boolean>> | `Map<String, Map<FLSType, Boolean>>` |

---

## Enums

### CrudType

An ENUM specifying the various types of CRUD operations

### FLSType

An ENUM specifying the various types of FLS operations available.

---
