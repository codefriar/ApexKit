@isTest
private class PolyfillsTests {
	@isTest
	private static void testGetSObjectTypeFromListPositiveNoType() {
		Test.startTest();
		String results = Polyfills.getSObjectTypeFromList(new List<SObject>());
		Test.stopTest();
		Assert.isTrue(
			results.containsIgnoreCase('sObject'),
			'expected to get sobject back'
		);
	}

	@isTest
	private static void testGenerateUUID() {
		Test.startTest();
		String uuid = Polyfills.generateUUID();
		Test.stopTest();
		system.debug(uuid);
		Assert.isTrue(uuid != null, 'expected to get a uuid back');
		Assert.areEqual(
			5,
			uuid.split('-').size(),
			'expected to get 5 parts back'
		);
	}

	@isTest
	private static void testPluckFieldFromList() {
		List<Account> accounts = (List<Account>) TestFactory.createSobjectList(
			new Account(),
			200
		);
		Test.startTest();
		List<Object> results = Polyfills.pluckFieldFromList('Name', accounts);
		Test.stopTest();
		Assert.areEqual(200, results.size());
	}

	@isTest
	private static void testGenerateStacktracePositive() {
		Test.startTest();
		String results = Polyfills.generateStacktrace();
		Test.stopTest();
		Assert.isTrue(
			results.containsIgnoreCase('PolyfillsTests'),
			'expected to get stacktrace back'
		);
	}

	@isTest
	private static void testTypeObjectFromClassNamePositive() {
		Test.startTest();
		Type results = Polyfills.typeObjectFromClassName('Account');
		Test.stopTest();
		Type expected = Account.class;
		Assert.areEqual(results, expected, 'expected to get account back');
	}

	@isTest
	private static void testTypeObjFromInstance() {
		Test.startTest();
		Type results = Polyfills.typeObjFromInstance(new Account());
		Test.stopTest();
		Type expected = Account.class;
		Assert.areEqual(results, expected, 'expected to get account back');
	}

	@isTest
	private static void testClassNameFromInstance() {
		Test.startTest();
		String results = Polyfills.classNameFromInstance(new Account());
		Test.stopTest();
		Assert.isTrue(
			results.containsIgnoreCase('Account'),
			'expected to get account back'
		);
	}

	@isTest
	private static void testDemonstrateIdMapFromCollectionByKeyPositiveWithList() {
		List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
			new Account(),
			5,
			true
		);
		List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
			new Contact(),
			5,
			true
		);

		Test.startTest();
		Map<Id, Account> checkAccountMap = (Map<Id, Account>) Polyfills.idMapFromCollectionByKey(
			'id',
			accounts
		);
		Map<Id, Contact> checkContactMap = (Map<Id, Contact>) Polyfills.idMapFromCollectionByKey(
			'id',
			contacts
		);
		Test.stopTest();

		Assert.areEqual(
			checkAccountMap.keySet().size(),
			5,
			'Expected to get 5 accounts back'
		);
		Assert.areEqual(
			checkContactMap.keySet().size(),
			5,
			'Expected to get 5 contacts back'
		);

		for (id accountId : checkAccountMap.keySet()) {
			Assert.areEqual(
				checkAccountMap.get(accountId).getSObjectType(),
				Account.getSObjectType(),
				'We expected the map to have accounts'
			);
		}

		for (id contactId : checkContactMap.keySet()) {
			Assert.areEqual(
				checkContactMap.get(contactId).getSObjectType(),
				Contact.getSObjectType(),
				'We expected the map to have Contact'
			);
		}
	}

	@isTest
	private static void testDemonstrateStringMapFromCollectionByKeyPositiveWithList() {
		List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
			new Account(),
			5,
			true
		);
		for (Account acct : accounts) {
			acct.name = acct.id;
		}
		update accounts;
		Test.startTest();
		Map<String, Account> checkAccountMap = (Map<String, Account>) Polyfills.stringMapFromCollectionByKey(
			'name',
			accounts
		);

		Test.stopTest();

		Assert.areEqual(
			checkAccountMap.keySet().size(),
			5,
			'Expected to get 5 accounts back'
		);

		for (id accountId : checkAccountMap.keySet()) {
			Assert.areEqual(
				checkAccountMap.get(accountId).getSObjectType(),
				Account.getSObjectType(),
				'We expected the map to have accounts'
			);
		}
	}

	@isTest
	private static void testMapFromCollectionWithListOfValuesPostive() {
		List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
			new Account(),
			5,
			true
		);

		List<Contact> contactList = new List<Contact>();
		for (Account acct : accounts) {
			contactList.addAll(
				(List<Contact>) TestFactory.createSObjectList(
					new Contact(accountId = acct.id),
					5,
					false
				)
			);
		}
		insert contactList;

		Test.startTest();
		Map<Id, List<Contact>> checkResults = (Map<Id, List<Contact>>) Polyfills.mapFromCollectionWithCollectionValues(
			'AccountId',
			contactList
		);
		Test.stopTest();

		Assert.areEqual(
			5,
			checkResults.keyset().size(),
			'Expected to find 5 accountIds'
		);

		for (Id accountId : checkResults.keySet()) {
			Assert.areEqual(
				accountId.getSobjectType(),
				Account.getSObjectType(),
				'Expected keys to be accounts'
			);
			Assert.areEqual(
				5,
				checkResults.get(accountId).size(),
				'Expected to find 5 entries in the list '
			);
			for (Contact contact : checkResults.get(accountId)) {
				Assert.areEqual(
					contact.getSObjectType(),
					Contact.getSObjectType(),
					'Expected to find contacts'
				);
			}
		}
	}

	@isTest
	private static void testSetContainsAnyItemFromListPositive() {
		Set<String> testSet = new Set<String>();
		testSet.add('0011h00000xR1GfAAK');
		testSet.add('0011h00000xR1GfAAL');
		testSet.add('0011h00000xR1GfAAM');
		testSet.add('0011h00000xR1GfAAN');
		testSet.add('0011h00000xR1GfAAO');

		List<String> testList = new List<String>();
		testList.add('0011h00000xR1GfAAK');

		Test.startTest();
		Boolean checkResults = Polyfills.setContainsAnyItemFromList(
			testSet,
			testList
		);
		Test.stopTest();

		Assert.areEqual(
			true,
			checkResults,
			'Expected to find at least one item in the list in the set'
		);
	}

	@isTest
	private static void testSetDoesNOTContainsAnyItemFromListPositive() {
		Set<String> testSet = new Set<String>();
		testSet.add('0011h00000xR1GfAAK');
		testSet.add('0011h00000xR1GfAAL');
		testSet.add('0011h00000xR1GfAAM');
		testSet.add('0011h00000xR1GfAAN');
		testSet.add('0011h00000xR1GfAAO');

		List<String> testList = new List<String>();
		testList.add('0011h00000xR1GfAAZ');

		Test.startTest();
		Boolean checkResults = Polyfills.setContainsAnyItemFromList(
			testSet,
			testList
		);
		Test.stopTest();

		Assert.areEqual(
			false,
			checkResults,
			'Expected to find foo is not in the set'
		);
	}

	@isTest
	private static void givenAStringAndABlob_CanConcatenateIntoOneBlob() {
		String oneCharacter = '1';
		Blob oneCharacterInAFile = Blob.valueOf(oneCharacter);

		Blob twoCharactersInAFile = Polyfills.concatenateBlobAndString(
			oneCharacterInAFile,
			oneCharacter
		);

		Assert.areEqual(
			2,
			twoCharactersInAFile.size(),
			'Blob did not concatenate with String'
		);
	}
}