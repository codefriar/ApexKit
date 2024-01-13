/**
 * @description This is a fluent interface for building data sets necessary for Apex based testing.
 */
@IsTest
public class DataBuilder {
	private Boolean forceInsert = false;
	private final UnitOfWork dataTree = new UnitOfWork();

	/**
	 * @description Method to override the default of not inserting this data
	 * @param forceInsert Boolean if true, overrides the default no insert behavior
	 *
	 * @return DataBuiler this.
	 */
	public DataBuilder forceInset(Boolean forceInsert) {
		this.forceInsert = forceInsert;
		return this;
	}

	/**
	 * @description Adds accounts to the constructed dataTree UOW object
	 * @param numberOfAccounts Integer number of accounts
	 * @param usingDefaultsClass String Name of the class to instantiate to provide field values for these objects
	 *
	 * @return this
	 */
	public DataBuilder withAccounts(Integer numberOfAccounts, String usingDefaultsClass) {
		List<Account> newAccounts = (List<Account>) SObjectFactory.createSObjects(
			new Account(),
			numberOfAccounts,
			usingDefaultsClass,
			this.forceInsert
		);
		this.dataTree.accounts.addAll(newAccounts);
		return this;
	}

	/**
	 * @description withAccounts variant allowing for just the number of accounts to create.
	 * @param numberOfAccounts Integer numberOfAccounts to create
	 *
	 * @return this
	 */
	public DataBuilder withAccounts(Integer numberOfAccounts) {
		return withAccounts(numberOfAccounts, null);
	}

	/**
	 * @description A method to add Contacts to the dataTree UOW object
	 * @param numberOfContacts Integer the number of contacts to create
	 * @param usingDefaultsClass String class name to instantiate for default values
	 *
	 * @return this
	 */
	public DataBuilder withContacts(Integer numberOfContacts, String usingDefaultsClass) {
		List<Contact> newContacts = (List<Contact>) SObjectFactory.createSObjects(
			new Contact(),
			numberOfContacts,
			usingDefaultsClass,
			forceInsert
		);
		this.dataTree.contacts.addAll(newContacts);
		return this;
	}

	/**
	 * @description Returns the constructed dataTree UOW to the developer.
	 * @return UnitOfWork object containing the constructed objects.
	 */
	public UnitOfWork build() {
		return this.dataTree;
	}

	/**
	 * @description Inner class representing a 'Unit of Work' in this case, it's just an object to return to the
	 * developer containing all of the constructed data.
	 */
	public class UnitOfWork {
		public List<Account> accounts = new List<Account>();
		public List<Contact> contacts = new List<Contact>();
		public List<User> users = new List<User>();
	}
}
