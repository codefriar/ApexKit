`STATUS: ACTIVE`

This class is responsible for querying / fetching FeatureFlag data. This is separate from the
FeatureFlag flag class to facilitate proper unit testing. (and just good design)

**Group** FeatureFlag

## Constructors

### `public FeatureFlagDataProvider()`

Default constructor. Pulls the custom metadata records without soql.

---

## Fields

### `public featureFlags` → `Map<String,Feature_Flag__mdt>`

Fetch the feature flags from custom metadata.

### `private mFeatureFlagsById` → `Map<String,Feature_Flag__mdt>`

memoized map of feature flags by id

### `private mPerCustomPermissionOverridesByFeatureFlag` → `Map<String,List<FF_Enabled_For_Custom_Permission__mdt>>`

`TESTVISIBLE`

memoized map of per-custom permission overrides by feature flag name

### `private mPerPermSetOverridesByFeatureFlag` → `Map<String,List<Feature_Flag_Enabled_For__mdt>>`

`TESTVISIBLE`

Memoized map of per-permission set overrides by feature flag name

### `public perCustomPermissionOverrides` → `Map<String,FF_Enabled_For_Custom_Permission__mdt>`

Fetch the per-custom permission overrides from custom metadata.

### `private perPermSetOverrides` → `Map<String,Feature_Flag_Enabled_For__mdt>`

Fetch the per-permission set overrides from custom metadata.

---

## Properties

### `private featureFlagsById` → `Map<String,Feature_Flag__mdt>`

Returns a map of known feature flag metadata records keyed by the record id, rather than the record's label.

### `public perCustomPermissionOverridesByFeatureFlag` → `Map<String,List<FF_Enabled_For_Custom_Permission__mdt>>`

Used to correlate related metadata records for per-custom permission enablement of features without having to burn a soql query to do so.

### `public perPermSetOverridesByFeatureFlag` → `Map<String,List<Feature_Flag_Enabled_For__mdt>>`

Used to correlate related metadata records for per-permission set enablement of features without having to burn a soql query to do so.

---

## Methods

### `public Set<String> enablingPermissionSets(String featureFlagName)`

Returns set of ids corresponding to permission set ids that provide feature enablement for the indicated feature flag

#### Parameters

| Param             | Description                                        |
| ----------------- | -------------------------------------------------- |
| `featureFlagName` | Name of the feature flag to calculate Perm Set Ids |

#### Returns

| Type          | Description                     |
| ------------- | ------------------------------- |
| `Set<String>` | `Set<Id>` of permission set ids |

### `public Set<String> enablingCustomPermissions(String featureFlagName)`

Returns set of Strings representing custom permission names that provide feature enablement for the indicated feature flag

#### Parameters

| Param             | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| `featureFlagName` | Name of the feature flag to calculate custom permission names |

#### Returns

| Type          | Description                              |
| ------------- | ---------------------------------------- |
| `Set<String>` | `Set<String>` of custom permission names |

### `public List<String> fetchUsersAssignedPermissionSets()`

Used to find a users' assigned permission set ids. This is intentionally tied to the _executing users' userId_.

#### Returns

| Type           | Description                                                           |
| -------------- | --------------------------------------------------------------------- |
| `List<String>` | `List<Id>` a list of permission set id's assigned to the current user |

### `private void overrideFlags(Map<String,Feature_Flag__mdt> flags)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present in the org

#### Parameters

| Param   | Description                                                               |
| ------- | ------------------------------------------------------------------------- |
| `flags` | Map of flags to override this class' loading of custom metadata for flags |

### `private void overridePerPermSetOverrides(Map<String,Feature_Flag_Enabled_For__mdt> perPermSetOverrides)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present in the org

#### Parameters

| Param                 | Description                                                                                                   |
| --------------------- | ------------------------------------------------------------------------------------------------------------- |
| `perPermSetOverrides` | Map of flags to override this class' loading of custom metadata for per-permission set enablement of features |

### `private void overridePerCustomPermissionOverrides(Map<String,FF_Enabled_For_Custom_Permission__mdt> perCustomPermissionOverrides)`

`TESTVISIBLE`

Allows testers to inject custom metadata records that are not present in the org

#### Parameters

| Param                          | Description                                                                                                      |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| `perCustomPermissionOverrides` | Map of flags to override this class' loading of custom metadata for per-custom-permission enablement of features |

### `private static Map<String,List<SObject>> rekeyMapByFeatureFlagName(Map<String,SObject> incomingMap, Map<String,List<SObject>> memoizedMap, Map<String,Feature_Flag__mdt> correlatingMap, String keyField)`

`SUPPRESSWARNINGS`

given an incoming map, create and return a new map where the keys are a from the correlation map and the values are the values of the incoming map. Uses a memoized map for building and is intended to be used with a memoization pattern.

#### Parameters

| Param            | Description                                                                                 |
| ---------------- | ------------------------------------------------------------------------------------------- |
| `incomingMap`    | This is the map that will provide the values to the resulting map.                          |
| `memoizedMap`    | This is the 'working' or memoized map that is iteratively built and ultimately returned.    |
| `correlatingMap` | This map provides the keys for the returned map                                             |
| `keyField`       | This is the field used to correlate the incoming map with the corresponding correlation map |

#### Returns

| Type                        | Description                  |
| --------------------------- | ---------------------------- |
| `Map<String,List<SObject>>` | `Map<String, List<sObject>>` |

---
