`APIVERSION: 58`

`STATUS: ACTIVE`

## Fields

### `private NAME_FIELD_OVERRIDE_MAP` → `Map<Schema.SObjectType,Schema.SObjectField>`

When we create a list of SObjects, we need to have a unique field for the insert if there isn't an autonumber field. Usually we use the Name field, but some objects don't have a name field.

---

## Methods

### `public static SObject createSObject(SObject sObj)`

Creates a single sObject.

#### Parameters

| Param  | Description                |
| ------ | -------------------------- |
| `sObj` | Type of sObject to create. |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject`   |

### `public static SObject createSObject(SObject sObj, Boolean doInsert)`

Creates a single sObject

#### Parameters

| Param      | Description                             |
| ---------- | --------------------------------------- |
| `sObj`     | Type of sObject to create               |
| `doInsert` | Boolean should this object be inserted? |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject`   |

### `public static SObject createSObject(SObject sObj, String defaultClassName)`

creates a single sObject

#### Parameters

| Param              | Description                                 |
| ------------------ | ------------------------------------------- |
| `sObj`             | Type of sObject to create                   |
| `defaultClassName` | Name of the class to provide field defaults |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject`   |

#### Throws

| Exception              | Description                                      |
| ---------------------- | ------------------------------------------------ |
| `TestFactoryException` | when defaultClassName param is not a valid type. |

### `public static SObject createSObject(SObject sObj, String defaultClassName, Boolean doInsert)`

Create a single sObject

#### Parameters

| Param              | Description                                           |
| ------------------ | ----------------------------------------------------- |
| `sObj`             | Type of sObject to create                             |
| `defaultClassName` | String name of a class providing default values       |
| `doInsert`         | Boolean should this method insert the created object? |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject`   |

### `public static List createSObjectList(SObject sObj, Integer numberOfObjects)`

Creates a list of sObjects

#### Parameters

| Param             | Description                         |
| ----------------- | ----------------------------------- |
| `sObj`            | Type of sObjects to create          |
| `numberOfObjects` | Integer number of objects to create |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject[]` |

### `public static List createSObjectList(SObject sObj, Integer numberOfObjects, Boolean doInsert)`

Creates a list of sObjects

#### Parameters

| Param             | Description                                           |
| ----------------- | ----------------------------------------------------- |
| `sObj`            | Type of sObjects to create                            |
| `numberOfObjects` | Integer number of objects to create                   |
| `doInsert`        | Boolean should this method insert the created object? |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject[]` |

### `public static List createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName, Boolean doInsert)`

`SUPPRESSWARNINGS`

Creates a list of sObjects

#### Parameters

| Param              | Description                                           |
| ------------------ | ----------------------------------------------------- |
| `sObj`             | Type of sObjects to create                            |
| `numberOfObjects`  | Integer number of objects to create                   |
| `defaultClassName` | String name of a class providing defaults             |
| `doInsert`         | Boolean should this method insert the created object? |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject[]` |

### `public static List createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName)`

Creates a list of sObjects

#### Parameters

| Param              | Description                               |
| ------------------ | ----------------------------------------- |
| `sObj`             | Type of sObjects to create                |
| `numberOfObjects`  | Integer number of objects to create       |
| `defaultClassName` | String name of a class providing defaults |

#### Returns

| Type    | Description |
| ------- | ----------- |
| SObject | `SObject[]` |

### `private static void addFieldDefaults(SObject sObj, Map<Schema.SObjectField,Object> defaults)`

Sets field defaults on the sObj given the map of defaults.

#### Parameters

| Param      | Description                                               |
| ---------- | --------------------------------------------------------- |
| `sObj`     | Obj to manipulate.                                        |
| `defaults` | Defaults map of sObjectField to Object to use for values. |

### `public static User createTestUser(Id profileId, Boolean doInsert)`

creates a test user. Useful for permissions testing

#### Parameters

| Param       | Description                                |
| ----------- | ------------------------------------------ |
| `profileId` | Profile Id to use when creating a user.    |
| `doInsert`  | Boolean, should this code insert the user? |

#### Returns

| Type | Description |
| ---- | ----------- |
| User | `User`      |

### `public static User createTestUser(Boolean doInsert, String profileName)`

Creates a test user with a given profile.

#### Parameters

| Param         | Description                                  |
| ------------- | -------------------------------------------- |
| `doInsert`    | Should this code insert the created user?    |
| `profileName` | Name of the profile to create the user with. |

#### Returns

| Type | Description |
| ---- | ----------- |
| User | `User`      |

### `public static User createMinAccessUser(Boolean doInsert)`

Creates a user with the Minimum Access Profile Relies on the previous method for creating the user.

#### Parameters

| Param      | Description                       |
| ---------- | --------------------------------- |
| `doInsert` | Should this code insert the user? |

#### Returns

| Type | Description |
| ---- | ----------- |
| User | `User`      |

### `public static void assignPermSetToUser(User user, String permSetName)`

Assigns a permission set to a given user.

#### Parameters

| Param         | Description                           |
| ------------- | ------------------------------------- |
| `user`        | User to assign the permission set to. |
| `permSetName` | String name of the permission set.    |

### `public static List invalidateSObjectList(List<SObject> incoming)`

Intentionally invalidates a list of sObjects. This is useful for intentionally causing DML errors during testing.

#### Parameters

| Param      | Description      |
| ---------- | ---------------- |
| `incoming` | List of SObjects |

#### Returns

| Type          | Description     |
| ------------- | --------------- |
| List<SObject> | `List<sObject>` |

### `public static User createMarketingUser(Boolean doInsert)`

Generates a marketing user - a user with the Marketing User profile.

#### Parameters

| Param      | Description                                        |
| ---------- | -------------------------------------------------- |
| `doInsert` | Boolean True if you want this to insert your user. |

#### Returns

| Type | Description           |
| ---- | --------------------- |
| User | User the created user |

### `public static PermissionSet createPermissionSet(String permSetName, Boolean doInsert)`

Generates a test permission set record - no permissions are added to it

#### Parameters

| Param         | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `permSetName` | String what to call your perm set                             |
| `doInsert`    | Boolean true if you want this to insert your perm set record. |

#### Returns

| Type          | Description                               |
| ------------- | ----------------------------------------- |
| PermissionSet | PermissionSet the created permission set. |

### `public static void enableCustomPermission(String permissionName, Id forUserId)`

Enables a custom permission using a permission set

#### Parameters

| Param            | Description                                           |
| ---------------- | ----------------------------------------------------- |
| `permissionName` | String name of the custom permission you want created |
| `forUserId`      | Id user to assign the custom permission to.           |

---

## Classes

### TestFactoryException

Internal custom exception class

**Inheritance**

TestFactoryException

---

## Interfaces

### FieldDefaults

Use the FieldDefaults interface to set up values you want to default in for all objects

#### Methods

##### `public Map getFieldDefaults()`

Interface used by implementing classes to define defaults.

###### Returns

| Type                                  | Description                              |
| ------------------------------------- | ---------------------------------------- |
| Map&lt;Schema.SObjectField,Object&gt; | `Map&lt;Schema.SObjectField, Object&gt;` |

---
