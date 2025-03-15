**Group** FeatureFlag

## Fields

### `dataProvider`

`TESTVISIBLE`

This property enables optional (testing) injection
of a data provider. Because this library relies on custom metadata
that has to be deployed, I needed to provide a way to inject a
data provider.

#### Signature

```apex
private dataProvider
```

#### Type

[FeatureFlagDataProvider](FeatureFlagDataProvider.md)

---

### `FF_NOT_ENABLED`

`TESTVISIBLE`

The API of this library enables an enabled feature to have
an optional String value. However, if the feature is not
defined in metadata, the value will be null. This ... could
be less than deterministic, so this will _always_ return a
string. When undefined by metadata, the value returned is
defined here.

#### Signature

```apex
private static final FF_NOT_ENABLED
```

#### Type

String

## Constructors

### `FeatureFlag()`

Default constructor.
defaults to setting the dataProvider to a new instance
of the FeatureFlagDataProvider

#### Signature

```apex
public FeatureFlag()
```

---

### `FeatureFlag(dataProvider)`

`TESTVISIBLE`

Private constructor. Accepts a previously constructed
Feature Flag Data Provider object. Used only during testing.

#### Signature

```apex
private FeatureFlag(FeatureFlagDataProvider dataProvider)
```

#### Parameters

| Name         | Type                                                  | Description                                                            |
| ------------ | ----------------------------------------------------- | ---------------------------------------------------------------------- |
| dataProvider | [FeatureFlagDataProvider](FeatureFlagDataProvider.md) | FeatureFlagDataProvider a previously constructed FFDataProvider object |

## Methods

### `value(featureFlagName)`

Returns the value of the specified feature flag
This method is deterministic. It will _always_ return a non-null String
In situations where the requested feature flag is not enabled, this
method returns the value specified above as FF_NOT_ENABLED

#### Signature

```apex
public String value(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                     |
| --------------- | ------ | ------------------------------- |
| featureFlagName | String | String name of the feature flag |

#### Return Type

**String**

,[object Object]

---

### `isEnabled(featureFlagName)`

Returns true if the specified feature flag is enabled
This is the main method of the FeatureFlag library. It checks three methods
of feature enablement:
&lt;br&gt;1. Global metadata enablement on the `Feature_Flag__mdt` record
&lt;br&gt;2. Enablement through a permission set that is shared between the running
user and the feature flag&#x27;s related list of `Feature_Flag_Enabled_For__mdt`
records
&lt;br&gt;3. Enablement through a list of custom permissions defined by
`FF_Enabled_For_Custom_Permission__mdt` records.

#### Signature

```apex
public Boolean isEnabled(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                     |
| --------------- | ------ | ------------------------------- |
| featureFlagName | String | String name of the feature flag |

#### Return Type

**Boolean**

,[object Object]

---

### `isNotEnabled(featureFlag)`

Convenience method for determining if a feature flag
is not enabled

#### Signature

```apex
public Boolean isNotEnabled(String featureFlag)
```

#### Parameters

| Name        | Type   | Description                  |
| ----------- | ------ | ---------------------------- |
| featureFlag | String | String name of flag to check |

#### Return Type

**Boolean**

,[object Object]

---

### `isUniversallyEnabled(featureFlagName)`

`TESTVISIBLE`

Logical test for global enablement of a feature

#### Signature

```apex
private Boolean isUniversallyEnabled(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                     |
| --------------- | ------ | ------------------------------- |
| featureFlagName | String | String name of the feature flag |

#### Return Type

**Boolean**

,[object Object]

---

### `isEnabledOnOrAfterToday(featureFlagName)`

`TESTVISIBLE`

#### Signature

```apex
private Boolean isEnabledOnOrAfterToday(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description |
| --------------- | ------ | ----------- |
| featureFlagName | String |             |

#### Return Type

**Boolean**

---

### `isEnabledForUser(featureFlagName)`

`TESTVISIBLE`

Logical test for per-user enablement of a feature

#### Signature

```apex
private Boolean isEnabledForUser(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                     |
| --------------- | ------ | ------------------------------- |
| featureFlagName | String | String name of the feature flag |

#### Return Type

**Boolean**

,[object Object]

---

### `isEnabledByCustomPermissionForUser(featureFlagName)`

`TESTVISIBLE`

Logic gate for determining if a feature flag is
enabled for this user based on a custom permission

#### Signature

```apex
private Boolean isEnabledByCustomPermissionForUser(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                     |
| --------------- | ------ | ------------------------------- |
| featureFlagName | String | String name of the feature flag |

#### Return Type

**Boolean**

,[object Object]
