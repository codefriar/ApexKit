## Fields

### `NAME_FIELD_OVERRIDE_MAP`

When we create a list of SObjects, we need to have a unique field for the insert if there isn&#x27;t an autonumber field.
Usually we use the Name field, but some objects don&#x27;t have a name field.

#### Signature

```apex
private static final NAME_FIELD_OVERRIDE_MAP
```

#### Type

Map&lt;Schema.SObjectType,Schema.SObjectField&gt;

## Methods

### `createSObject(sObj)`

Creates a single sObject.

#### Signature

```apex
public static SObject createSObject(SObject sObj)
```

#### Parameters

| Name | Type    | Description                |
| ---- | ------- | -------------------------- |
| sObj | SObject | Type of sObject to create. |

#### Return Type

**SObject**

,[object Object]

---

### `createSObject(sObj, doInsert)`

Creates a single sObject

#### Signature

```apex
public static SObject createSObject(SObject sObj, Boolean doInsert)
```

#### Parameters

| Name     | Type    | Description                             |
| -------- | ------- | --------------------------------------- |
| sObj     | SObject | Type of sObject to create               |
| doInsert | Boolean | Boolean should this object be inserted? |

#### Return Type

**SObject**

,[object Object]

---

### `createSObject(sObj, defaultClassName)`

creates a single sObject

#### Signature

```apex
public static SObject createSObject(SObject sObj, String defaultClassName)
```

#### Parameters

| Name             | Type    | Description                                 |
| ---------------- | ------- | ------------------------------------------- |
| sObj             | SObject | Type of sObject to create                   |
| defaultClassName | String  | Name of the class to provide field defaults |

#### Return Type

**SObject**

,[object Object]

#### Throws

TestFactoryException: when defaultClassName param is not a valid type.

---

### `createSObject(sObj, defaultClassName, doInsert)`

Create a single sObject

#### Signature

```apex
public static SObject createSObject(SObject sObj, String defaultClassName, Boolean doInsert)
```

#### Parameters

| Name             | Type    | Description                                           |
| ---------------- | ------- | ----------------------------------------------------- |
| sObj             | SObject | Type of sObject to create                             |
| defaultClassName | String  | String name of a class providing default values       |
| doInsert         | Boolean | Boolean should this method insert the created object? |

#### Return Type

**SObject**

,[object Object]

---

### `createSObjectList(sObj, numberOfObjects)`

Creates a list of sObjects

#### Signature

```apex
public static SObject createSObjectList(SObject sObj, Integer numberOfObjects)
```

#### Parameters

| Name            | Type    | Description                         |
| --------------- | ------- | ----------------------------------- |
| sObj            | SObject | Type of sObjects to create          |
| numberOfObjects | Integer | Integer number of objects to create |

#### Return Type

**SObject**

,[object Object]

---

### `createSObjectList(sObj, numberOfObjects, doInsert)`

Creates a list of sObjects

#### Signature

```apex
public static SObject createSObjectList(SObject sObj, Integer numberOfObjects, Boolean doInsert)
```

#### Parameters

| Name            | Type    | Description                                           |
| --------------- | ------- | ----------------------------------------------------- |
| sObj            | SObject | Type of sObjects to create                            |
| numberOfObjects | Integer | Integer number of objects to create                   |
| doInsert        | Boolean | Boolean should this method insert the created object? |

#### Return Type

**SObject**

,[object Object]

---

### `createSObjectList(sObj, numberOfObjects, defaultClassName, doInsert)`

`SUPPRESSWARNINGS`

Creates a list of sObjects

#### Signature

```apex
public static SObject createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName, Boolean doInsert)
```

#### Parameters

| Name             | Type    | Description                                           |
| ---------------- | ------- | ----------------------------------------------------- |
| sObj             | SObject | Type of sObjects to create                            |
| numberOfObjects  | Integer | Integer number of objects to create                   |
| defaultClassName | String  | String name of a class providing defaults             |
| doInsert         | Boolean | Boolean should this method insert the created object? |

#### Return Type

**SObject**

,[object Object]

---

### `createSObjectList(sObj, numberOfObjects, defaultClassName)`

Creates a list of sObjects

#### Signature

```apex
public static SObject createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName)
```

#### Parameters

| Name             | Type    | Description                               |
| ---------------- | ------- | ----------------------------------------- |
| sObj             | SObject | Type of sObjects to create                |
| numberOfObjects  | Integer | Integer number of objects to create       |
| defaultClassName | String  | String name of a class providing defaults |

#### Return Type

**SObject**

,[object Object]

---

### `addFieldDefaults(sObj, defaults)`

Sets field defaults on the sObj given the map of defaults.

#### Signature

```apex
private static void addFieldDefaults(SObject sObj, Map<Schema.SObjectField,Object> defaults)
```

#### Parameters

| Name     | Type                                  | Description                                               |
| -------- | ------------------------------------- | --------------------------------------------------------- |
| sObj     | SObject                               | Obj to manipulate.                                        |
| defaults | Map&lt;Schema.SObjectField,Object&gt; | Defaults map of sObjectField to Object to use for values. |

#### Return Type

**void**

---

### `createTestUser(profileId, doInsert)`

creates a test user. Useful for permissions testing

#### Signature

```apex
public static User createTestUser(Id profileId, Boolean doInsert)
```

#### Parameters

| Name      | Type    | Description                                |
| --------- | ------- | ------------------------------------------ |
| profileId | Id      | Profile Id to use when creating a user.    |
| doInsert  | Boolean | Boolean, should this code insert the user? |

#### Return Type

**User**

,[object Object]

---

### `createTestUser(doInsert, profileName)`

Creates a test user with a given profile.

#### Signature

```apex
public static User createTestUser(Boolean doInsert, String profileName)
```

#### Parameters

| Name        | Type    | Description                                  |
| ----------- | ------- | -------------------------------------------- |
| doInsert    | Boolean | Should this code insert the created user?    |
| profileName | String  | Name of the profile to create the user with. |

#### Return Type

**User**

,[object Object]

---

### `createMinAccessUser(doInsert)`

Creates a user with the Minimum Access Profile
Relies on the previous method for creating the user.

#### Signature

```apex
public static User createMinAccessUser(Boolean doInsert)
```

#### Parameters

| Name     | Type    | Description                       |
| -------- | ------- | --------------------------------- |
| doInsert | Boolean | Should this code insert the user? |

#### Return Type

**User**

,[object Object]

---

### `assignPermSetToUser(user, permSetName)`

Assigns a permission set to a given user.

#### Signature

```apex
public static void assignPermSetToUser(User user, String permSetName)
```

#### Parameters

| Name        | Type   | Description                           |
| ----------- | ------ | ------------------------------------- |
| user        | User   | User to assign the permission set to. |
| permSetName | String | String name of the permission set.    |

#### Return Type

**void**

---

### `invalidateSObjectList(incoming)`

Intentionally invalidates a list of sObjects. This is useful for
intentionally causing DML errors during testing.

#### Signature

```apex
public static List<SObject> invalidateSObjectList(List<SObject> incoming)
```

#### Parameters

| Name     | Type                | Description      |
| -------- | ------------------- | ---------------- |
| incoming | List&lt;SObject&gt; | List of SObjects |

#### Return Type

**List&lt;SObject&gt;**

,[object Object]

---

### `createMarketingUser(doInsert)`

Generates a marketing user - a user with the Marketing User profile.

#### Signature

```apex
public static User createMarketingUser(Boolean doInsert)
```

#### Parameters

| Name     | Type    | Description                                        |
| -------- | ------- | -------------------------------------------------- |
| doInsert | Boolean | Boolean True if you want this to insert your user. |

#### Return Type

**User**

User the created user

---

### `createPermissionSet(permSetName, doInsert)`

Generates a test permission set record - no permissions are added to it

#### Signature

```apex
public static PermissionSet createPermissionSet(String permSetName, Boolean doInsert)
```

#### Parameters

| Name        | Type    | Description                                                   |
| ----------- | ------- | ------------------------------------------------------------- |
| permSetName | String  | String what to call your perm set                             |
| doInsert    | Boolean | Boolean true if you want this to insert your perm set record. |

#### Return Type

**PermissionSet**

PermissionSet the created permission set.

---

### `enableCustomPermission(permissionName, forUserId)`

Enables a custom permission using a permission set

#### Signature

```apex
public static void enableCustomPermission(String permissionName, Id forUserId)
```

#### Parameters

| Name           | Type   | Description                                           |
| -------------- | ------ | ----------------------------------------------------- |
| permissionName | String | String name of the custom permission you want created |
| forUserId      | Id     | Id user to assign the custom permission to.           |

#### Return Type

**void**

## Classes

### TestFactoryException Class

Internal custom exception class

## Interfaces

### FieldDefaults Interface

Use the FieldDefaults interface to set up values you want to default in for all objects

#### Methods

##### `getFieldDefaults()`

Interface used by implementing classes to define defaults.

###### Signature

```apex
public Map<Schema.SObjectField,Object> getFieldDefaults()
```

###### Return Type

**Map&lt;Schema.SObjectField,Object&gt;**

,[object Object]
