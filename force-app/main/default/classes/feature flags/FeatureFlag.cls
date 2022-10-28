/**
 * @description Provides a unified, simple and testable api for feature flags
 */
public with sharing class FeatureFlag {
    @testVisible
    private FeatureFlagDataProvider dataProvider;

    public FeatureFlag() {
        this.dataProvider = new FeatureFlagDataProvider();
    }

    @testVisible
    private FeatureFlag(FeatureFlagDataProvider dataProvider) {
        this.dataProvider = dataProvider;
    }

    public Boolean isEnabled(String featureFlagName) {
        // GUARD CLAUSE: If the feature flag is not in the custom metadata, return false
        if (!dataProvider.flags.containsKey(featureFlagName)) {
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

    @testVisible
    private Boolean isUniversallyEnabled(String featureFlagName) {
        return dataProvider.flags.get(featureFlagName).isEnabled__c;
    }

    @testVisible
    private Boolean isEnabledForUser(String featureFlagName) {
        List<Id> usersAssignedPermissionSets = fetchUsersAssignedPermissionSets();
        Set<Id> overriddenForPermissionSets = buildPermissionSetIdsFromFeatureFlagEnabledforMetadata(
            featureFlagName
        );
        return Polyfills.setContainsAnyItemFromList(
            overriddenForPermissionSets,
            usersAssignedPermissionSets
        );
    }

    @testVisible
    private Set<Id> buildPermissionSetIdsFromFeatureFlagEnabledforMetadata(
        String featureFlagName
    ) {
        if (
            String.isEmpty(featureFlagName) ||
            !dataProvider.perPermSetOverrides.containsKey(featureFlagName)
        ) {
            return new Set<Id>();
        }
        Id flagId = dataProvider.perPermSetOverrides.get(featureFlagName).Id;
        Set<Id> overriddenForPermissionSets = new Set<Id>();
        for (
            Feature_Flag_Enabled_For__mdt flag : dataProvider.perPermSetOverrides.values()
        ) {
            if (flag.Feature_Flag__c == flagId) {
                overriddenForPermissionSets.add(flag.Permission_Set_Id__c);
            }
        }
        return overriddenForPermissionSets;
    }

    @testVisible
    private List<Id> fetchUsersAssignedPermissionSets() {
        Id userId = UserInfo.getUserId();
        List<PermissionSetAssignment> permSetRecords = (List<PermissionSetAssignment>) new SOQL.Builder(
                'PermissionSetAssignment'
            )
            .selectField('permissionSetId')
            .whereCondition(new Query.Condition().equals('assigneeId', userId))
            .build()
            .getRecords();
        return (List<Id>) Polyfills.pluckFieldFromList(
            'PermissionSetId',
            permSetRecords
        );
    }
}
