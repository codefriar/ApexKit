@isTest
private class MetadataTriggerQueryServiceTests {
	@isTest
	private static void testGetMetadataTriggers() {
		MetadataTriggerQueryService mts = new MetadataTriggerQueryService(
			'Invalid_Object__c'
		);
		Test.startTest();
		List<Metadata_Driven_Trigger__mdt> triggers = mts.getMetadataTriggers();
		Test.stopTest();

		Assert.areEqual(
			triggers.size(),
			0,
			'Expected to find no metadata records'
		);
	}

	@isTest
	private static void testGetSObjectTypeNegative() {
		Boolean didCatchProperException = false;
		Test.startTest();
		try {
			MetadataTriggerQueryService.getSObjectType(null, null);
		} catch (MetadataTriggerFrameworkException triggerEx) {
			if (
				triggerEx.getMessage()
					.containsIgnoreCase(
						'Passed values for triggerNew and triggerOld are both null. Are you exercising this method outside of a trigger context?'
					)
			) {
				didCatchProperException = true;
			}
		}
		Test.stopTest();
		Assert.isTrue(
			didCatchProperException,
			'executing this method in a unit test should result in an exception'
		);
	}

	@isTest
	private static void testGetSObjectTypePositiveFromTriggerNew() {
		List<Account> accounts = new List<Account>{
			new Account(name = 'test)')
		};
		Test.startTest();
		String results = MetadataTriggerQueryService.getSObjectType(
			accounts,
			null
		);
		Test.stopTest();
		Assert.areEqual('Account', results, 'Expected to see Account returned');
	}

	@isTest
	private static void testGetSObjectTypePositiveFromTriggerOld() {
		List<Account> accounts = new List<Account>{
			new Account(name = 'test)')
		};
		Test.startTest();
		String results = MetadataTriggerQueryService.getSObjectType(
			null,
			accounts
		);
		Test.stopTest();
		Assert.areEqual('Account', results, 'Expected to see Account returned');
	}
}