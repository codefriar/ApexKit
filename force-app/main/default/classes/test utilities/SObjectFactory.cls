/**
 * @description a factory class for generating test data.
 * This class auto populates required fields and, by default, generates a plausible but fake ID for the record.
 * You can use this class directly, or use one of the associated builder classes for generating
 * complex data structures.
 *
 * This class has the ability to set default values for fields in 3, hierarchical ways.
 * 1. The default values passed into the SObjectFactory via the sObject prototype.
 * 2. The default values defined by the custom default class specified by the usingDefaultsClassName parameter.
 * 3. The default values found in the 'org-wide' defaults class defined in the SObjectFactoryDefaults' subclasses.
 *
 * It's important to note that *nothing* overwrites field values specified in the SObject prototype.
 *
 * Some profiling information:
 * | Action | Avg of 10 test executions |
 * |-----------|------------------------|
 * | Create 10 Single SObject w/ fake Id | 58ms |
 * | Create 10 Single SObjects w/ fake Id and Custom Defaults | 73ms |
 * | Create 10 Single SObjects & insert them | 550ms |
 * | Create list of 200 SObjects w/ fake Id | 115ms |
 * | Create list of 200 SObjects & insert them | 1216ms |
 */
@IsTest
public with sharing class SObjectFactory {
	/**
	 * @description Use the FieldDefaults interface to set up field/value keys you want to routinely impose on your
	 * factory generated objects.
	 */
	public interface FieldDefaults {
		/**
		 * @description Interface used by implementing classes to define defaults.
		 * @return     `Map<Schema.SObjectField, Object>`
		 */
		Map<Schema.SObjectField, Object> getFieldDefaults();
	}

	/**
	 * @description convenience method allowing you to specify just the prototype
	 * @param prototype SObject any SObject
	 * @return A created SObject with required fields populated
	 */
	public static SObject createSObject(SObject prototype) {
		return createSObject(prototype, null, false, false);
	}

	/**
	 * @description Convenience method for creating SObjects using just the prototype and a custom defaults class
	 * @param prototype SObject - any constructed SObject
	 * @param usingDefaultsClassName String - the name of the class to use for custom default values
	 * @return A created SObject with required fields populated
	 */
	public static SObject createSObject(
		SObject prototype,
		String usingDefaultsClassName
	) {
		return createSObject(prototype, usingDefaultsClassName, false, false);
	}

	/**
	 * @description Creates an SObject with the given prototype and forceInsert flag.
	 *
	 * @param prototype The prototype SObject.
	 * @param forceInsert Flag indicating whether to force insertion.
	 *
	 * @return The created SObject.
	 */
	public static SObject createSObject(SObject prototype, Boolean forceInsert) {
		return createSObject(prototype, null, forceInsert, false);
	}

	/**
	 * @description Creates an SObject with the given prototype, using defaults from the specified class, and optionally inserts it into the database.
	 *
	 * @param prototype The prototype SObject to be created.
	 * @param usingDefaultsClassName The name of the class providing default values for the SObject.
	 * @param forceInsert Indicates whether to insert the SObject into the database.
	 *
	 * @return The created SObject.
	 */
	public static SObject createSObject(
		SObject prototype,
		String usingDefaultsClassName,
		Boolean forceInsert
	) {
		return createSObject(prototype, usingDefaultsClassName, forceInsert, false);
	}

	/**
	 * @description Creates an SObject with the given prototype, using defaults from the specified class, optionally inserts it into the database, and optionally prevents fake ID generation.
	 *
	 * @param prototype The prototype SObject to be created.
	 * @param usingDefaultsClassName The name of the class providing default values for the SObject.
	 * @param forceInsert Indicates whether to insert the SObject into the database.
	 * @param preventFakeId Indicates whether to prevent fake ID generation when not inserting.
	 *
	 * @return The created SObject.
	 */
	public static SObject createSObject(
		SObject prototype,
		String usingDefaultsClassName,
		Boolean forceInsert,
		Boolean preventFakeId
	) {
		prototype = internalCreateSObject(prototype, usingDefaultsClassName);
		if (forceInsert) {
			Database.insert(prototype, AccessLevel.SYSTEM_MODE);
		} else if (!preventFakeId) {
			prototype.Id = IdFactory.get(prototype);
		}
		return prototype;
	}

	private static SObject internalCreateSObject(
		SObject prototype,
		String usingDefaultsClassName
	) {
		// ensure the defaults class is not null
		String functionalDefaultsClassName = String.isNotEmpty(
				usingDefaultsClassName
			)
			? usingDefaultsClassName
			: '';
		// First the specified defaults class
		prototype = SObjectFactoryHelper.applyCustomDefaults(
			prototype,
			functionalDefaultsClassName
		);
		// then the 'org-wide' defaults
		prototype = SObjectFactoryHelper.applyOrgWideObjectDefaults(prototype);
		return prototype;
	}

	/**
	 * @description Creates a list of SObjects based on the provided prototype and count.
	 *
	 * @param prototype The SObject prototype to base the created SObjects on.
	 * @param count The number of SObjects to create.
	 *
	 * @return A list of created SObjects.
	 */
	public static List<SObject> createSObjects(SObject prototype, Integer count) {
		return createSObjects(prototype, count, null, false, false);
	}

	/**
	 * @description Creates a list of SObjects based on the provided prototype, count, and defaults class name.
	 *
	 * @param prototype The prototype SObject to base the new SObjects on.
	 * @param count The number of SObjects to create.
	 * @param usingDefaultsClassName The name of the class to use for default values.
	 *
	 * @return A list of created SObjects.
	 */
	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		String usingDefaultsClassName
	) {
		return createSObjects(prototype, count, usingDefaultsClassName, false, false);
	}

	/**
	 * @description Creates a list of sObjects based on the provided prototype, count, and forceInsert flag.
	 *
	 * @param prototype The prototype SObject to base the created objects on.
	 * @param count The number of SObjects to create.
	 * @param forceInsert Flag indicating whether to force insertion of the created SObjects.
	 *
	 * @return List of created SObjects.
	 */
	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		Boolean forceInsert
	) {
		return createSObjects(prototype, count, null, forceInsert, false);
	}

	/**
	 * @description Creates a list of SObjects based on a prototype, count, defaults class, and force insert flag.
	 *
	 * @param prototype The prototype SObject to clone.
	 * @param count The number of SObjects to create.
	 * @param usingDefaultsClassName The name of the defaults class to use.
	 * @param forceInsert Whether to force insert the created SObjects.
	 *
	 * @return A list of created SObjects.
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		String usingDefaultsClassName,
		Boolean forceInsert
	) {
		return createSObjects(prototype, count, usingDefaultsClassName, forceInsert, false);
	}

	/**
	 * @description Creates a list of SObjects based on a prototype, count, defaults class, force insert flag, and preventFakeId flag.
	 *
	 * @param prototype The prototype SObject to clone.
	 * @param count The number of SObjects to create.
	 * @param usingDefaultsClassName The name of the defaults class to use.
	 * @param forceInsert Whether to force insert the created SObjects.
	 * @param preventFakeId Whether to prevent fake ID generation when not inserting.
	 *
	 * @return A list of created SObjects.
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		String usingDefaultsClassName,
		Boolean forceInsert,
		Boolean preventFakeId
	) {
		List<SObject> createdSObjects = new List<SObject>();
		SObject constructedFromPrototype = internalCreateSObject(
			prototype,
			usingDefaultsClassName
		);
		for (
			Integer iterationCounter = 0; iterationCounter < count; iterationCounter++
		) {
			SObject clonedSObject = constructedFromPrototype.clone(false, true);
			createdSObjects.add(
				SObjectFactoryHelper.mutateCloneToRespectNameAndAutonumberRules(
					clonedSObject,
					!forceInsert,
					iterationCounter,
					preventFakeId
				)
			);
		}
		SObjectFactoryHelper.insertIfForced(createdSObjects, forceInsert);
		return createdSObjects;
	}
}
