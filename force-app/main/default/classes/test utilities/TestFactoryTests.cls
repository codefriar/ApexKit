/**
 * Created by kevinpoorman on 1/9/24.
 */

@IsTest
private class TestFactoryTests {
	@IsTest
	static void funcTestCreateSObjectsWith200AccountsPositive() {
		Test.startTest();
		TestFactoryV2.createSObjects(new Account(), 200, null, true);
		Test.stopTest();
		Account[] checkAccounts = [SELECT Id FROM Account];
		Assert.areEqual(200, checkAccounts.size(), 'expected 200 accounts to be created');
	}

	@IsTest
	static void funcTestCreateSObjectWithAccountAndInsertPositive() {
		Test.startTest();
		TestFactoryV2.createSObject(new Account(), 'SomeDefaultsClass', true);
		Test.stopTest();
		Account[] checkAccounts = [SELECT Id FROM Account];
		Assert.areEqual(1, checkAccounts.size(), 'expected 200 accounts to be created');
	}
}
