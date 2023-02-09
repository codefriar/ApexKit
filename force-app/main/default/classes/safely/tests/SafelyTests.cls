@isTest
private class SafelyTests {
	@IsTest
	private static void testConstructorChains() {
		Test.startTest();
		Safely instanceOne = new Safely().allOrNothing();
		Safely instanceTwo = new Safely().throwIfRemovedFields();
		Test.stopTest();

		Assert.areEqual(
			true,
			instanceOne.allOrNothing,
			'Expected Fluent constructor to have set this to true'
		);
		Assert.areEqual(
			false,
			instanceOne.throwIfRemovedFields,
			'Expected this to remain false'
		);
		Assert.areEqual(
			true,
			instanceTwo.throwIfRemovedFields,
			'Expected Fluent constructor to have set this to true'
		);
		Assert.areEqual(
			false,
			instanceTwo.allOrNothing,
			'Expected this to remain false'
		);
	}

	@IsTest
	private static void testDoInsertMethodsNoThrowPositive() {
		Account account = (Account) new Account(Name = 'TestAccount');
		Test.startTest();
		List<Database.SaveResult> results = new Safely().doInsert(account);
		Test.stopTest();
		Assert.areEqual(
			1,
			results.size(),
			'Expected one save result in the list'
		);
		Assert.isTrue(results.get(0).success, 'This dml should succeed');
	}

	@IsTest
	private static void testDoInsertNegative() {
		User minAccessUser = TestFactory.createMinAccessUser(true);

		System.runAs(minAccessUser) {
			Assert.isTrue(!CanTheUser.create(new Account()));
			Test.startTest();
			Account account = (Account) new Account(Name = 'TestAccount');
			List<Database.SaveResult> results = new Safely().doInsert(account);
			Test.stopTest();
			Assert.areEqual(
				0,
				results.size(),
				'Expected zero delete result in the list'
			);
		}
	}

	@IsTest
	private static void testMarketingProfileGeneratesInsertExceptionPositive() {
		User marketingUser = TestFactory.createMarketingUser(true);
		Boolean didCatchTheRightException = false;
		Account account = (Account) new Account(
			Name = 'TestAccount',
			TradeStyle = 'invalid'
		);
		Test.startTest();
		System.runAs(marketingUser) {
			try {
				new Safely().throwIfRemovedFields().doInsert(account);
			} catch (Safely.RemovedFieldsException rfe) {
				if (
					rfe.getMessage()
						.containsIgnoreCase('and the following fields')
				) {
					didCatchTheRightException = true;
				}
			}
		}
		Test.stopTest();
		Assert.isTrue(
			didCatchTheRightException,
			'Expected to have caught a removedFieldsException'
		);
	}

	@IsTest
	private static void testDoUpdateMethodsNoThrowPositive() {
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		account.Name = 'TestAccount2';
		Test.startTest();
		List<Database.SaveResult> results = new Safely().doUpdate(account);
		Test.stopTest();
		Assert.areEqual(
			1,
			results.size(),
			'Expected one save result in the list'
		);
		Assert.isTrue(results.get(0).success, 'This dml should succeed');
	}

	@IsTest
	private static void testDoUpdateNegative() {
		User minAccessUser = TestFactory.createMinAccessUser(true);

		PermissionSet ps = new PermissionSet(
			Label = 'testPermSet',
			Name = 'testPermSet'
		);
		insert ps;
		ObjectPermissions op = new ObjectPermissions(
			ParentId = ps.Id,
			SobjectType = 'Account'
		);
		op.PermissionsRead = true;
		op.PermissionsCreate = true;
		op.PermissionsEdit = false;
		insert op;

		insert new PermissionSetAssignment(
			PermissionSetId = ps.Id,
			AssigneeId = minAccessUser.Id
		);
		System.runAs(minAccessUser) {
			Account account = (Account) new Account(name = 'TestAccount');
			Assert.isTrue(CanTheUser.create(account));
			insert account;

			Test.startTest();
			account.Name = 'UpdatedAccount';
			Assert.isTrue(!(CanTheUser.edit(account)));
			List<Database.SaveResult> results = new Safely().doUpdate(account);
			Test.stopTest();

			Assert.areEqual(
				0,
				results.size(),
				'Expected zero update results in the list'
			);
		}
	}

	@IsTest
	private static void testMarketingProfileDeleteNegative() {
		User marketingUser = TestFactory.createMarketingUser(true);
		Case c = (Case) new Case(Subject = 'TestCase');
		insert c;

		System.runAs(marketingUser) {
			Test.startTest();

			List<Database.DeleteResult> results = new Safely().doDelete(c);
			Test.stopTest();
			Assert.areEqual(
				0,
				results.size(),
				'Expected zero delete result in the list'
			);
		}
	}

	@IsTest
	private static void testMarketingProfileGeneratesUpdateExceptionPositive() {
		User marketingUser = TestFactory.createMarketingUser(true);
		Boolean didCatchTheRightException = false;
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		account.TradeStyle = 'off limits field';
		Test.startTest();
		System.runAs(marketingUser) {
			try {
				new Safely().throwIfRemovedFields().doUpdate(account);
			} catch (Safely.RemovedFieldsException rfe) {
				if (
					rfe.getMessage()
						.containsIgnoreCase('and the following fields')
				) {
					didCatchTheRightException = true;
				}
			}
		}
		Test.stopTest();
		Assert.isTrue(
			didCatchTheRightException,
			'Expected to have caught a removedFieldsException'
		);
	}

	@IsTest
	private static void testDoUpsertMethodsNoThrowPositive() {
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		account.Name = 'TestAccount2';
		Account account2 = (Account) new Account(Name = 'TestAccount');
		List<Account> accounts = new List<Account>{ account, account2 };
		Test.startTest();
		List<Database.upsertResult> insertResults = new Safely()
			.doUpsert(account);
		List<Database.UpsertResult> mixedResults = new Safely()
			.doUpsert(accounts);
		Test.stopTest();
		Assert.areEqual(
			1,
			insertResults.size(),
			'Expected one save result in the list'
		);
		Assert.areEqual(2, mixedResults.size(), 'expected two results');
		Assert.isTrue(insertResults.get(0).success, 'This dml should succeed');
		Integer updated = 0;
		Integer inserted = 0;
		for (Database.upsertResult result : mixedResults) {
			Assert.isTrue(result.success, 'This dml should succeed');
			if (result.created) {
				inserted++;
			} else {
				updated++;
			}
		}
		Assert.areEqual(1, updated, 'Expected one to have been updated');
		Assert.areEqual(1, inserted, 'Expected one to have been inserted');
	}

	@IsTest
	private static void testDoUpsertMethodsNegative() {
		User minAccessUser = TestFactory.createMinAccessUser(true);

		PermissionSet ps = new PermissionSet(
			Label = 'testPermSet',
			Name = 'testPermSet'
		);
		insert ps;
		ObjectPermissions op = new ObjectPermissions(
			ParentId = ps.Id,
			SobjectType = 'Account'
		);
		op.PermissionsRead = true;
		op.PermissionsCreate = true;
		op.PermissionsEdit = false;
		insert op;

		insert new PermissionSetAssignment(
			PermissionSetId = ps.Id,
			AssigneeId = minAccessUser.Id
		);

		System.runAs(minAccessUser) {
			Account account = (Account) new Account(Name = 'TestAccount01');
			Account account2 = (Account) new Account(Name = 'TestAccount02');

			Test.startTest();
			List<Database.SaveResult> insertResults = new Safely()
				.doInsert(account);
			account.Name = 'TestAccount2';
			List<Account> accounts = new List<Account>{ account, account2 };
			List<Database.UpsertResult> mixedResults = new Safely()
				.doUpsert(accounts);
			Test.stopTest();
			Assert.areEqual(
				1,
				insertResults.size(),
				'Expected one save result in the list'
			);
			Assert.isTrue(
				insertResults.get(0).success,
				'This dml should succeed'
			);
			Assert.isTrue(mixedResults.isEmpty(), 'expected no updates');
		}
	}

	@IsTest
	private static void testMarketingProfileGeneratesUpsertExceptionPositive() {
		User marketingUser = TestFactory.createMarketingUser(true);
		Boolean didCatchTheRightException = false;
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		account.TradeStyle = 'off limits field';
		Test.startTest();
		System.runAs(marketingUser) {
			try {
				new Safely().throwIfRemovedFields().doUpsert(account);
			} catch (Safely.RemovedFieldsException rfe) {
				if (
					rfe.getMessage()
						.containsIgnoreCase('and the following fields')
				) {
					didCatchTheRightException = true;
				}
			}
		}
		Test.stopTest();
		Assert.isTrue(
			didCatchTheRightException,
			'Expected to have caught a removedFieldsException'
		);
	}

	@IsTest
	private static void testDeleteWithRegularProfilePositive() {
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		Test.startTest();
		List<Database.deleteResult> results = new Safely()
			.throwIfRemovedFields()
			.doDelete(account);
		Test.stopTest();
		Assert.isTrue(results.get(0).success, 'expected this dml to succeed');
	}

	@IsTest
	private static void testDeleteWithRegularProfileNegative() {
		User minAccessUser = TestFactory.createMinAccessUser(true);
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		Test.startTest();
		List<Database.deleteResult> results;
		System.runAs(minAccessUser) {
			results = new Safely().throwIfRemovedFields().doDelete(account);
		}

		Test.stopTest();
		Assert.isTrue(results.isEmpty(), 'expected this dml to fail');
	}

	@IsTest
	private static void testDoQueryPositive() {
		Account account = (Account) new Account(Name = 'TestAccount');
		insert account;
		Test.startTest();
		List<Account> accounts = (List<Account>) new Safely()
			.throwIfRemovedFields()
			.doQuery('SELECT ID, Name FROM Account');
		Test.stopTest();
		Assert.areEqual(1, Accounts.size(), 'expected to find one record');
	}

	@IsTest
	private static void testDoQueryThrowsRemovedFieldsException() {
		User minAccessUser = TestFactory.createMinAccessUser(true);

		PermissionSet ps = new PermissionSet(
			Label = 'testPermSet',
			Name = 'testPermSet'
		);
		insert ps;
		ObjectPermissions op = new ObjectPermissions(
			ParentId = ps.Id,
			SobjectType = 'Account'
		);
		op.PermissionsRead = true;
		op.PermissionsViewAllRecords = true;
		insert op;
		insert new PermissionSetAssignment(
			PermissionSetId = ps.Id,
			AssigneeId = minAccessUser.Id
		);

		System.runAs(new User(Id = UserInfo.getUserId())) {
			Account account = (Account) new Account(Name = 'TestAccount');
			insert account;
		}
		System.runAs(minAccessUser) {
			Boolean didCatchTheRightException = false;
			Test.startTest();
			Safely saf = new Safely();
			try {
				List<Account> accounts = (List<Account>) saf
					.throwIfRemovedFields()
					.doQuery('SELECT ID, Name, TradeStyle FROM Account');
			} catch (Safely.RemovedFieldsException rfe) {
				if (rfe.getMessage().containsIgnoreCase('TradeStyle')) {
					didCatchTheRightException = true;
				}
			}
			Test.stopTest();
			Assert.isTrue(saf.throwIfRemovedFields);
			Assert.isTrue(
				didCatchTheRightException,
				'Expected to have caught a removedFieldsException'
			);
		}
	}

	@IsTest
	private static void emptyCollections() {
		Test.startTest();
		List<Database.SaveResult> insertResults = new Safely()
			.doInsert(new List<Account>());
		List<Database.SaveResult> updateResults = new Safely()
			.doUpdate(new List<Account>());
		List<Database.UpsertResult> upsertResults = new Safely()
			.doUpsert(new List<Account>());
		List<Database.DeleteResult> deleteResults = new Safely()
			.doDelete(new List<Account>());
		Test.stopTest();

		Assert.isTrue(insertResults.isEmpty());
		Assert.isTrue(updateResults.isEmpty());
		Assert.isTrue(upsertResults.isEmpty());
		Assert.isTrue(deleteResults.isEmpty());
	}
}