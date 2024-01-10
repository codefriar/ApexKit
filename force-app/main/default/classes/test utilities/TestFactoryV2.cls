@IsTest
@SuppressWarnings('PMD.CognitiveComplexity')
public with sharing class TestFactoryV2 {
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

	public static SObject createSObject(SObject prototype) {
		return createSObject(prototype, null, false);
	}

	public static SObject createSObject(SObject prototype, String usingDefaultsClassName) {
		return createSObject(prototype, usingDefaultsClassName, false);
	}

	public static SObject createSObject(SObject prototype, String usingDefaultsClassName, Boolean forceInsert) {
		// First the specified defaults class
		prototype = applyCustomDefaults(prototype, usingDefaultsClassName);
		// then the 'org-wide' defaults
		prototype = applyOrgWideObjectDefaults(prototype);
		if (forceInsert) {
			Database.insert(prototype, AccessLevel.SYSTEM_MODE);
		} else {
			prototype.Id = IdFactory.get(prototype);
		}
		return prototype;
	}

	public static List<SObject> createSObjects(SObject prototype, Integer count) {
		return createSObjects(prototype, count, null, false);
	}

	public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName) {
		return createSObjects(prototype, count, usingDefaultsClassName, false);
	}

	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		String usingDefaultsClassName,
		Boolean forceInsert
	) {
		List<SObject> createdSObjects = new List<SObject>();
		SObject constructedFromPrototype = createSObject(prototype, usingDefaultsClassName, false);
		String nameField = calculateNameField(prototype);
		Boolean isNameFieldAutoNumber = nameFieldIsAutoNumber(prototype, nameField);
		for (Integer iterationCounter = 0; iterationCounter < count; iterationCounter++) {
			SObject iterationClone = constructedFromPrototype.clone(false, true);
			if (!isNameFieldAutoNumber) {
				iterationClone.put(nameField, (String) iterationClone.get(nameField) + ' ' + iterationCounter);
			}
			if (forceInsert == false) {
				iterationClone.Id = IdFactory.get(iterationClone);
			}
			createdSObjects.add(iterationClone);
		}
		if (forceInsert) {
			System.debug(LoggingLevel.DEBUG, 'Created SObject: ' + createdSObjects);
			insert createdSObjects;
			List<Database.SaveResult> results = Database.insert(createdSObjects, false, AccessLevel.SYSTEM_MODE);
			for (Database.SaveResult result : results) {
				if (result.success) {
					System.debug(LoggingLevel.DEBUG, 'Created SObject: ' + result.id);
				} else {
					System.debug(LoggingLevel.DEBUG, 'Failed to create SObject: ' + result.errors);
				}
			}
		}
		return createdSObjects;
	}

	// helpers

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
	private static SObject applyOrgWideObjectDefaults(SObject prototype) {
		String objectName = String.valueOf(prototype.getSObjectType());
		String defaultsClassName = 'TestFactoryDefaults.' + objectName.replaceAll('__(c|C)$', '') + 'Defaults';
		if (Type.forName(defaultsClassName) == null) {
			return prototype;
		}
		return applyCustomDefaults(prototype, defaultsClassName);
	}

	private static SObject applyCustomDefaults(SObject prototype, String usingDefaultsClassName) {
		if (usingDefaultsClassName == null) {
			return prototype;
		}
		Type defaultsClassToUse = Type.forName(usingDefaultsClassName);

		if (usingDefaultsClassName != null && defaultsClassToUse == null) {
			throw new TestFactory.TestFactoryException(
				'You specified ' +
					usingDefaultsClassName +
					' as the defaults class, but it does not exist, or has no zero argument constructor.'
			);
		}
		TestFactory.FieldDefaults defaults = (TestFactory.FieldDefaults) defaultsClassToUse?.newInstance();
		return applyFieldDefaults(prototype, defaults?.getFieldDefaults());
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
