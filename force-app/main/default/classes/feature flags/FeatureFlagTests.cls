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
    static void testFlagFoundButDisabledReturnsFixedString() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', false)
        );

        Test.startTest();
        String result = new FeatureFlag(dataProvider).value('TestFlag');
        Test.stopTest();
        System.assertEquals(
            FeatureFlag.FF_NOT_ENABLED,
            result,
            'Expected to get fixed string when flag is disabled'
        );
    }

    @isTest
    static void testFlagNotFoundReturnsFixedString() {
        Test.startTest();
        String result = new FeatureFlag().value('TestFlag');
        Test.stopTest();
        System.assertEquals(
            FeatureFlag.FF_NOT_ENABLED,
            result,
            'Expected to get fixed string when flag is disabled'
        );
    }

    @isTest
    static void testFlagFoundAndEnabledReturnsValue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', true)
        );

        Test.startTest();
        String result = new FeatureFlag(dataProvider).value('TestFlag');
        Test.stopTest();
        System.assertEquals(
            'test value',
            result,
            'Expected to get value when flag is enabled'
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
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', true)
        );

        Test.startTest();
        Boolean result = new FeatureFlag(dataProvider).isEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFeatureFlagFoundIsNotEnabledReturnsTrue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', false)
        );

        Test.startTest();
        Boolean result = new FeatureFlag(dataProvider).isNotEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFeatureFlagFoundWrapperIsNotEnabledReturnsTrue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', false)
        );

        Test.startTest();
        Boolean result = FF.isNotEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFeatureFlagEnabledForPermSetFoundReturnsTrue() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = FeatureFlagCommonTests.getExistingPermSetId();

        insert new PermissionSetAssignment(
            PermissionSetId = permSetId,
            AssigneeId = UserInfo.getUserId()
        );

        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', false)
        );
        dataProvider.overridePerPermSetOverrides(
            FeatureFlagCommonTests.getOverriddenPerPermSet(
                'TestFlag',
                permSetId,
                true
            )
        );

        Test.startTest();
        Boolean result = new FeatureFlag(dataProvider).isEnabled('TestFlag');
        Test.stopTest();
        System.assertEquals(true, result);
    }

    @isTest
    static void testFetchUsersAssignedPermissionSetsPositive() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = FeatureFlagCommonTests.getExistingPermSetId();
        insert new PermissionSetAssignment(
            PermissionSetId = permSetId,
            AssigneeId = UserInfo.getUserId()
        );
        Test.startTest();
        List<Id> result = dataProvider.fetchUsersAssignedPermissionSets();
        Test.stopTest();
        System.assertEquals(
            result.contains(permSetId),
            true,
            'User should have assigned permission set'
        );
    }

    @isTest
    static void testFeatureFoundEnabledViaCustomPermissionPositive() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        TestFactory.enableCustomPermission(
            'ApexKit_Example',
            UserInfo.getUserId()
        );
        PermissionSetAssignment[] permSetsAssigned = [
            SELECT id, PermissionSet.Label
            FROM PermissionSetAssignment
            WHERE
                AssigneeId = :UserInfo.getUserId()
                AND PermissionSet.Label = 'Test Permission Set'
        ];
        System.debug(permSetsAssigned);
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', false)
        );
        Map<String, FF_Enabled_For_Custom_Permission__mdt> customPermOverrides = new Map<String, FF_Enabled_For_Custom_Permission__mdt>();
        customPermOverrides.put(
            'ApexKit_Example',
            new FF_Enabled_For_Custom_Permission__mdt(
                Label = 'ApexKit_Example',
                DeveloperName = 'ApexKit_Example',
                Feature_Flag__c = dataProvider.featureFlags.get('TestFlag').id
            )
        );
        dataProvider.overridePerCustomPermissionOverrides(customPermOverrides);
        FeatureFlag ff = new FeatureFlag(dataProvider);

        System.runAs(new User(Id = UserInfo.getUserId())) {
            Test.startTest();
            Boolean result = ff.isEnabled('TestFlag');
            Test.stopTest();
            System.assertEquals(
                true,
                result,
                'Expected TestFlag to be enabled by custom permission'
            );
        }

    }
}
