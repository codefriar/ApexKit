`APIVERSION: 58`

`STATUS: ACTIVE`

A factory class for generating Users during Unit Tests
While this class has generic user-building methods, the bulk of this
class is dedicated to building persona-specific users

## Methods

### `public static User createMinAccessPersonaUser(Boolean forceInsert)`

Creates a user with the Minimum Access Profile

#### Parameters

| Param         | Description                       |
| ------------- | --------------------------------- |
| `forceInsert` | Should this code insert the user? |

#### Returns

| Type   | Description |
| ------ | ----------- |
| `User` | `User`      |

#### Example

```apex
`User testUser = UserFactory.createMinAccessPersonaUser(false);`
```

### `public static User createMarketingPersonaUser(Boolean forceInsert)`

creates a Marketing Persona user

#### Parameters

| Param         | Description                           |
| ------------- | ------------------------------------- |
| `forceInsert` | Boolean should this user be inserted? |

#### Returns

| Type   | Description                 |
| ------ | --------------------------- |
| `User` | User created marketing user |

#### Example

```apex
`User testUser = UserFactory.createMinAccessPersonaUser(false);`
```

### `public static User createTestUser(Id profileId, Boolean forceInsert)`

creates a test user. Useful for permissions testing

#### Parameters

| Param         | Description                                |
| ------------- | ------------------------------------------ |
| `profileId`   | Profile Id to use when creating a user.    |
| `forceInsert` | Boolean, should this code insert the user? |

#### Returns

| Type   | Description |
| ------ | ----------- |
| `User` | `User`      |

#### Example

```apex
`User testUser = UserFactory.createTestUser(someProfileIdVar, false);`
```

### `public static User createTestUser(String profileName, Boolean forceInsert)`

Creates a test user with a given profile.

#### Parameters

| Param         | Description                                  |
| ------------- | -------------------------------------------- |
| `profileName` | Name of the profile to create the user with. |
| `forceInsert` | Should this code insert the created user?    |

#### Returns

| Type   | Description |
| ------ | ----------- |
| `User` | `User`      |

#### Example

```apex
`User testUser = UserFactory.createTestUser('ProfileName', false);`
```

---
