@IsTest
class FeatureFlagTests {
	@IsTest
	private static void testDefaultConstructorPositive() {
		FeatureFlag featureFlag = new FeatureFlag();
		Assert.areNotEqual(
			null,
			featureFlag.dataProvider,
			'Default constructor should set dataProvider'
		);
	}

	@IsTest
	private static void testFlagFoundButDisabledReturnsFixedString() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', false)
		);

		Test.startTest();
		String result = new FeatureFlag(dataProvider).value('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			FeatureFlag.FF_NOT_ENABLED,
			result,
			'Expected to get fixed string when flag is disabled'
		);
	}

	@IsTest
	private static void testFlagNotFoundReturnsFixedString() {
		Test.startTest();
		String result = new FeatureFlag().value('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			FeatureFlag.FF_NOT_ENABLED,
			result,
			'Expected to get fixed string when flag is disabled'
		);
	}

	@IsTest
	private static void testFlagFoundAndEnabledReturnsValue() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', true)
		);

		Test.startTest();
		String result = new FeatureFlag(dataProvider).value('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			'test value',
			result,
			'Expected to get value when flag is enabled'
		);
	}

	@IsTest
	private static void testFeatureFlagNotFoundReturnsFalse() {
		Test.startTest();
		Boolean result = FF.isEnabled('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			false,
			result,
			'Expected to get false when flag is not found'
		);
	}

	@IsTest
	private static void testFeatureFlagFoundReturnsTrue() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', true)
		);

		Test.startTest();
		Boolean result = new FeatureFlag(dataProvider).isEnabled('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			true,
			result,
			'Expected to get true when flag is enabled'
		);
	}

	@IsTest
	private static void testFeatureFlagFoundIsNotEnabledReturnsTrue() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', false)
		);

		Test.startTest();
		Boolean result = new FeatureFlag(dataProvider).isNotEnabled('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			true,
			result,
			'Expected to get true when flag is disabled'
		);
	}

	@IsTest
	private static void testFeatureFlagFoundWrapperIsNotEnabledReturnsTrue() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', false)
		);

		Test.startTest();
		Boolean result = FF.isNotEnabled('TestFlag');
		Test.stopTest();
		Assert.areEqual(
			true,
			result,
			'Expected to get true when flag is disabled'
		);
	}

	@IsTest
	private static void testFeatureFlagEnabledForPermSetFoundReturnsTrue() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		Id permSetId = FeatureFlagCommonTests.getExistingPermSetId();

		Database.insert(
			new PermissionSetAssignment(
				PermissionSetId = permSetId,
				AssigneeId = UserInfo.getUserId()
			),
			false
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
		Assert.areEqual(
			true,
			result,
			'Expected to get true when flag is enabled'
		);
	}

	@IsTest
	private static void testFetchUsersAssignedPermissionSetsPositive() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		Id permSetId = FeatureFlagCommonTests.getExistingPermSetId();
		Database.insert(
			new PermissionSetAssignment(
				PermissionSetId = permSetId,
				AssigneeId = UserInfo.getUserId()
			),
			false
		);
		Test.startTest();
		List<Id> result = dataProvider.fetchUsersAssignedPermissionSets();
		Test.stopTest();
		Assert.areEqual(
			result.contains(permSetId),
			true,
			'User should have assigned permission set'
		);
	}

	@IsTest
	private static void testFeatureFoundEnabledViaCustomPermissionPositive() {
		FeatureFlagDataProvider dataProvider = new FeatureFlagDataProvider();
		TestFactory.enableCustomPermission(
			'ApexKit_Example',
			UserInfo.getUserId()
		);
		dataProvider.overrideFlags(
			FeatureFlagCommonTests.getTestFlag('TestFlag', false)
		);
		Map<String, FF_Enabled_For_Custom_Permission__mdt> customPermOverrides = new Map<String, FF_Enabled_For_Custom_Permission__mdt>();
		customPermOverrides.put(
			'ApexKit_Example',
			new FF_Enabled_For_Custom_Permission__mdt(
				Label = 'ApexKit_Example',
				DeveloperName = 'ApexKit_Example',
				Feature_Flag__c = dataProvider.featureFlags.get('TestFlag').Id
			)
		);
		dataProvider.overridePerCustomPermissionOverrides(customPermOverrides);
		FeatureFlag ff = new FeatureFlag(dataProvider);

		System.runAs(new User(Id = UserInfo.getUserId())) {
			Test.startTest();
			Boolean result = ff.isEnabled('TestFlag');
			Test.stopTest();
			Assert.areEqual(
				true,
				result,
				'Expected TestFlag to be enabled by custom permission'
			);
		}

	}
}
