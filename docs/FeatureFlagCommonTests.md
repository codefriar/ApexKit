Class serves to DRY code for various testing methods that
require it. It is not intended to be used directly.

## Fields

### `EXAMPLE_FEATURE_FLAG_ID`

This is the id of the feature flag that&#x27;s included with ApexKit. CMDT can be hard to test with
because you can&#x27;t necessarily know the object prefix until a cmdt record is saved. :(

#### Signature

```apex
private static final EXAMPLE_FEATURE_FLAG_ID
```

#### Type

Id

## Methods

### `getTestFlag(flagName, enabled)`

DRY method to create a test flag with valid-ish id.

#### Signature

```apex
public static Map<String,Feature_Flag__mdt> getTestFlag(String flagName, Boolean enabled)
```

#### Parameters

| Name     | Type    | Description                                            |
| -------- | ------- | ------------------------------------------------------ |
| flagName | String  | String name of the Flag                                |
| enabled  | Boolean | Boolean whether the flag is enabled universally or not |

#### Return Type

**Map&lt;String,Feature_Flag\_\_mdt&gt;**

Map&lt;String, Feature_Flag\_\_mdt&gt; test flag

---

### `getExistingPermSetId()`

fetches a valid permission set id

#### Signature

```apex
public static Id getExistingPermSetId()
```

#### Return Type

**Id**

Id the id of the permissionset that&#x27;s included with ApexKit

---

### `getOverriddenPerPermSet(flagName, permSetId, enabled)`

returns a map of feature flags that are enabled just for a specified permission set

#### Signature

```apex
public static Map<String,Feature_Flag_Enabled_For__mdt> getOverriddenPerPermSet(String flagName, Id permSetId, Boolean enabled)
```

#### Parameters

| Name      | Type    | Description                                            |
| --------- | ------- | ------------------------------------------------------ |
| flagName  | String  | String name of the flag                                |
| permSetId | Id      | Id the id of the permission set that enables this flag |
| enabled   | Boolean | Boolean whether the flag is enabled or not             |

#### Return Type

**Map&lt;String,Feature_Flag_Enabled_For\_\_mdt&gt;**

Map&lt;String, Feature_Flag_Enabled_For\_\_mdt&gt; the map of feature flags
