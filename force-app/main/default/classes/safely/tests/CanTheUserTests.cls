@IsTest
private class CanTheUserTests {
	// These tests rely on the assumption that standard FLS/CRUD have not been modified
	// by the user, and use the Account Object for verification of the Can Logic.

	private static List<Account> generateAccounts() {
		List<Account> accounts = new List<Account>();
		for (Integer i = 0; i < 2; i++) {
			accounts.add(new Account());
		}
		return accounts;
	}

	@IsTest
	private static void canCrudAccountCreatePositive() {
		Assert.isTrue(
			CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.CREATEABLE),
			'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
		);
		Assert.isTrue(
			CanTheUser.crud(new Account(), CanTheUser.CrudType.CREATEABLE),
			'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
		);
	}

	@IsTest
	private static void canCrudCreateAccountPositive() {
		Assert.isTrue(
			CanTheUser.create(generateAccounts()),
			'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
		);
		Assert.isTrue(
			CanTheUser.create(new Account()),
			'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
		);
		Assert.isTrue(
			CanTheUser.create('Account'),
			'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
		);
	}

	@IsTest
	private static void canCrudAccountReadPositive() {
		Assert.isTrue(
			CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.READABLE),
			'Expected to be able to read accounts'
		);
		Assert.isTrue(
			CanTheUser.crud(new Account(), CanTheUser.CrudType.READABLE),
			'Expected to be able to read accounts'
		);
	}

	@IsTest
	private static void canCrudReadAccountPositive() {
		Assert.isTrue(
			CanTheUser.read(generateAccounts()),
			'Expected to be able to read accounts'
		);
		Assert.isTrue(
			CanTheUser.read(new Account()),
			'Expected to be able to read accounts'
		);
		Assert.isTrue(
			CanTheUser.read('Account'),
			'Expected to be able to read accounts'
		);
	}

	@IsTest
	private static void canCrudAccountUpdatePositive() {
		Assert.isTrue(
			CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.EDITABLE),
			'Expected to be able to update accounts'
		);
		Assert.isTrue(
			CanTheUser.crud(new Account(), CanTheUser.CrudType.EDITABLE),
			'Expected to be able to update accounts'
		);
	}

	@IsTest
	private static void canCrudEditAccountPositive() {
		Assert.isTrue(
			CanTheUser.edit(generateAccounts()),
			'Expected to be able to update accounts'
		);
		Assert.isTrue(
			CanTheUser.edit(new Account()),
			'Expected to be able to update accounts'
		);
		Assert.isTrue(
			CanTheUser.edit('Account'),
			'Expected to be able to update accounts'
		);
	}

	@IsTest
	private static void canCrudUpsertAccountPositive() {
		Assert.isTrue(
			CanTheUser.ups(generateAccounts()),
			'Expected to be able to upsert accounts'
		);
		Assert.isTrue(
			CanTheUser.ups(new Account()),
			'Expected to be able to upsert accounts'
		);
		Assert.isTrue(
			CanTheUser.ups('Account'),
			'Expected to be able to upsert accounts'
		);
	}

	@IsTest
	private static void canCrudAccountDeletePositive() {
		Assert.isTrue(
			CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.DELETABLE),
			'Expected to be able to delete accounts'
		);
		Assert.isTrue(
			CanTheUser.crud(new Account(), CanTheUser.CrudType.DELETABLE),
			'Expected to be able to delete accounts'
		);
		Assert.isTrue(
			CanTheUser.crud('Account', CanTheUser.CrudType.DELETABLE),
			'Expected to be able to delete accounts'
		);
	}

	@IsTest
	private static void canCrudDestroyAccountPositive() {
		Assert.isTrue(
			CanTheUser.destroy(generateAccounts()),
			'Expected to be able to delete accounts'
		);
		Assert.isTrue(
			CanTheUser.destroy(new Account()),
			'Expected to be able to delete accounts'
		);
		Assert.isTrue(
			CanTheUser.destroy('Account'),
			'Expected to be able to delete accounts'
		);
	}

	@IsTest
	private static void getFLSofAccountNamePositive() {
		Assert.isTrue(
			CanTheUser.flsAccessible('Account', 'Name'),
			'Expected the name field to be accesible on Account'
		);
	}

	@IsTest
	private static void getFLSofAccountIDNegative() {
		Assert.isTrue(
			CanTheUser.flsUpdatable('Account', 'id') == false,
			'Expected that the ID of an object cannot be updated.'
		);
	}

	@IsTest
	private static void getBulkFLSAccessibleWithAccountPositive() {
		Set<String> fields = new Set<String>{ 'name', 'id' };
		Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
			'Account',
			fields
		);
		for (String field : bulkCheck.keySet()) {
			Assert.isTrue(
				bulkCheck.get(field),
				'Expected the field ' + field + ' to be accesible on Account'
			);
		}
	}

	@IsTest
	private static void getBulkFLSAccessibleWithAccountPositiveWithNegativeResults() {
		Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
		Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
			'Account',
			fields
		);

		Assert.isTrue(
			bulkCheck.get('name'),
			'Expected the name ' + 'field to be accesible on Account'
		);

		Assert.isTrue(
			!bulkCheck.get('nonExistingField__c'),
			'Expected the nonExistingField__c ' +
			'field not to be accesible on Account'
		);
	}

	@IsTest
	private static void getBulkFLSUpdatableWithAccountPositive() {
		Set<String> fields = new Set<String>{ 'name', 'ShippingStreet' };
		Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
			'Account',
			fields
		);
		for (String field : bulkCheck.keySet()) {
			Assert.isTrue(
				bulkCheck.get(field),
				'Expected the field ' + field + ' to be accesible on Account'
			);
		}
	}

	@IsTest
	private static void getBulkFLSUpdatableWithAccountPositiveWithNegativeResults() {
		Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
		Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
			'Account',
			fields
		);

		Assert.isTrue(
			bulkCheck.get('name'),
			'Expected the name ' + 'field to be accesible on Account'
		);

		Assert.isTrue(
			!bulkCheck.get('nonExistingField__c'),
			'Expected the nonExistingField__c ' +
			'field not to be accesible on Account'
		);
	}
}