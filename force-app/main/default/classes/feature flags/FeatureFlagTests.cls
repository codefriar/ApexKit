@isTest
class FeatureFlagTests {
    @isTest
    static void testDefaultConstructorPositive() {
        FeatureFlag featureFlag = new FeatureFlag();
        System.assertNotEquals(
            null,
            featureFlag.dataProvider,
            'Default constructor should set dataProvider'
        );
    }

    @isTest
    static void testFeatureFlagNotFoundReturnsFalse() {
        Test.startTest();
        Boolean result = FF.isEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(false, result);
    }

    @isTest
    static void testFeatureFlagFoundReturnsTrue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        dataProvider.overrideFlags(getTestFlag('TestFlag', true));

        Test.startTest();
        Boolean result = new FeatureFlag(dataProvider).isEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFeatureFlagEnabledForPermSetFoundReturnsTrue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = getExistingPermSetId();

        insert new PermissionSetAssignment(
            PermissionSetId = permSetId,
            AssigneeId = UserInfo.getUserId()
        );

        dataProvider.overrideFlags(getTestFlag('TestFlag', false));
        dataProvider.overridePerPermSetOverrides(
            getOverriddenPerPermSet('TestFlag', permSetId, true)
        );

        Test.startTest();
        Boolean result = new FeatureFlag(dataProvider).isEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFetchUsersAssignedPermissionSetsPositive() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = getExistingPermSetId();
        insert new PermissionSetAssignment(
            PermissionSetId = permSetId,
            AssigneeId = UserInfo.getUserId()
        );
        Test.startTest();
        FeatureFlag ff = new FeatureFlag();
        List<Id> result = ff.fetchUsersAssignedPermissionSets();
        Test.stopTest();
        System.assertEquals(
            result.contains(permSetId),
            true,
            'User should have assigned permission set'
        );
    }

    @isTest
    static void buildPermissionSetIdsFromFeatureFlagEnabledforMetadata() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = getExistingPermSetId();
        dataProvider.overridePerPermSetOverrides(
            getOverriddenPerPermSet('TestFlag', permSetId, true)
        );
        Test.startTest();
        FeatureFlag ff = new FeatureFlag(dataProvider);
        Set<Id> result = ff.buildPermissionSetIdsFromFeatureFlagEnabledforMetadata(
            'TestFlag'
        );
        Test.stopTest();
        System.assertEquals(
            result.contains(permSetId),
            true,
            'User should have assigned permission set'
        );
    }

    @isTest
    static void testReturnEmptySetWhenNoPermSetOverridesFound() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Test.startTest();
        FeatureFlag ff = new FeatureFlag(dataProvider);
        Set<Id> result = ff.buildPermissionSetIdsFromFeatureFlagEnabledforMetadata(
            'TestFlag'
        );
        Test.stopTest();
        System.assertEquals(
            result.isEmpty(),
            true,
            'Should return empty set when no perm set overrides found'
        );
    }

    /**
     * HELPER METHODS
     */
    private static Map<String, Feature_Flag__mdt> getTestFlag(
        String flagName,
        Boolean enabled
    ) {
        Map<String, Feature_Flag__mdt> testFlag = new Map<String, Feature_Flag__mdt>();
        testFlag.put(
            'TestFlag',
            new Feature_Flag__mdt(Label = flagName, isEnabled__c = enabled)
        );
        return testFlag;
    }

    private static Id getExistingPermSetId() {
        return new SOQL.Builder('PermissionSet')
            .selectField('Id')
            .build()
            .getRecord()
            .Id;
    }

    private static Map<String, Feature_Flag_Enabled_For__mdt> getOverriddenPerPermSet(
        String flagName,
        Id permSetId,
        Boolean enabled
    ) {
        Map<String, Feature_Flag_Enabled_For__mdt> overriddenPerPermSet = new Map<String, Feature_Flag_Enabled_For__mdt>();
        overriddenPerPermSet.put(
            flagName,
            new Feature_Flag_Enabled_For__mdt(
                Label = 'TestFlag',
                isEnabled__c = enabled,
                Permission_Set_Id__c = permSetId
            )
        );
        return overriddenPerPermSet;
    }
}
