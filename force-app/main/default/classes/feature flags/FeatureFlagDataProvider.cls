public with sharing class FeatureFlagDataProvider {
	/**
	 * Fetch the feature flags from custom metadata.
	 */
	public Map<String, Feature_Flag__mdt> featureFlags;
	private Map<String, Feature_Flag_Enabled_For__mdt> perPermSetOverrides;
	public Map<String, FF_Enabled_For_Custom_Permission__mdt> perCustomPermissionOverrides;
	private Map<String, Feature_Flag__mdt> mFeatureFlagsById;

	@testVisible
	private Map<String, List<Feature_Flag_Enabled_For__mdt>> mPerPermSetOverridesByFeatureFlag;
	@testVisible
	private Map<String, List<FF_Enabled_For_Custom_Permission__mdt>> mPerCustomPermissionOverridesByFeatureFlag;

	/**
	 * Returns a map of known feature flag metadata records keyed
	 * by the record id, rather than the record's label.
	 */
	private Map<String, Feature_Flag__mdt> featureFlagsById {
		get {
			if (this.mFeatureFlagsById != null) {
				return mFeatureFlagsById;
			}
			this.mFeatureFlagsById = new Map<String, Feature_Flag__mdt>();
			for (Feature_Flag__mdt ff : featureFlags.values()) {
				this.mFeatureFlagsById.put(ff.Id, ff);
			}

			return mFeatureFlagsById;
		}
	}

	/**
	 * @description Used to correlate related metadata records for
	 * per-permission set enablement of features without having to
	 * burn a soql query to do so.
	 */
	public Map<String, List<Feature_Flag_enabled_for__mdt>> perPermSetOverridesByFeatureFlag {
		get {
			if (this.mPerPermSetOverridesByFeatureFlag != null) {
				return this.mPerPermSetOverridesByFeatureFlag;
			}
			return (Map<String, List<Feature_Flag_Enabled_For__mdt>>) rekeyMapByFeatureFlagName(
				this.perPermSetOverrides,
				this.mPerPermSetOverridesByFeatureFlag,
				this.featureFlagsById,
				'Feature_Flag__c'
			);
		}
	}

	/**
	 * @description Used to correlate related metadata records for
	 * per-custom permission enablement of features without
	 * having to burn a soql query to do so.
	 */
	public Map<String, List<FF_Enabled_For_Custom_Permission__mdt>> perCustomPermissionOverridesByFeatureFlag {
		get {
			if (this.mPerCustomPermissionOverridesByFeatureFlag != null) {
				return this.mPerCustomPermissionOverridesByFeatureFlag;
			}

			return (Map<String, List<FF_Enabled_For_Custom_Permission__mdt>>) rekeyMapByFeatureFlagName(
				this.perCustomPermissionOverrides,
				this.mPerCustomPermissionOverridesByFeatureFlag,
				this.featureFlagsById,
				'Feature_Flag__c'
			);
		}
	}

	/**
	 * @description Default constructor. Pulls the custom metadata records without soql.
	 */
	public FeatureFlagDataProvider() {
		this.featureFlags = Feature_Flag__mdt.getAll();
		this.perPermSetOverrides = Feature_Flag_Enabled_For__mdt.getAll();
		this.perCustomPermissionOverrides = FF_Enabled_For_Custom_Permission__mdt.getAll();
	}

	/**
	 * @description Returns set of ids corresponding to permission set ids
	 * that provide feature enablement for the indicated feature flag
	 * @param featureFlagName Name of the feature flag to calculate Perm Set Ids
	 * @return `Set<Id>` of permission set ids
	 */
	public Set<String> enablingPermissionSets(String featureFlagName) {
		if (
			String.isEmpty(featureFlagName) ||
			!perPermSetOverridesByFeatureFlag.containsKey(featureFlagName)
		) {
			return new Set<String>();
		}

		List<Feature_Flag_Enabled_For__mdt> permSetOverrides = (List<Feature_Flag_Enabled_For__mdt>) perPermSetOverridesByFeatureFlag.get(
			featureFlagName
		);
		Set<String> overriddenForPermissionSets = new Set<String>();
		for (Feature_Flag_Enabled_For__mdt current : permSetOverrides) {
			overriddenForPermissionSets.add(current.Permission_Set_Id__c);
		}
		return overriddenForPermissionSets;
	}

	/**
	 * @description Returns set of Strings representing custom permission
	 * names that provide feature enablement for the indicated feature flag
	 * @param featureFlagName Name of the feature flag to calculate custom permission
	 * names
	 * @return `Set<String>` of custom permission names
	 */
	public Set<String> enablingCustomPermissions(String featureFlagName) {
		if (
			String.isEmpty(featureFlagName) ||
			!this.perCustomPermissionOverridesByFeatureFlag.containsKey(
				featureFlagName
			)
		) {
			return new Set<String>();
		}
		List<String> overriddenForCustomPermissions = Polyfills.pluckFieldFromList(
			'DeveloperName',
			this.perCustomPermissionOverridesByFeatureFlag.get(featureFlagName)
		);
		Set<String> returnValues = new Set<String>();
		returnValues.addAll(overriddenForCustomPermissions);

		return returnValues;
	}

	/**
	 * @description Used to find a users' assigned permission set ids.
	 * This is intentionally tied to the *executing users' userId*.
	 * @return      `List<Id>`
	 */
	public List<String> fetchUsersAssignedPermissionSets() {
		Id userId = UserInfo.getUserId();
		List<PermissionSetAssignment> permSetRecords = (List<PermissionSetAssignment>) new SOQL.Builder(
				'PermissionSetAssignment'
			)
			.selectField('permissionSetId')
			.whereCondition(new Query.Condition().equals('assigneeId', userId))
			.build()
			.getRecords();
		return (List<String>) Polyfills.pluckFieldFromList(
			'PermissionSetId',
			permSetRecords
		);
	}

	/**
	 * @description Allows testers to inject custom metadata records that are not present
	 * in the org
	 * @param flags Map of flags to override this class' loading of custom metadata for flags
	 */
	@testVisible
	private void overrideFlags(Map<String, Feature_flag__mdt> flags) {
		this.featureFlags = flags;
	}

	/**
	 * @description Allows testers to inject custom metadata records that are not present
	 * in the org
	 * @param perPermSetOverrides Map of flags to override this class' loading of
	 * custom metadata for per-permission set enablement of features
	 */
	@testVisible
	private void overridePerPermSetOverrides(
		Map<String, Feature_Flag_Enabled_For__mdt> perPermSetOverrides
	) {
		this.perPermSetOverrides = perPermSetOverrides;
	}

	/**
	 * @description Allows testers to inject custom metadata records that are not present
	 * in the org
	 * @param perCustomPermissionOverrides Map of flags to override this class' loading of
	 * custom metadata for per-custom-permission enablement of features
	 */
	@testVisible
	private void overridePerCustomPermissionOverrides(
		Map<String, FF_Enabled_For_Custom_Permission__mdt> perCustomPermissionOverrides
	) {
		this.perCustomPermissionOverrides = perCustomPermissionOverrides;
	}

	/**
	 * @description          given an incoming map, create and return a new map
	 * where the keys are a from the correlation map and the values are
	 * the values of the incoming map. Uses a memoized map for building
	 * and is intended to be used with a memoization pattern.
	 * @param incomingMap    This is the map that will provide the values to
	 * the resulting map.
	 * @param memoizedMap    This is the 'working' or memoized map that is
	 * iteratively built and ultimately returned.
	 * @param correlatingMap This map provides the keys for the returned map
	 * @param keyField       This is the field used to correlate the
	 * incoming map with the corresponding correlation map
	 * @return               `Map<String, List<sObject>>`
	 */
	private Map<String, List<sObject>> rekeyMapByFeatureFlagName(
		Map<String, sObject> incomingMap,
		Map<String, List<sObject>> memoizedMap,
		Map<String, Feature_Flag__mdt> correlatingMap,
		String keyField
	) {
		memoizedMap = new Map<String, List<sObject>>();
		for (sObject currentObject : incomingMap.values()) {
			String correlationKey = correlatingMap.get(
					String.valueOf(currentObject.get(keyField))
				)
				?.DeveloperName;
			if (memoizedMap.containsKey(correlationKey)) {
				memoizedMap.get(correlationKey).add(currentObject);
			} else {
				memoizedMap.put(
					correlationKey,
					new List<sObject>{ currentObject }
				);
			}
		}
		return memoizedMap;
	}
}