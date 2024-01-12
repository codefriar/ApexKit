/**
 * @description This is a fluent interface for building data sets necessary for Apex based testing.
 */
@IsTest
public class DataBuilder {
	private Boolean forceInsert = false;
	private final UnitOfWork dataTree = new UnitOfWork();

	public DataBuilder forceInset(Boolean forceInsert) {
		this.forceInsert = forceInsert;
		return this;
	}

	public DataBuilder withAccounts(SObject prototype, Integer numberOfAccounts, String usingDefaultsClass) {
		List<Account> newAccounts = (List<Account>) SObjectFactory.createSObjects(
			prototype,
			numberOfAccounts,
			usingDefaultsClass,
			this.forceInsert
		);
		this.dataTree.accounts.addAll(newAccounts);
		return this;
	}

	public DataBuilder withAccounts(SObject prototype, Integer numberOfAccounts) {
		return withAccounts(prototype, numberOfAccounts, null);
	}

	public DataBuilder withAccounts(Integer numberOfAccounts) {
		return withAccounts(new Account(), numberOfAccounts, null);
	}

	public DataBuilder withContacts(SObject prototype, Integer numberOfContacts, String usingDefaultsClass) {
		List<Contact> newContacts = (List<Contact>) SObjectFactory.createSObjects(
			prototype,
			numberOfContacts,
			usingDefaultsClass,
			forceInsert
		);
		this.dataTree.contacts.addAll(newContacts);
		return this;
	}
	public class UnitOfWork {
		public List<Account> accounts = new List<Account>();
		public List<Contact> contacts = new List<Contact>();
		public List<User> users = new List<User>();
	}
}
