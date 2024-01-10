/**
 * @description Class wraps DML Calls in FLS / Crud checks.
 */
public with sharing class Safely {
	@TestVisible
	private Boolean allOrNothing = false;
	@TestVisible
	private Boolean throwIfRemovedFields = false;

	/**
	 * @description A custom exception that is thrown from the safely class
	 */
	public class RemovedFieldsException extends Exception {
	}

	/**
	 * @description Triggers the flag to throw an exception if fields are removed
	 *
	 * @return Safely - the current instance of the Safely class
	 */
	public Safely allOrNothing() {
		this.allOrNothing = true;
		return this;
	}

	/**
	 * @description Sets the throwIfRemovedFields flag to true
	 *
	 * @return Safely - the current instance of the Safely class
	 */
	public Safely throwIfRemovedFields() {
		this.throwIfRemovedFields = true;
		return this;
	}

	/// Insert
	/**
	 * @description A method for safely inserting a list of records
	 *
	 * @param records the records to insert
	 *
	 * @return List<Database.saveResult> - the results of the insert
	 */
	public List<Database.SaveResult> doInsert(List<SObject> records) {
		if (records.isEmpty()) {
			return new List<Database.SaveResult>();
		}
		if (CanTheUser.create(records)) {
			return doDML(System.AccessType.CREATABLE, records);
		}
		return new List<Database.SaveResult>();
	}

	/**
	 * @description A method for safely inserting a single record
	 *
	 * @param record SObject - the record to insert
	 *
	 * @return List<Database.SaveResult> - the results of the insert
	 */
	public List<Database.SaveResult> doInsert(SObject record) {
		return doInsert(new List<SObject>{ record });
	}

	/// Update
	/**
	 * @description A method for safely updating a list of records
	 *
	 * @param records List<SObject> - the records to update
	 *
	 * @return List<Database.SaveResult> - the results of the update
	 */
	public List<Database.SaveResult> doUpdate(List<SObject> records) {
		if (records.isEmpty()) {
			return new List<Database.SaveResult>();
		}
		if (CanTheUser.edit(records)) {
			return doDML(System.AccessType.UPDATABLE, records);
		}
		return new List<Database.SaveResult>();
	}

	/**
	 * @description a method for safely updating a single record
	 *
	 * @param record SObject - the record to update
	 *
	 * @return List<Database.SaveResult> - the results of the update
	 */
	public List<Database.SaveResult> doUpdate(SObject record) {
		return doUpdate(new List<SObject>{ record });
	}

	/// Upsert
	/**
	 * @description A method for safely upserting a list of records
	 *
	 * @param records List<SObject> - the records to upsert
	 *
	 * @return List<Database.UpsertResult> - the results of the upsert
	 */
	public List<Database.UpsertResult> doUpsert(List<SObject> records) {
		if (records.isEmpty()) {
			return new List<Database.UpsertResult>();
		}
		if (CanTheUser.edit(records) && CanTheUser.create(records)) {
			SObjectAccessDecision securityDecision = guardAgainstRemovedFields(AccessType.UPSERTABLE, records);

			return Database.upsert(securityDecision.getRecords(), this.allOrNothing);
		}
		return new List<Database.UpsertResult>();
	}

	/**
	 * @description a method for safely upserting a single record
	 *
	 * @param record SObject - the record to upsert
	 *
	 * @return List<Database.UpsertResult> - the results of the upsert
	 */
	public List<Database.UpsertResult> doUpsert(SObject record) {
		return doUpsert(new List<SObject>{ record });
	}

	/// Delete
	/**
	 * @description a method for safely deleting a list of records
	 *
	 * @param records List<SObject> - the records to delete
	 *
	 * @return List<Database.DeleteResult> - the results of the delete
	 */
	public List<Database.DeleteResult> doDelete(List<SObject> records) {
		if (records.isEmpty()) {
			return new List<Database.DeleteResult>();
		}
		if (CanTheUser.destroy(records)) {
			return Database.delete(records, this.allOrNothing);
		}
		return new List<Database.DeleteResult>();
	}

	/**
	 * @description a method for safely deleting a single record
	 *
	 * @param record SOBject - the record to delete
	 *
	 * @return List<Database.DeleteResult> - the results of the delete call
	 */
	public List<Database.DeleteResult> doDelete(SObject record) {
		return doDelete(new List<SObject>{ record });
	}

	/// Query - AKA Read
	/**
	 * @description A method for safely querying records
	 *
	 * @param query String - the query to execute
	 *
	 * @return List<SObject> - the results of the query
	 */
	public List<SObject> doQuery(String query) {
		List<SObject> records = Database.query(query);
		SObjectAccessDecision securityDecision = guardAgainstRemovedFields(AccessType.READABLE, records);
		return securityDecision.getRecords();
	}

	/// Private Methods
	/**
	 * @description A method for safely performing DML
	 *
	 * @param accessType AccessType - the type of access to check for
	 * @param records List<SObject> - the records to perform a Security Access Decision on
	 *
	 * @return List<Database.SaveResult> - the results of the DML call
	 */
	private List<Database.SaveResult> doDML(System.AccessType accessType, List<SObject> records) {
		// guard against an empty but non-null list of records.
		if (records.isEmpty()) {
			return new List<Database.SaveResult>();
		}

		SObjectAccessDecision securityDecision = guardAgainstRemovedFields(accessType, records);

		switch on accessType {
			when CREATABLE {
				return Database.insert(securityDecision.getRecords(), this.allOrNothing);
			}
			when UPDATABLE {
				return Database.update(securityDecision.getRecords(), this.allOrNothing);
			}
			// impossible, but required by compiler
			when else {
				return new List<Database.SaveResult>();
			}
		}
	}

	/**
	 * @description method guards against removed fields by throwing an exception, if throwIfRemovedFields is enabled
	 *
	 * @param accessType AccessType - the type of access to check for
	 * @param records List<SObject> - the records to perform a Security Access Decision on
	 *
	 * @return SObjectAccessDecision - the results of the Security Access Decision
	 */
	private SObjectAccessDecision guardAgainstRemovedFields(System.AccessType accessType, List<SObject> records) {
		SObjectAccessDecision securityDecision = Security.stripInaccessible(
			accessType, // What kind of Access are we checking?
			records, // The records to check
			true // <- true here also enforces CRUD.
		);
		Map<String, Set<String>> removedFields = securityDecision.getRemovedFields();
		if (this.throwIfRemovedFields && !removedFields.isEmpty()) {
			throw new RemovedFieldsException(
				'ThrowIfRemovedFields is enabled and the following fields were removed: ' + removedFields
			);
		}
		return securityDecision;
	}
}
