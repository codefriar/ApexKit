# FeatureFlag

Provides a unified, simple and testable api for feature flags

## Constructors

### `public FeatureFlag()`

Default constructor. defaults to setting the dataProvider to a new instance of the FeatureFlagDataProvider

### `private FeatureFlag(FeatureFlagDataProvider dataProvider)`

`TESTVISIBLE`

Private constructor. Accepts a previously constructed Feature Flag Data Provider object. Used only during testing.

#### Parameters

| Param          | Description                                                            |
| -------------- | ---------------------------------------------------------------------- |
| `dataProvider` | FeatureFlagDataProvider a previously constructed FFDataProvider object |

---

## Fields

### `private FF_NOT_ENABLED` → `String`

`TESTVISIBLE`

The API of this library enables an enabled feature to have an optional String value. However, if the feature is not defined in metadata, the value will be null. This ... could be less than deterministic, so this will _always_ return a string. When undefined by metadata, the value returned is defined here.

### `private dataProvider` → `FeatureFlagDataProvider`

`TESTVISIBLE`

This property enables optional (testing) injection of a data provider. Because this library relies on custom metadata that has to be deployed, I needed to provide a way to inject a data provider.

---

## Methods

### `public String value(String featureFlagName)`

Returns the value of the specified feature flag This method is deterministic. It will _always_ return a non-null String In situations where the requested feature flag is not enabled, this method returns the value specified above as FF_NOT_ENABLED

#### Parameters

| Param             | Description                     |
| ----------------- | ------------------------------- |
| `featureFlagName` | String name of the feature flag |

#### Returns

| Type   | Description |
| ------ | ----------- |
| String | `String`    |

### `public Boolean isEnabled(String featureFlagName)`

Returns true if the specified feature flag is enabled This is the main method of the FeatureFlag library. It checks three methods of feature enablement: <br>1. Global metadata enablement on the `Feature_Flag__mdt` record <br>2. Enablement through a permission set that is shared between the running user and the feature flag's related list of `Feature_Flag_Enabled_For__mdt` records <br>3. Enablement through a list of custom permissions defined by `FF_Enabled_For_Custom_Permission__mdt` records.

#### Parameters

| Param             | Description                     |
| ----------------- | ------------------------------- |
| `featureFlagName` | String name of the feature flag |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

### `public Boolean isNotEnabled(String featureFlag)`

Convenience method for determining if a feature flag is not enabled

#### Parameters

| Param         | Description                  |
| ------------- | ---------------------------- |
| `featureFlag` | String name of flag to check |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

### `private Boolean isUniversallyEnabled(String featureFlagName)`

`TESTVISIBLE`

Logical test for global enablement of a feature

#### Parameters

| Param             | Description                     |
| ----------------- | ------------------------------- |
| `featureFlagName` | String name of the feature flag |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

### `private Boolean isEnabledOnOrAfterToday(String featureFlagName)`

`TESTVISIBLE`

### `private Boolean isEnabledForUser(String featureFlagName)`

`TESTVISIBLE`

Logical test for per-user enablement of a feature

#### Parameters

| Param             | Description                     |
| ----------------- | ------------------------------- |
| `featureFlagName` | String name of the feature flag |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

### `private Boolean isEnabledByCustomPermissionForUser(String featureFlagName)`

`TESTVISIBLE`

Logic gate for determining if a feature flag is enabled for this user based on a custom permission

#### Parameters

| Param             | Description                     |
| ----------------- | ------------------------------- |
| `featureFlagName` | String name of the feature flag |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

---
