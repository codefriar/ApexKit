/**
 * @group Trigger Framework
 */
@isTest
private class MetadataTriggerQueryServiceTests {
	@isTest
	static void testGetMetadataTriggers() {
		MetadataTriggerQueryService mts = new MetadataTriggerQueryService(
			'Invalid_Object__c'
		);
		Test.startTest();
		List<Metadata_Driven_Trigger__mdt> triggers = mts.getMetadataTriggers();
		Test.stopTest();

		System.assertEquals(
			triggers.size(),
			0,
			'Expected to find no metadata records'
		);
	}

	@isTest
	static void testGetSObjectTypeNegative() {
		Boolean didCatchProperException = false;
		Test.startTest();
		try {
			MetadataTriggerQueryService.getSObjectType(null, null);
		} catch (MetadataTriggerFramework.MetadataTriggerFrameworkException triggerEx) {
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
		System.assert(
			didCatchProperException,
			'executing this method in a unit test should result in an exception'
		);
	}

	@isTest
	static void testGetSObjectTypePositiveFromTriggerNew() {
		List<Account> accounts = new List<Account>{ new Account(name = 'test)') };
		Test.startTest();
		String results = MetadataTriggerQueryService.getSObjectType(accounts, null);
		Test.stopTest();
		system.assertEquals('Account', results, 'Expected to see Account returned');
	}

	@isTest
	static void testGetSObjectTypePositiveFromTriggerOld() {
		List<Account> accounts = new List<Account>{ new Account(name = 'test)') };
		Test.startTest();
		String results = MetadataTriggerQueryService.getSObjectType(null, accounts);
		Test.stopTest();
		system.assertEquals('Account', results, 'Expected to see Account returned');
	}
}