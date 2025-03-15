FeatureFlag flag class to facilitate proper unit testing. (and just good design)

**Group** FeatureFlag

## Fields

### `featureFlags`

Fetch the feature flags from custom metadata.

#### Signature

```apex
public featureFlags
```

#### Type

Map&lt;String,Feature_Flag\_\_mdt&gt;

---

### `perPermSetOverrides`

Fetch the per-permission set overrides from custom metadata.

#### Signature

```apex
private perPermSetOverrides
```

#### Type

Map&lt;String,Feature_Flag_Enabled_For\_\_mdt&gt;

---

### `perCustomPermissionOverrides`

Fetch the per-custom permission overrides from custom metadata.

#### Signature

```apex
public perCustomPermissionOverrides
```

#### Type

Map&lt;String,FF_Enabled_For_Custom_Permission\_\_mdt&gt;

---

### `mFeatureFlagsById`

memoized map of feature flags by id

#### Signature

```apex
private mFeatureFlagsById
```

#### Type

Map&lt;String,Feature_Flag\_\_mdt&gt;

---

### `mPerPermSetOverridesByFeatureFlag`

`TESTVISIBLE`

Memoized map of per-permission set overrides by feature flag name

#### Signature

```apex
private mPerPermSetOverridesByFeatureFlag
```

#### Type

Map&lt;String,List&lt;Feature_Flag_Enabled_For\_\_mdt&gt;&gt;

---

### `mPerCustomPermissionOverridesByFeatureFlag`

`TESTVISIBLE`

memoized map of per-custom permission overrides by feature flag name

#### Signature

```apex
private mPerCustomPermissionOverridesByFeatureFlag
```

#### Type

Map&lt;String,List&lt;FF_Enabled_For_Custom_Permission\_\_mdt&gt;&gt;

## Properties

### `featureFlagsById`

Returns a map of known feature flag metadata records keyed
by the record id, rather than the record&#x27;s label.

#### Signature

```apex
private final featureFlagsById
```

#### Type

Map&lt;String,Feature_Flag\_\_mdt&gt;

---

### `perPermSetOverridesByFeatureFlag`

Used to correlate related metadata records for
per-permission set enablement of features without having to
burn a soql query to do so.

#### Signature

```apex
public perPermSetOverridesByFeatureFlag
```

#### Type

Map&lt;String,List&lt;Feature_Flag_Enabled_For\_\_mdt&gt;&gt;

---

### `perCustomPermissionOverridesByFeatureFlag`

Used to correlate related metadata records for
per-custom permission enablement of features without
having to burn a soql query to do so.

#### Signature

```apex
public perCustomPermissionOverridesByFeatureFlag
```

#### Type

Map&lt;String,List&lt;FF_Enabled_For_Custom_Permission\_\_mdt&gt;&gt;

## Constructors

### `FeatureFlagDataProvider()`

Default constructor. Pulls the custom metadata records without soql.

#### Signature

```apex
public FeatureFlagDataProvider()
```

## Methods

### `enablingPermissionSets(featureFlagName)`

Returns set of ids corresponding to permission set ids
that provide feature enablement for the indicated feature flag

#### Signature

```apex
public Set<String> enablingPermissionSets(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                                        |
| --------------- | ------ | -------------------------------------------------- |
| featureFlagName | String | Name of the feature flag to calculate Perm Set Ids |

#### Return Type

**Set&lt;String&gt;**

,[object Object], of permission set ids

---

### `enablingCustomPermissions(featureFlagName)`

Returns set of Strings representing custom permission
names that provide feature enablement for the indicated feature flag

#### Signature

```apex
public Set<String> enablingCustomPermissions(String featureFlagName)
```

#### Parameters

| Name            | Type   | Description                                             |
| --------------- | ------ | ------------------------------------------------------- |
| featureFlagName | String | Name of the feature flag to calculate custom permission |
| names           |

#### Return Type

**Set&lt;String&gt;**

,[object Object], of custom permission names

---

### `fetchUsersAssignedPermissionSets()`

Used to find a users&#x27; assigned permission set ids.
This is intentionally tied to the _executing users&#x27; userId_.

#### Signature

```apex
public List<String> fetchUsersAssignedPermissionSets()
```

#### Return Type

**List&lt;String&gt;**

,[object Object], a list of permission set id&#x27;s assigned to the current user

---

### `overrideFlags(flags)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present
in the org

#### Signature

```apex
private void overrideFlags(Map<String,Feature_Flag__mdt> flags)
```

#### Parameters

| Name  | Type                                  | Description                                                                    |
| ----- | ------------------------------------- | ------------------------------------------------------------------------------ |
| flags | Map&lt;String,Feature_Flag\_\_mdt&gt; | Map of flags to override this class&#x27; loading of custom metadata for flags |

#### Return Type

**void**

---

### `overridePerPermSetOverrides(perPermSetOverrides)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present
in the org

#### Signature

```apex
private void overridePerPermSetOverrides(Map<String,Feature_Flag_Enabled_For__mdt> perPermSetOverrides)
```

#### Parameters

| Name                                                          | Type                                              | Description                                          |
| ------------------------------------------------------------- | ------------------------------------------------- | ---------------------------------------------------- |
| perPermSetOverrides                                           | Map&lt;String,Feature_Flag_Enabled_For\_\_mdt&gt; | Map of flags to override this class&#x27; loading of |
| custom metadata for per-permission set enablement of features |

#### Return Type

**void**

---

### `overridePerCustomPermissionOverrides(perCustomPermissionOverrides)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present
in the org

#### Signature

```apex
private void overridePerCustomPermissionOverrides(Map<String,FF_Enabled_For_Custom_Permission__mdt> perCustomPermissionOverrides)
```

#### Parameters

| Name                                                             | Type                                                      | Description                                          |
| ---------------------------------------------------------------- | --------------------------------------------------------- | ---------------------------------------------------- |
| perCustomPermissionOverrides                                     | Map&lt;String,FF_Enabled_For_Custom_Permission\_\_mdt&gt; | Map of flags to override this class&#x27; loading of |
| custom metadata for per-custom-permission enablement of features |

#### Return Type

**void**

---

### `rekeyMapByFeatureFlagName(incomingMap, memoizedMap, correlatingMap, keyField)`

`SUPPRESSWARNINGS`

given an incoming map, create and return a new map
where the keys are a from the correlation map and the values are
the values of the incoming map. Uses a memoized map for building
and is intended to be used with a memoization pattern.

#### Signature

```apex
private static Map<String,List<SObject>> rekeyMapByFeatureFlagName(Map<String,SObject> incomingMap, Map<String,List<SObject>> memoizedMap, Map<String,Feature_Flag__mdt> correlatingMap, String keyField)
```

#### Parameters

| Name                                                | Type                                  | Description                                             |
| --------------------------------------------------- | ------------------------------------- | ------------------------------------------------------- |
| incomingMap                                         | Map&lt;String,SObject&gt;             | This is the map that will provide the values to         |
| the resulting map.                                  |
| memoizedMap                                         | Map&lt;String,List&lt;SObject&gt;&gt; | This is the &#x27;working&#x27; or memoized map that is |
| iteratively built and ultimately returned.          |
| correlatingMap                                      | Map&lt;String,Feature_Flag\_\_mdt&gt; | This map provides the keys for the returned map         |
| keyField                                            | String                                | This is the field used to correlate the                 |
| incoming map with the corresponding correlation map |

#### Return Type

**Map&lt;String,List&lt;SObject&gt;&gt;**

,[object Object]
