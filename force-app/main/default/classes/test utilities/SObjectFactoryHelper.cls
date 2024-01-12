/**
 * @description This class contains helper methods used by the SObjectFactory.
 * While a bit of an anti-pattern, this class' contents allow SObjectFactory to be more-focused.
 * @see SObjectFactory
 */
@IsTest
public class SObjectFactoryHelper {
	/// Internal Properties
	/** @description Memoizes the result of a describe call for same-transaction caching */
	private static final Map<Schema.SObjectType, Boolean> MEMOIZED_AUTO_NUMBER_NAME_FIELD = new Map<Schema.SObjectType, Boolean>{};

	/**
	 * @description While the vast majority of Salesforce objects have a Name field, some objects do not.
	 * This map allows you to override the default name field for a given object type and covers the two
	 * standard objects that do not have a name field.
	 */
	private static final Map<Schema.SObjectType, Schema.SObjectField> NAME_FIELD_OVERRIDE_MAP = new Map<Schema.SObjectType, Schema.SObjectField>{
		Contact.SObjectType => Contact.LastName, // Contact uses LastName as the name field
		Case.SObjectType => Case.CaseNumber // This is the autonumber field
	};

	/**
	 * @description responsible for enforcing a cloned SObject's values honor uniqueness rules for name and
	 * autonumber fields
	 * @param clonedSObject SObject a cloned version of the prototyped SObject
	 * @param fakeId Boolean Populates a fakeId on the object unless it's to be inserted
	 * @param iterationCounter Integer Counter for ensuring name uniqueness
	 * @return SObject a mutated version of the cloned object with unique name and autonumber fields
	 */
	public static SObject mutateCloneToRespectNameAndAutonumberRules(
		SObject clonedSObject,
		Boolean fakeId,
		Integer iterationCounter
	) {
		String nameField = calculateNameField(clonedSObject);
		Boolean isNameFieldAutoNumber = nameFieldIsAutoNumber(clonedSObject, nameField);

		if (!isNameFieldAutoNumber) {
			clonedSObject.put(nameField, (String) clonedSObject.get(nameField) + ' ' + iterationCounter);
		}
		if (fakeId) {
			clonedSObject.Id = IdFactory.get(clonedSObject);
		}
		return clonedSObject;
	}

	/**
	 * @description responsible for inserting a list of SObjects into the database.
	 * @param objectsToInsert List<SObject> a list of SObjects to be inserted into the database
	 * @param forceInsert Boolean a flag to force insert the objects into the database
	 */
	public static void insertIfForced(List<SObject> objectsToInsert, Boolean forceInsert) {
		if (forceInsert) {
			Database.insert(objectsToInsert, false, AccessLevel.SYSTEM_MODE);
		}
	}

	/**
	 * @description responsible for applying org-wide field defaults to a SObject.
	 * @param prototype SObject a SObject to be mutated
	 * @return SObject a mutated version of the prototype object with field defaults applied
	 */
	public static SObject applyOrgWideObjectDefaults(SObject prototype) {
		String objectName = String.valueOf(prototype.getSObjectType());
		String defaultsClassName = 'SObjectFactoryDefaults.' + objectName.replaceAll('__(c|C)$', '') + 'Defaults';
		return applyCustomDefaults(prototype, defaultsClassName);
	}

	/**
	 * @description responsible for applying custom field defaults to a SObject.
	 * @param prototype SObject a SObject to be mutated
	 * @param usingDefaultsClassName String the name of the class to be used for field defaults
	 * @return SObject a mutated version of the prototype object with field defaults applied
	 */
	public static SObject applyCustomDefaults(SObject prototype, String usingDefaultsClassName) {
		SObjectFactory.FieldDefaults defaults = getFieldDefaultsInstanceFromName(usingDefaultsClassName);
		return applyFieldDefaults(prototype, defaults?.getFieldDefaults());
	}

	private static String calculateNameField(SObject prototype) {
		String nameField = String.valueOf(NAME_FIELD_OVERRIDE_MAP.get(prototype.getSObjectType()));
		return (nameField == null) ? 'Name' : nameField;
	}

	private static Boolean nameFieldIsAutoNumber(SObject prototype, String nameField) {
		if (!MEMOIZED_AUTO_NUMBER_NAME_FIELD.containsKey(prototype.getSObjectType())) {
			MEMOIZED_AUTO_NUMBER_NAME_FIELD.put(
				prototype.getSObjectType(),
				prototype.getSObjectType().getDescribe().fields.getMap().get(nameField).getDescribe().isAutoNumber()
			);
		}
		return MEMOIZED_AUTO_NUMBER_NAME_FIELD.get(prototype.getSObjectType());
	}

	private static SObjectFactory.FieldDefaults getFieldDefaultsInstanceFromName(String nameOfClassToInstantiate) {
		Type defaultsClassToUse = Type.forName(nameOfClassToInstantiate);
		return (SObjectFactory.FieldDefaults) defaultsClassToUse?.newInstance();
	}

	private static SObject applyFieldDefaults(SObject prototype, Map<Schema.SObjectField, Object> defaults) {
		if (defaults == null) {
			return prototype;
		}
		Map<String, Object> prototypesPopulatedFields = prototype.getPopulatedFieldsAsMap();
		for (Schema.SObjectField field : defaults.keySet()) {
			if (prototypesPopulatedFields.containsKey(String.valueOf(field))) {
				continue;
			}
			prototype.put(field, defaults.get(field));
		}
		return prototype;
	}
}
