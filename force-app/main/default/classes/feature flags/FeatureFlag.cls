/**
 * @description Provides a unified, simple and testable api for feature flags
 */
public with sharing class FeatureFlag {
	/**
	 * @description This property enables optional (testing) injection
	 * of a data provider. Because this library relies on custom metadata
	 * that has to be deployed, I needed to provide a way to inject a
	 * data provider.
	 */
	@testVisible
	private FeatureFlagDataProvider dataProvider;

	/**
	 * The API of this library enables an enabled feature to have
	 * an optional String value. However, if the feature is not
	 * defined in metadata, the value will be null. This ... could
	 * be less than deterministic, so this will *always* return a
	 * string. When undefined by metadata, the value returned is
	 * defined here.
	 */
	@testVisible
	private static final String FF_NOT_ENABLED = 'FF_NOT_ENABLED';

	/**
	 * @description Default constructor.
	 * defaults to setting the dataProvider to a new instance
	 * of the FeatureFlagDataProvider
	 */
	public FeatureFlag() {
		this.dataProvider = new FeatureFlagDataProvider();
	}

	/**
	 * @description           Returns the value of the specified feature flag
	 * This method is deterministic. It will *always* return a non-null String
	 * In situations where the requested feature flag is not enabled, this
	 * method returns the value specified above as FF_NOT_ENABLED
	 * @param featureFlagName String name of the feature flag
	 * @return                `String`
	 */
	public String value(String featureFlagName) {
		if (isNotEnabled(featureFlagName)) {
			return FF_NOT_ENABLED;
		}
		return dataProvider.featureFlags.get(featureFlagName).flag_value__c;
	}

	/**
	 * @description          Returns true if the specified feature flag is enabled
	 * This is the main method of the FeatureFlag library. It checks three methods
	 * of feature enablement:
	 * <br>1. Global metadata enablement on the `Feature_Flag__mdt` record
	 * <br>2. Enablement through a permission set that is shared between the running
	 *  user and the feature flag's related list of `Feature_Flag_Enabled_For__mdt`
	 *  records
	 * <br>3. Enablement through a list of custom permissions defined by
	 *  `FF_Enabled_For_Custom_Permission__mdt` records.
	 * @param featureFlagName String name of the feature flag
	 * @return                `Boolean`
	 */

	public Boolean isEnabled(String featureFlagName) {
		// GUARD CLAUSE: If the feature flag is not in the custom metadata, return false
		if (!dataProvider.featureFlags.containsKey(featureFlagName)) {
			return false;
		}
		// determine if the feature flag is universally enabled
		if (isUniversallyEnabled(featureFlagName)) {
			return true;
		} else {
			// determine if the feature flag is enabled for the current user
			return isEnabledForUser(featureFlagName);
		}
	}

	/**
	 * @description       Convenience method for determining if a feature flag
	 * is not enabled
	 * @param featureFlag String name of flag to check
	 * @return            `Boolean`
	 */
	public Boolean isNotEnabled(String featureFlag) {
		return !isEnabled(featureFlag);
	}

	////////////////////////// Private Methods //////////////////////////

	/**
	 * @description        Private constructor. Accepts a previously constructed
	 * Feature Flag Data Provider object. Used only during testing.
	 * @param dataProvider
	 */
	@testVisible
	private FeatureFlag(FeatureFlagDataProvider dataProvider) {
		this.dataProvider = dataProvider;
	}

	/**
	 * @description           Logical test for global enablement of a feature
	 * @param featureFlagName String name of the feature flag
	 * @return                `Boolean`
	 */
	@testVisible
	private Boolean isUniversallyEnabled(String featureFlagName) {
		return dataProvider.featureFlags.get(featureFlagName).isEnabled__c;
	}

	/**
	 * @description           Logical test for per-user enablement of a feature
	 * @param featureFlagName String name of the feature flag
	 * @return                `Boolean`
	 */
	@testVisible
	private Boolean isEnabledForUser(String featureFlagName) {
		// first check for enablement via custom permission because
		// that doesn't hit the db for anything.
		if (isEnabledByCustomPermissionForUser(featureFlagName)) {
			return true;
		}
		return Polyfills.setContainsAnyItemFromList(
			dataProvider.enablingPermissionSets(featureFlagName),
			dataProvider.fetchUsersAssignedPermissionSets()
		);
	}

	/**
	 * @description           Logic gate for determining if a feature flag is
	 * enabled for this user based on a custom permission
	 * @param featureFlagName String name of the feature flag
	 * @return                `Boolean`
	 */
	@testVisible
	private Boolean isEnabledByCustomPermissionForUser(String featureFlagName) {
		Boolean isEnabledByCustomPermission = false;

		for (
			String customPermissionName : dataProvider.enablingCustomPermissions(
				featureFlagName
			)
		) {
			if (FeatureManagement.checkPermission(customPermissionName)) {
				isEnabledByCustomPermission = true;
				break;
			}
		}
		return isEnabledByCustomPermission;
	}
}