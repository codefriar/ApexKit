`APIVERSION: 58`

`STATUS: ACTIVE`

Helper class for the UserFactory class.
Responsible for manipulation of users and permissions

## Methods

### `public static Id fetchProfileIdByName(String profileName)`

Helper method to find a profile by name.

#### Parameters

| Param         | Description                        |
| ------------- | ---------------------------------- |
| `profileName` | String name of the profile to find |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| `Id` | Id of the profile, if found. |

### `public static Id fetchPermissionSetIdByName(String permissionSetName)`

helper to find permission set Id's by their name

#### Parameters

| Param               | Description                               |
| ------------------- | ----------------------------------------- |
| `permissionSetName` | String name of the permission set to find |

#### Returns

| Type | Description                               |
| ---- | ----------------------------------------- |
| `Id` | Id the id of the permission set, if found |

### `public static void forceInsert(User userToInsert, Boolean forceInsert)`

A helper method to extract DML from the UserFactory class. This inserts the user, if requested. Note, this should likely belong in a UserRepository class, but ... it'd likely be the only method in it so for now here it stays

#### Parameters

| Param          | Description                      |
| -------------- | -------------------------------- |
| `userToInsert` | User the user to insert          |
| `forceInsert`  | Boolean if true, does an insert. |

---
