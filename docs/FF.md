`STATUS: ACTIVE`

Convenience class for checking feature flags. This is purely Syntactic sugar.

## Methods

### `public static Boolean isEnabled(String featureName)`

Convenience method for checking if a feature is enabled.

#### Parameters

| Param         | Description                  |
| ------------- | ---------------------------- |
| `featureName` | String feature name to check |

#### Returns

| Type    | Description                                                                                                                                                      |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Boolean | True if the feature is enabled by any of the following: Universally enabled, or enabled for the current user based on permission set, custom permission or time. |

### `public static Boolean isNotEnabled(String featureName)`

logical inverse of the isEnabled method.

#### Parameters

| Param         | Description                  |
| ------------- | ---------------------------- |
| `featureName` | String feature name to check |

#### Returns

| Type    | Description                            |
| ------- | -------------------------------------- |
| Boolean | Boolean, returns inverse of isEnabled. |

### `public static String value(String featureName)`

Law of diminishing returns here. This isn't tested, per-say. It's underlying FeatureFlag implementation _is_ tested, however.

#### Parameters

| Param         | Description                      |
| ------------- | -------------------------------- |
| `featureName` | String the feature name to check |

#### Returns

| Type   | Description                                                       |
| ------ | ----------------------------------------------------------------- |
| String | String the value stored in custom metadata for this feature flag. |

---
