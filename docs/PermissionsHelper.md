`APIVERSION: 58`

`STATUS: ACTIVE`

A test-only helper for manipulating users' permissions, permission sets and permission set groups

## Methods

### `public static void assignPermissionSetToUser(User userToAssignTo, Id permSetId)`

creates and inserts a permission set assignment record

#### Parameters

| Param            | Description                                              |
| ---------------- | -------------------------------------------------------- |
| `userToAssignTo` | User the user whom the permission set will be applied to |
| `permSetId`      | Id The Id of the permission set to assign to the user.   |

### `public static void assignPermSetToUser(User userToAssignTo, String permSetName)`

Assigns a permission set to a given user.

#### Parameters

| Param            | Description                           |
| ---------------- | ------------------------------------- |
| `userToAssignTo` | User to assign the permission set to. |
| `permSetName`    | String name of the permission set.    |

### `public static PermissionSet createPermissionSet(String permSetName, Boolean doInsert)`

Generates a test permission set record - no permissions are added to it

#### Parameters

| Param         | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `permSetName` | String what to call your perm set                             |
| `doInsert`    | Boolean true if you want this to insert your perm set record. |

#### Returns

| Type            | Description                               |
| --------------- | ----------------------------------------- |
| `PermissionSet` | PermissionSet the created permission set. |

### `public static void enableCustomPermission(String permissionName, Id forUserId)`

Enables a custom permission using a permission set

#### Parameters

| Param            | Description                                           |
| ---------------- | ----------------------------------------------------- |
| `permissionName` | String name of the custom permission you want created |
| `forUserId`      | Id user to assign the custom permission to.           |

---
