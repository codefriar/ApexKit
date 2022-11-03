@isTest
class FeatureFlagDataProviderTests {
    @isTest
    static void testEnablingPermissionSetsPositive() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Id permSetId = FeatureFlagCommonTests.getExistingPermSetId();
        dataProvider.overrideFlags(
            FeatureFlagCommonTests.getTestFlag('TestFlag', true)
        );
        dataProvider.overridePerPermSetOverrides(
            FeatureFlagCommonTests.getOverriddenPerPermSet(
                'TestFlag',
                permSetId,
                true
            )
        );
        Test.startTest();
        Set<String> result = dataProvider.enablingPermissionSets('TestFlag');
        Test.stopTest();
        System.assertEquals(
            true,
            result.contains(permSetId),
            'User should have assigned permission set'
        );
    }

    @isTest
    static void testReturnEmptySetWhenNoPermSetOverridesFound() {
        FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
        Test.startTest();
        Set<String> result = dataProvider.enablingPermissionSets('TestFlag');
        Test.stopTest();
        System.assertEquals(
            result.isEmpty(),
            true,
            'Should return empty set when no perm set overrides found'
        );
    }
}
