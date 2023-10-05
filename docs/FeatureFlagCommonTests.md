`APIVERSION: 58`

`STATUS: ACTIVE`

Class serves to DRY code for various testing methods that
require it. It is not intended to be used directly.

## Fields

### `private EXAMPLE_FEATURE_FLAG_ID` → `Id`

This is the id of the feature flag that's included with ApexKit. CMDT can be hard to test with because you can't necessarily know the object prefix until a cmdt record is saved. :(

---

## Methods

### `public static Map getTestFlag(String flagName, Boolean enabled)`

DRY method to create a test flag with valid-ish id.

#### Parameters

| Param      | Description                                            |
| ---------- | ------------------------------------------------------ |
| `flagName` | String name of the Flag                                |
| `enabled`  | Boolean whether the flag is enabled universally or not |

#### Returns

| Type                            | Description                                |
| ------------------------------- | ------------------------------------------ |
| Map<String,Feature_Flag\_\_mdt> | Map<String, Feature_Flag\_\_mdt> test flag |

### `public static Id getExistingPermSetId()`

fetches a valid permission set id

#### Returns

| Type | Description                                                 |
| ---- | ----------------------------------------------------------- |
| Id   | Id the id of the permissionset that's included with ApexKit |

### `public static Map getOverriddenPerPermSet(String flagName, Id permSetId, Boolean enabled)`

returns a map of feature flags that are enabled just for a specified permission set

#### Parameters

| Param       | Description                                            |
| ----------- | ------------------------------------------------------ |
| `flagName`  | String name of the flag                                |
| `permSetId` | Id the id of the permission set that enables this flag |
| `enabled`   | Boolean whether the flag is enabled or not             |

#### Returns

| Type                                        | Description                                                           |
| ------------------------------------------- | --------------------------------------------------------------------- |
| Map<String,Feature_Flag_Enabled_For\_\_mdt> | Map<String, Feature_Flag_Enabled_For\_\_mdt> the map of feature flags |

---
