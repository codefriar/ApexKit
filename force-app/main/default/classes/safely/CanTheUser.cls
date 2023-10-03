/**
 * @description A reusable, intuitive library for determining whether or not the
 * current use can create, read, edit, or delete objects as well as
 * determining if the user has access or update permissions on specific fields.
 * This class name was chosen to facilitate easy-to-understand and read code.
 * Whenever you need to check FLS or CRUD access your code reads like this
 * `if(CanTheUser.read(new account())){}` making the calling and use of this
 * code easy and intuitive.
 * <br>
 * This class' name was chosen to facilitate easy-to-understand and read
 * code. Whenever you need to check FLS or CRUD access your code reads like
 * this
 * `if(CanTheUser.read(new account())){}` making the calling and use of this
 * code easy and intuitive.
 */
public with sharing class CanTheUser {
	//	@TestVisible
	//	private static Map<String, Set<String>> accessibleFieldsByObject = new Map<String, Set<String>>();
	//	@TestVisible
	//	private static Map<String, Set<String>> updatableFieldsByObject = new Map<String, Set<String>>();
	//
	/**
	 * @description An ENUM specifying the various types of CRUD operations
	 */
	public enum CrudType {
		CREATEABLE,
		READABLE,
		EDITABLE,
		DELETABLE,
		UPSERTABLE
	}

	/**
	 * @description An ENUM specifying the various types of FLS operations available.
	 */
	public enum FLSType {
		ACCESSIBLE,
		UPDATABLE
	}

	/**
	 * @description This variable stores, within the same transaction, all previously calculated
	 * FLS results for an object. This prevents multiple calls to this library within the same
	 * transaction from executing more than a single describe call.
	 */
	private static final Map<String, Map<FLSType, Boolean>> MEMOIZED_FLS_RESULTS = new Map<String, Map<FLSType, Boolean>>();

	/**
	 * @description A method to determine if the running user can perform the specified CRUD operation on the specified
	 * object, or object type.
	 *
	 * @param obj the object type to check
	 * @param permission create, read, update or delete
	 *
	 * @return Boolean true if the user can perform the specified CRUD operation on the specified object
	 *
	 * @example System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READABLE));
	 **/
	@TestVisible
	private static Boolean crud(SObject obj, CrudType permission) {
		switch on permission {
			when CREATEABLE {
				return obj.getSObjectType().getDescribe().isCreateable();
			}
			when READABLE {
				return obj.getSObjectType().getDescribe().isAccessible();
			}
			when EDITABLE {
				return obj.getSObjectType().getDescribe().isUpdateable();
			}
			when DELETABLE {
				return obj.getSObjectType().getDescribe().isDeletable();
			}
			when UPSERTABLE {
				return obj.getSObjectType().getDescribe().isCreateable() &&
					obj.getSObjectType().getDescribe().isUpdateable();
			}
			when else {
				// impossible, but required to return something
				return false;
			}
		}
	}

	/**
	 * @description a list accepting version of the crud method. It returns CRUD results for the first object in the
	 * list. Use this method to see if the running user can, for instance, Create an Account, Contact, or Opportunity
	 *
	 * @param objs List<SObject> the list of SObjects to check
	 * @param permission CrudType the CRUD type to check ie: Create
	 *
	 * @return Boolean true if the user can perform the specified CRUD operation on the first object in the list
	 */
	@TestVisible
	private static Boolean crud(List<SObject> objs, CrudType permission) {
		return crud(objs?.get(0), permission);
	}

	/**
	 * @description A method to determine if the running user can perform the specified CRUD operation on the specified
	 * object, or object type.
	 *
	 * @param objectName String the name of the object to check
	 * @param permission CrudType the CRUD type to check ie: Create
	 *
	 * @return Boolean true if the user can perform the specified CRUD operation on the specified object
	 */
	@TestVisible
	private static Boolean crud(String objectName, CrudType permission) {
		Type t = Type.forName(objectName);
		SObject p = (SObject) JSON.deserialize('{}', t);
		return crud(p, permission);
	}

	/**
	 * @description convenience api for determining if the running user can create the specified object
	 *
	 * @param obj Object type to check create permissions on
	 *
	 * @return Boolean true if the user can create the specified object
	 *
	 * @example System.debug(CanTheUser.create(new Account()));
	 **/
	public static Boolean create(SObject obj) {
		return crud(obj, CrudType.CREATEABLE);
	}

	/**
	 * @description convenience api for determining if the running user can create the specified object
	 *
	 * @param objs list of objects. Only the first will be checked. (logically, a list is of uniform type
	 * and, and if the user can create one)
	 *
	 * @return Boolean true if the user can create the first object in the list
	 */
	public static Boolean create(List<SObject> objs) {
		return crud(objs?.get(0), CrudType.CREATEABLE);
	}

	/**
	 * @description convenience api for determining if the running user can create the specified object
	 *
	 * @param objName Object type to check create permissions on
	 *
	 * @return Boolean true if the user can create the specified object
	 *
	 * @example System.debug(CanTheUser.create('Account'));
	 **/
	public static Boolean create(String objName) {
		return crud(objName, CrudType.CREATEABLE);
	}

	/**
	 * @description convenience api for determining if the running user can read / access the specified object
	 *
	 * @param obj object type to check read permissions on
	 *
	 * @return Boolean true if the user can read the specified object
	 *
	 * @example System.debug(CanTheUser.read(new Account()));
	 **/
	public static Boolean read(SObject obj) {
		return crud(obj, CrudType.READABLE);
	}

	/**
	 * @description convenience api for determining if the running user can read / access the specified objects
	 *
	 * @param objs object type to check read permissions on
	 *
	 * @return Boolean true if the user can read the specified object
	 **/
	public static Boolean read(List<SObject> objs) {
		return crud(objs?.get(0), CrudType.READABLE);
	}

	/**
	 * @description convenience api for determining if the running user can read the specified object
	 *
	 * @param objName Object type to check read permissions on
	 *
	 * @return Boolean true if the user can read the specified object
	 *
	 * @example System.debug(CanTheUser.read('Account'));
	 **/
	public static Boolean read(String objName) {
		return crud(objName, CrudType.READABLE);
	}

	/**
	 * @description convenience api for determining if the running user can edit / update the specified object
	 *
	 * @param obj object type to check edit permissions on
	 *
	 * @return Boolean true if the user can edit the specified object
	 *
	 * @example System.debug(CanTheUser.edit(new Account()));
	 **/
	public static Boolean edit(SObject obj) {
		return crud(obj, CrudType.EDITABLE);
	}

	/**
	 * @description convenience api for determining if the running user can edit / update the specified objects
	 *
	 * @param objs object type to check edit permissions on
	 *
	 * @return Boolean true if the user can edit the specified object
	 **/
	public static Boolean edit(List<SObject> objs) {
		return crud(objs?.get(0), CrudType.EDITABLE);
	}

	/**
	 * @description convenience api for determining if the running user can edit the specified object
	 *
	 * @param objName Object type to check edit permissions on
	 *
	 * @return Boolean true if the user can edit the specified object
	 *
	 * @example System.debug(CanTheUser.edit('Account'));
	 **/
	public static Boolean edit(String objName) {
		return crud(objName, CrudType.EDITABLE);
	}

	/**
	 * @description convenience api for determining if the running user can upsert (insert and update) the specified objects
	 *
	 * @param obj object type to check edit permissions on
	 *
	 * @return Boolean true if the user can upsert the specified object
	 *
	 * @example System.debug(CanTheUser.ups(new Account()));
	 **/
	public static Boolean ups(SObject obj) {
		return crud(obj, CrudType.UPSERTABLE);
	}

	/**
	 * @description convenience api for determining if the running user can edit / update the specified objects
	 *
	 * @param objs object type to check upsert permissions on
	 *
	 * @return Boolean true if the user can upsert the specified object
	 **/
	public static Boolean ups(List<SObject> objs) {
		return crud(objs?.get(0), CrudType.UPSERTABLE);
	}

	/**
	 * @description convenience api for determining if the running user can upsert the specified object
	 *
	 * @param objName Object type to check upsert permissions on
	 *
	 * @return Boolean true if the user can upsert the specified objects
	 *
	 * @example System.debug(CanTheUser.ups('Account'));
	 **/
	public static Boolean ups(String objName) {
		return crud(objName, CrudType.UPSERTABLE);
	}

	/**
	 * @description convenience api for determining if the running user can delete/destroy the specified object
	 *
	 * @param obj object type to check destroy permissions on
	 *
	 * @return Boolean true if the user can delete the specified object
	 *
	 * @example System.debug(CanTheUser.destroy(new Account()));
	 **/
	public static Boolean destroy(SObject obj) {
		return crud(obj, CrudType.DELETABLE);
	}

	/**
	 * @description convenience api for determining if the running user can delete the specified object
	 *
	 * @param objs Object type to check delete permissions on
	 *
	 * @return Boolean true if the user can delete the specified object
	 **/
	public static Boolean destroy(List<SObject> objs) {
		return crud(objs?.get(0), CrudType.DELETABLE);
	}

	/**
	 * @description convenience api for determining if the running user can delete the specified object
	 *
	 * @param objName Object type to check create permissions on
	 *
	 * @return Boolean true if the user can delete the specified object
	 *
	 * @example System.debug(CanTheUser.destroy('Account'));
	 **/
	public static Boolean destroy(String objName) {
		return crud(objName, CrudType.DELETABLE);
	}

	/**
	 * @description public static method to determine if a given field on a given object is Accessible (readable)
	 *
	 * @param obj the object in question, in string form
	 * @param field the field in question in SObjectField form
	 *
	 * @return Boolean true if the user can read the specified field on the specified object
	 *
	 * @example System.debug(CanTheUser.flsAccessible('Account', 'Name'));
	 **/
	public static Boolean flsAccessible(String obj, String field) {
		return getFLSForFieldOnObject(obj, field, FLSType.ACCESSIBLE);
	}

	/**
	 * @description bulk form of flsAccessible
	 *
	 * @param obj Obj name on which to check
	 * @param fields Set of Fields to check for accessibility.
	 *
	 * @return `Map<String, Boolean>` where the key is the field name and the value is the accessibility
	 *
	 * @example
	 * String[] fields = new String[]{'Name', 'ShippingStreet'};
	 * System.debug(CanTheUser.bulkFLSAccessible('Account', fields));
	 */
	public static Map<String, Boolean> bulkFLSAccessible(
		String obj,
		Set<String> fields
	) {
		Map<String, Boolean> results = new Map<String, Boolean>();
		for (String field : fields) {
			results.put(field, flsAccessible(obj, field));
		}
		return results;
	}

	/**
	 * @description public static method to determine if a given field on a given object is Updatable.
	 *
	 * @param obj the string version of an object name
	 * @param field the field to check
	 *
	 * @return Boolean true if the user can update the specified field on the specified object
	 *
	 * @example System.debug(CanTheUser.flsUpdatable('Account', 'Name'));
	 **/
	public static Boolean flsUpdatable(String obj, String field) {
		return getFLSForFieldOnObject(obj, field, FLSType.UPDATABLE);
	}

	/**
	 * @description bulk form of flsUpdatable call
	 *
	 * @param obj Name of the object
	 * @param fields Set of Field names to check
	 *
	 * @return `Map<String, Boolean>` where the key is the field name and the value is the updatability
	 *
	 * @example
	 * String[] fields = new String[]{'Name', 'ShippingStreet'};
	 * System.debug(CanTheUser.bulkFLSUpdatable('Account', fields));
	 */
	public static Map<String, Boolean> bulkFLSUpdatable(
		String obj,
		Set<String> fields
	) {
		Map<String, Boolean> results = new Map<String, Boolean>();
		for (String field : fields) {
			results.put(field, flsUpdatable(obj, field));
		}
		return results;
	}

	/**
	 * @description Abstracted method for retrieving or calculating (memoization) of the FLS for a given field on a given object.
	 *
	 * @param obj String version of object name to check
	 * @param field String version of the field to check
	 * @param checkType Enum of Accessible or Updatable.
	 *
	 * @return `Boolean`
	 */
	private static Boolean getFLSForFieldOnObject(
		String obj,
		String field,
		FLSType checkType
	) {
		if (MEMOIZED_FLS_RESULTS.get(field.toLowerCase()) == null) {
			MEMOIZED_FLS_RESULTS.putAll(calculateFLS(obj));
		}
		Boolean results = MEMOIZED_FLS_RESULTS.get(field.toLowerCase())
			?.get(checkType);
		return (results != null && results) ? true : false;
	}

	/**
	 * @description   Calculates the FLS for a given object type
	 * @param objType String name of the object type
	 * @return        `Map<String, Map<FLSType, Boolean>>`
	 */
	private static Map<String, Map<FLSType, Boolean>> calculateFLS(
		String objType
	) {
		Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(
			new List<String>{ objType },
			SObjectDescribeOptions.DEFERRED
		);

		Map<String, Map<FLSType, Boolean>> results = new Map<String, Map<FLSType, Boolean>>();
		for (SObjectField field : descResult[0].fields.getMap().values()) {
			DescribeFieldResult fieldDetails = field.getDescribe();
			String fieldKey = String.valueOf(field).toLowerCase();
			results.put(fieldKey, new Map<FLSType, Boolean>());
			results.get(fieldKey)
				.put(FLSType.ACCESSIBLE, fieldDetails.isAccessible());
			results.get(fieldKey).put(FLSType.UPDATABLE, fieldDetails.isUpdateable());
		}
		return results;
	}
}
