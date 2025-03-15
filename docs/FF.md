**Group** FeatureFlag

## Methods

### `isEnabled(featureName)`

Convenience method for checking if a feature is enabled.

#### Signature

```apex
public static Boolean isEnabled(String featureName)
```

#### Parameters

| Name        | Type   | Description                  |
| ----------- | ------ | ---------------------------- |
| featureName | String | String feature name to check |

#### Return Type

**Boolean**

True if the feature is enabled by any of the following: Universally enabled, or enabled for the current,[object Object],user based on permission set, custom permission or time.

---

### `isNotEnabled(featureName)`

logical inverse of the isEnabled method.

#### Signature

```apex
public static Boolean isNotEnabled(String featureName)
```

#### Parameters

| Name        | Type   | Description                  |
| ----------- | ------ | ---------------------------- |
| featureName | String | String feature name to check |

#### Return Type

**Boolean**

Boolean, returns inverse of isEnabled.

---

### `value(featureName)`

Law of diminishing returns here. This isn&#x27;t tested, per-say. It&#x27;s underlying FeatureFlag
implementation _is_ tested, however.

#### Signature

```apex
public static String value(String featureName)
```

#### Parameters

| Name        | Type   | Description                      |
| ----------- | ------ | -------------------------------- |
| featureName | String | String the feature name to check |

#### Return Type

**String**

String the value stored in custom metadata for this feature flag.
