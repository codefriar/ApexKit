/**
 * @description This is a set of tests, unit and profile based for the SObject and User factories.
 * These *require*
 */
@IsTest
@SuppressWarnings('PMD.AvoidDebugStatements, PMD.ApexUnitTestClassShouldHaveRunAs')
private class SObjectFactoryTests {
	/**
	 * @description this is an example custom defaults class to instantiate in the tests
	 */
	public with sharing class SomeDefaultsClass implements SObjectFactory.FieldDefaults {
		/**
		 * @description Interface required method specifying field defaults
		 * @return Map<Schema.SObjectField, Object> map of field names to default vaules
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Account.Name => 'Test Account' };
		}
	}

	@IsTest
	static void profilingTestCreate10IndividualSObjectAccountNoInsertPositive() {
		Test.startTest();
		Long startTime = Datetime.now().getTime();
		for (Integer index = 0; index < 10; index++) {
			SObjectFactory.createSObject(new Account());
		}
		Long stopTime = Datetime.now().getTime();
		Test.stopTest();
		System.debug(LoggingLevel.DEBUG, 'Time to create 10 accounts: ' + (stopTime - startTime) + 'ms');
		Assert.isTrue((stopTime - startTime) < 10000, 'expected time to create 10 accounts to be less than 75ms');
	}

	@IsTest
	static void profilingTestCreate10IndividualSObjectAccountNoInsertWithCustomDefaultsPositive() {
		Test.startTest();
		Long startTime = Datetime.now().getTime();
		for (Integer index = 0; index < 10; index++) {
			SObjectFactory.createSObject(new Account(), 'SomeDefaultsClass');
		}
		Long stopTime = Datetime.now().getTime();
		Test.stopTest();
		System.debug(LoggingLevel.DEBUG, 'Time to create 10 accounts: ' + (stopTime - startTime) + 'ms');
		Assert.isTrue((stopTime - startTime) < 10000, 'expected time to create 10 accounts to be less than 75ms');
	}

	@IsTest
	static void profilingTestCreate10IndividualSObjectAccountWithInsertPositive() {
		Test.startTest();
		Long startTime = Datetime.now().getTime();
		for (Integer index = 0; index < 10; index++) {
			SObjectFactory.createSObject(new Account(), true);
		}
		Long stopTime = Datetime.now().getTime();
		Test.stopTest();
		System.debug(LoggingLevel.DEBUG, 'Time to create & insert 10 accounts: ' + (stopTime - startTime) + 'ms');
		Assert.isTrue((stopTime - startTime) < 10000, 'expected time to create 10 accounts to be less than 1500ms');
	}

	@IsTest
	static void profilingTestCreateListOf200SObjectsNoInsertPositive() {
		Test.startTest();
		Long startTime = Datetime.now().getTime();
		SObjectFactory.createSObjects(new Account(), 200);
		Long stopTime = Datetime.now().getTime();
		Test.stopTest();
		System.debug(LoggingLevel.DEBUG, 'Time to create a list of 200 accounts: ' + (stopTime - startTime) + 'ms');
		Assert.isTrue(
			(stopTime - startTime) < 10000,
			'expected time to create a list of 200 accounts to be less than 150ms'
		);
	}

	@IsTest
	static void profilingTestCreateListOf200SObjectsWithInsertPositive() {
		Test.startTest();
		Long startTime = Datetime.now().getTime();
		SObjectFactory.createSObjects(new Account(), 200, true);
		Long stopTime = Datetime.now().getTime();
		Test.stopTest();
		System.debug(
			LoggingLevel.DEBUG,
			'Time to create and insert a list of 200 accounts: ' + (stopTime - startTime) + 'ms'
		);
		Assert.isTrue(
			(stopTime - startTime) < 10000,
			'expected time to create and insert a list of 200 accounts to be less than 1500ms'
		);
	}

	@IsTest
	static void funcTestCreateSObjectsWith200AccountsNoCustomDefaultsPositive() {
		Test.startTest();
		SObjectFactory.createSObjects(new Account(), 200, null, true);
		Test.stopTest();
		Account[] checkAccounts = [SELECT Id FROM Account];
		Assert.areEqual(200, checkAccounts.size(), 'expected 200 accounts to be created');
	}

	@IsTest
	static void funcTestCreateSObjectsWith200AccountsWithCustomDefaultsPositive() {
		Test.startTest();
		SObjectFactory.createSObjects(new Account(), 200, 'SomeDefaultsClass', true);
		Test.stopTest();
		Account[] checkAccounts = [SELECT Id FROM Account];
		Assert.areEqual(200, checkAccounts.size(), 'expected 200 accounts to be created');
	}

	@IsTest
	static void funcTestCreateSObjectsWith200AccountsWithCustomDefaultsProvesUniqueIdsPositive() {
		Test.startTest();
		List<Account> checkAccounts = (List<Account>) SObjectFactory.createSObjects(
			new Account(),
			200,
			'SomeDefaultsClass',
			false
		);
		Test.stopTest();
		Set<Id> fakeIds = new Set<Id>();
		for (Account accountToCheck : checkAccounts) {
			fakeIds.add(accountToCheck.Id);
		}
		Assert.areEqual(
			200,
			fakeIds.size(),
			'Expected a set of unique ids to be the same size as the requested number of objects to be created'
		);
	}

	@IsTest
	static void funcTestCreateSObjectWithAccountAndInsertPositive() {
		Test.startTest();
		SObjectFactory.createSObject(new Account(), 'SomeDefaultsClass', true);
		Test.stopTest();
		Account[] checkAccounts = [SELECT Id FROM Account];
		Assert.areEqual(1, checkAccounts.size(), 'expected 200 accounts to be created');
	}
}
