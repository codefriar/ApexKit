/**
 * @description Virtual base repository that every Repository must extend from. This class provides base implementations for common repository CRUD operations.
 *              More specific implementations must be added to the extending classes.
 *              No SObject specific queries are to be added to this base class. SObject specific queries are to be added to the extending classes.
 *              All SObject specific queries are to be done WITH USER_MODE.
 *              All SObject specific queries are to contain a Limit Statement.
 *
 *              There are now overloads provided for all DML operations that allow unsafe DML operations to be performed
 *              but they require certain criteria be met as follows.
 *              1. Create an instance of this class using the overloaded constructor to permit unsafe DML operations.
 *              2. The calling code must provide an @justification ApexDoc annotation explaining why unsafe DML is required.
 *              3. The code must be reviewed & approved.
 *
 *
 */
public inherited sharing virtual class BaseRepo {
	/**
	 * @description SObject type of the repo.
	 */
	@TestVisible
	private final Schema.SObjectType sObjectType;

	/**
	 * @description defaultFields set in the fetchById methods.
	 */
	protected Set<String> defaultSelectFields = new Set<String>{ 'Id' };

	/**
	 * @description Boolean Sets the all Or none unless users explicitly set the allOrNone member to false, logic for the Create update upsert and delete methods.
	 */
	public Boolean allOrNone { get; set; }

	/**
	 * @description Boolean Sets the allowUnsafe switch to true to allow, with required justifications, unsafe DML operations.
	 *     Defaults to false
	 */
	private final Boolean allowUnsafe { get; set; }

	/**
	 * @description Constructor for virtual base repository. Sets the allOrNone boolean for DML to true by default
	 *  and allowUnsafe to false by default, prohibiting DML statements executed in System Mode.
	 * @param sObjectType String determines the sObjectType that the Repository is associated with.
	 */
	protected BaseRepo(Schema.SObjectType sObjectType) {
		this.sObjectType = sObjectType;
		this.allOrNone = true;
		this.allowUnsafe = false;
	}

	/**
	 * @description Constructor for virtual base repository. Sets the allOrNone boolean for DML to true by default
	 *  and allowUnsafe to input parameter.
	 * @param sObjectType String determines the sObjectType that the Repository is associated with.
	 * @param allowUnsafe Boolean that dictates if unsafe DML operations are allowed for this Repo instance.
	 *  By default, it is false so this overloading of ctor is only required when unsafe DML is required (so true)
	 */
	protected BaseRepo(Schema.SObjectType sObjectType, Boolean allowUnsafe) {
		this.sObjectType = sObjectType;
		this.allOrNone = true;
		this.allowUnsafe = allowUnsafe;
	}

	/**
	 * @description    gets a record with the ID passed into the method.
	 * @param recordId Id of the record we want to fetch.
	 * @return         SObject
	 */
	public SObject fetchById(Id recordId) {
		return fetchById(recordId, new Set<String>());
	}

	/**
	 * @description    gets a record with the ID passed into the method.
	 * @param recordId Id of the record we want to fetch.
	 * @param additionalFields Set<String> Additional fields that get added the select statement.
	 * @return         SObject
	 */
	public SObject fetchById(Id recordId, Set<String> additionalFields) {
		additionalFields.addAll(this.defaultSelectFields);
		String selectClause = this.calculateSelectClause(additionalFields);
		String fromObj = this.calculateFromClause();
		String whereClause = ' WHERE Id = :recordId';
		String query =
			selectClause +
			' ' +
			fromObj +
			' ' +
			whereClause +
			' LIMIT 1';
		// this adds a certain amount of risk, returning just the first record. However
		// since the methods work ById, they're necessarily limited to one record.
		// However, let's be explicit. This requires the calling code to handle exceptions
		return fetch(query, new Map<String, Object>{ 'recordId' => recordId })[0];
	}

	/**
	 * @description Safely queries the database enforces UserMode.
	 * @param queryString query string passed to the database method.
	 * @param bindParams  Map<String, Object> key value map that binds the key to the value in the query. e.g 'recordId' => 'abcdefg'
	 * @return            SObject[] Collection of SObject records.
	 */
	protected SObject[] fetch(
		String queryString,
		Map<String, Object> bindParams
	) {
		return Database.queryWithBinds(
			queryString,
			bindParams,
			AccessLevel.USER_MODE
		);
	}
	/**
	 * @description Safely queries the database enforces UserMode.
	 * @param queryString query string passed to the database method.
	 * @return            SObject[] Collection of SObject records.
	 */
	protected SObject[] fetch(String queryString) {
		return this.fetch(queryString, new Map<String, Object>());
	}

	/**
	 * @description Calculates the select clause by joining the strings in the defaultSelectFields List with commas.
	 * @param fields Set<String> fields to be added to the select clause.
	 * @return      String Returns SELECT Field1, Field2.... statement
	 */
	protected String calculateSelectClause(Set<String> fields) {
		return 'SELECT ' + String.join(fields, ', ');
	}

	/**
	 * @description Utility for generating  the FROM Clase
	 * @return String returns the FROM OBJECT clause.
	 */
	protected String calculateFromClause() {
		return 'FROM ' + this.sObjectType;
	}

	/**
	 * @description Bulk insert method that can be overridden. Assures that all inserts are all or none  and run in the context of the running user.
	 * @param records List<SObject> list of SObject records to be inserted.
	 * @return Database.SaveResult[] Save results that contain info on the transaction.
	 */
	public virtual Database.SaveResult[] doCreate(List<SObject> records) {
		return Database.insert(records, this.allOrNone, AccessLevel.USER_MODE);
	}

	/**
	 * @description Singular insert method that can be overridden. Assures that all inserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param record SObject record to be inserted
	 * @return       Database.SaveResult Singular Save Result that contains info on the transaction.
	 */
	public virtual Database.SaveResult doCreate(SObject record) {
		return this.doCreate(new List<SObject>{ record })[0];
	}

	/**
	 * @description Bulk update method that can be overridden. Assures that all updates are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param records List<SObject> records to be updated
	 * @return        Database.SaveResult[] Save results that contain info on the transaction.
	 */
	public virtual Database.SaveResult[] doUpdate(List<SObject> records) {
		return Database.update(records, this.allOrNone, AccessLevel.USER_MODE);
	}

	/**
	 * @description  singular method that can be overridden. Assures that all updates are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param record SObject record to be updated.
	 * @return       Database.SaveResult Singular Save Result that contains info on the transaction.
	 */
	public virtual Database.SaveResult doUpdate(SObject record) {
		return this.doUpdate(new List<SObject>{ record })[0];
	}

	/**
	 * @description   Bulk method that can be overridden. Assures that all upserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param records List<SObject> records to be upserted.
	 * @return        Database.UpsertResult[] Upsert results that contain info on the transaction.
	 */
	public virtual Database.UpsertResult[] doUpsert(List<SObject> records) {
		return Database.upsert(records, this.allOrNone, AccessLevel.USER_MODE);
	}

	/**
	 * @description  Singular method that can be overridden. Assures that all upserts are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param record SObject record to be upserted
	 * @return       Database.UpsertResult Singular upsert result that contains info on the transaction.
	 */
	public virtual Database.UpsertResult doUpsert(SObject record) {
		return this.doUpsert(new List<SObject>{ record })[0];
	}

	/**
	 * @description Bulk method for record deletion that can be overridden. Assures all deletes are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param records List<SObject> records to be deleted
	 * @return Database.DeleteResult[]  Delete results that contain info on the transaction.
	 */
	public virtual Database.DeleteResult[] doDelete(List<SObject> records) {
		return Database.delete(records, this.allOrNone, AccessLevel.USER_MODE);
	}

	/**
	 * @description Singular method for record deletion that can be overridden. Assures all deletes are all or none unless users explicitly set the allOrNone member to false, and run in the context of the running user.
	 * @param record SObject record to be deleted
	 * @return Database.DeleteResult  Singular Delete result that contains info on the transaction.
	 */
	public virtual Database.DeleteResult doDelete(SObject record) {
		return this.doDelete(new List<SObject>{ record })[0];
	}

	/**************************************************************************************************
	 * Overloads for all DML methods to execute in SYSTEM_MODE (unsafe mode). These methods should be
	 *   used judiciously and require valid reason and approval to ensure there are no alternative options.
	 *   Explicitly, they require the invoking code to be annotated in ApexDoc with custom annotation
	 *   justification providing a description as to the need for unsafe DML operation.
	 *
	 **************************************************************************************************/

	/**
	 * @description    gets a record with the ID passed into the method, query executed in SYSTEM_MODE.
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * Calling code must provide an @justification ApexDoc annotation.
	 * @param recordId Id of the record we want to fetch.
	 * @return SObject Matching record for given recordId
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected SObject fetchByIdUnsafe(Id recordId) {
		return fetchByIdUnsafe(recordId, new Set<String>());
	}

	/**
	 * @description    gets a record with the ID passed into the method, query executed in SYSTEM_MODE.
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * Calling code must provide an @justification ApexDoc annotation.
	 * @param recordId Id of the record we want to fetch.
	 * @param additionalFields Set<String> Additional fields that get added the select statement.
	 * @return SObject containing the requested additionalFields and default fields for our SObject.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected SObject fetchByIdUnsafe(Id recordId, Set<String> additionalFields) {
		additionalFields.addAll(this.defaultSelectFields);
		String selectClause = this.calculateSelectClause(additionalFields);
		String fromObj = this.calculateFromClause();
		String whereClause = ' WHERE Id = :recordId';
		String query =
			selectClause +
			' ' +
			fromObj +
			' ' +
			whereClause +
			' LIMIT 1';
		// this adds a certain amount of risk, returning just the first record. However
		// since the methods work ById, they're necessarily limited to one record.
		// However, let's be explicit. This requires the calling code to handle exceptions
		return fetchUnsafe(
			query,
			new Map<String, Object>{ 'recordId' => recordId }
		)[0];
	}

	/**
	 * @description Queries the database explicitly overriding User Mode
	 *
	 * @param queryString query string passed to the database method.
	 * @param bindParams  Map<String, Object> key value map that binds the key to the value in the query. e.g 'recordId' => 'abcdefg'
	 * @return SObject[] Collection of SObject records.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected SObject[] fetchUnsafe(
		String queryString,
		Map<String, Object> bindParams
	) {
		if (allowUnsafe) {
			return Database.queryWithBinds(
				queryString,
				bindParams,
				AccessLevel.SYSTEM_MODE
			);
		}
		throw new UnsafeDmlAttemptedException(
			'Attempt to execute unsafe query without proper justification and setup.'
		);
	}

	/**
	 * @description Queries the database explicitly overriding User Mode.
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param queryString query string passed to the database method.
	 * @return SObject[] Collection of SObject records.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected SObject[] fetchUnsafe(String queryString) {
		return this.fetchUnsafe(queryString, new Map<String, Object>());
	}

	/**
	 * @description Bulk insert method that can be overridden. Assures that all inserts are all or none
	 * and runs in system context, overriding the standard USER_MODE requirement.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param records List<SObject> list of SObject records to be inserted.
	 * @return Database.SaveResult[] Save results that contain info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.SaveResult[] doCreateUnsafe(List<SObject> records) {
		if (this.allowUnsafe) {
			return Database.insert(records, this.allOrNone, AccessLevel.SYSTEM_MODE);
		}
		throw new UnsafeDmlAttemptedException(
			'Attempt to execute unsafe DML insert without proper justification and setup.'
		);
	}

	/**
	 * @description Bulk insert method that can be overridden. Insert is executed in the system context
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param record SObject record to be inserted.
	 * @return Database.SaveResult Save results that contain info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.SaveResult doCreateUnsafe(SObject record) {
		return this.doCreateUnsafe(new List<SObject>{ record })[0];
	}

	/**
	 * @description Bulk update method that can be overridden. Assures that all updates are all or none
	 * unless users explicitly set the allOrNone member to false, and run in system context
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param records List<SObject> records to be updated
	 * @return Database.SaveResult[] Save results that contains info on the transactions.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.SaveResult[] doUpdateUnsafe(List<SObject> records) {
		if (this.allowUnsafe) {
			return Database.update(records, this.allOrNone, AccessLevel.SYSTEM_MODE);
		}
		throw new UnsafeDmlAttemptedException(
			'Attempt to execute unsafe DML update without proper justification and setup.'
		);
	}

	/**
	 * @description Bulk insert method that can be overridden. Update is executed in the system context
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param record SObject record to be updated.
	 * @return Database.SaveResult Save results that contain info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.SaveResult doUpdateUnsafe(SObject record) {
		return this.doUpdateUnsafe(new List<SObject>{ record })[0];
	}

	/**
	 * @description   Bulk method that can be overridden. Assures that all upserts are all or none unless users
	 * explicitly set the allOrNone member to false, and run in system context.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.

	 * @param records List<SObject> records to be upserted.
	 * @return Database.UpsertResult[] Upsert results that contains info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.UpsertResult[] doUpsertUnsafe(List<SObject> records) {
		if (this.allowUnsafe) {
			return Database.upsert(records, this.allOrNone, AccessLevel.SYSTEM_MODE);
		}
		throw new UnsafeDmlAttemptedException(
			'Attempt to execute unsafe DML upsert without proper justification and setup.'
		);
	}

	/**
	 * @description  Singular method that can be overridden. Assures that all upserts are all or none unless users
	 * explicitly set the allOrNone member to false, and run in the system context
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param record SObject record to be upserted
	 * @return Database.UpsertResult Singular upsert result that contains info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.UpsertResult doUpsertUnsafe(SObject record) {
		return this.doUpsertUnsafe(new List<SObject>{ record })[0];
	}

	/**
	 * @description Bulk method for record deletion that can be overridden. Assures all deletes are all or none
	 * unless users explicitly set the allOrNone member to false, and run in system context.
	 *
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param records List<SObject> records to be deleted
	 * @return Database.DeleteResult[]  Delete results that contains info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.DeleteResult[] doDeleteUnsafe(List<SObject> records) {
		if (this.allowUnsafe) {
			return Database.delete(records, this.allOrNone, AccessLevel.SYSTEM_MODE);
		}
		throw new UnsafeDmlAttemptedException(
			'Attempt to execute unsafe DML delete without proper justification and setup.'
		);
	}

	/**
	 * @description Singular method for record deletion that can be overridden. Assures all deletes are all or none
	 * unless users explicitly set the allOrNone member to false, and run in the system context
	 * NOTE: Checking that allow unsafe operations is enabled in overloaded
	 *      method that we invoke.
	 * WARNING: Calling code must provide an @justification ApexDoc annotation.
	 *
	 * @param record SObject record to be deleted
	 * @return Database.DeleteResult  Singular Delete result that contains info on the transaction.
	 * @throws UnsafeDmlAttemptedException if this repository was NOT instantiated with unsafe operations enabled
	 */
	protected Database.DeleteResult doDeleteUnsafe(SObject record) {
		return this.doDeleteUnsafe(new List<SObject>{ record })[0];
	}

	/**
	 * @description Exception to be thrown when an attempt to execute Unsafe DML is made without configuring
	 *  Repo correctly & providing required documentation/config.
	 */
	public class UnsafeDmlAttemptedException extends Exception {
	}
}
