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
 *
 * @see SObjectFactoryHelper
 * @see SObjectFactoryDefaults
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
	 *
	 * @return A created SObject with required fields populated
	 * @example `Account testAccount = (Account) SObjectFactory.createSObject(new Account());`
	 */
	public static SObject createSObject(SObject prototype) {
		return createSObject(prototype, null, false);
	}

	/**
	 * @description Convenience method for creating SObjects using just the prototype and a custom defaults class
	 * @param prototype SObject - any constructed SObject
	 * @param usingDefaultsClassName String - the name of the class to use for custom default values
	 *
	 * @return A created SObject with required fields populated
	 * @example `Account testAccount = (Account) SObjectFactory.createSObject(new Account(), 'SomeDefaultsClass');`
	 */
	public static SObject createSObject(SObject prototype, String usingDefaultsClassName) {
		return createSObject(prototype, usingDefaultsClassName, false);
	}

	/**
	 * @description Create sObject variant supporting just the prototype and forceInsert params.
	 * @param prototype SObject any SObject to create the SObject from
	 * @param forceInsert Boolean if true, results in the record being inserted before returning from the method.
	 *
	 * @return A created SObject with the required fields populated
	 * @example `Account testAccount = (Account) SObjectFactory.createSObject(new Account(), true);`
	 */
	public static SObject createSObject(SObject prototype, Boolean forceInsert) {
		return createSObject(prototype, null, forceInsert);
	}

	/**
	 * @description Create SObject variant supporting prototype, custom defaults class and the forceInsert boolean
	 * @param prototype SObject the prototype sobject to start from
	 * @param usingDefaultsClassName String name of the class to instantiate for defaults
	 * @param forceInsert Boolean if true, results in the record being inserted prior to returning from the method.
	 *
	 * @return A Created SObject with the required fields populated
	 * @example `Account testAccount = (Account) SObjectFactory.createSObject(new Account(), );`
	 */
	public static SObject createSObject(SObject prototype, String usingDefaultsClassName, Boolean forceInsert) {
		prototype = internalCreateSObject(prototype, usingDefaultsClassName);
		if (forceInsert) {
			Database.insert(prototype, AccessLevel.SYSTEM_MODE);
		} else {
			prototype.Id = IdFactory.get(prototype);
		}
		return prototype;
	}

	/**
	 * @description This is an internal version of the createSObject method used by the param-complete public version
	 * of createSObject, and consequently by every method in this class. It's responsible for applying default values
	 * to fields in the following order:
	 *  1. Custom Default class, if specified
	 *  2. The 'org wide' defaults stored in SObjectFactoryDefaults' subclasses.
	 * @param prototype SObject the prototype object to start from
	 * @param usingDefaultsClassName String the name of a Defaults Class to attempt to instantiate
	 *
	 * @return SObject A Created SObject with the required fields populated
	 */
	private static SObject internalCreateSObject(SObject prototype, String usingDefaultsClassName) {
		// ensure the defaults class is not null
		String functionalDefaultsClassName = String.isNotEmpty(usingDefaultsClassName) ? usingDefaultsClassName : '';
		// First the specified defaults class
		prototype = SObjectFactoryHelper.applyCustomDefaults(prototype, functionalDefaultsClassName);
		// then the 'org-wide' defaults
		prototype = SObjectFactoryHelper.applyOrgWideObjectDefaults(prototype);
		return prototype;
	}

	/**
	 * @description A method to generate a list of SObjects from a single prototype supporting just the prototype,
	 * and count params.
	 * @param prototype SObject The prototype object to build from
	 * @param count Integer number of objects to generate
	 *
	 * @return List<SObject> A generated list of constructed SObjects with default field values specified.
	 * @example `List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200);`
	 */
	public static List<SObject> createSObjects(SObject prototype, Integer count) {
		return createSObjects(prototype, count, null, false);
	}

	/**
	 * @description A method to generate a list of SObjects from a single prototype supporting just the prototype, count and custom default params
	 * @param prototype SObject The prototype object to build from
	 * @param count Integer number of objects to generate
	 * @param usingDefaultsClassName String the name of a class to instantiate for default values
	 *
	 * @return List<SObject> A generated list of constructed SObjects with default field values specified.
	 * @example `List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, 'SomeDefaultsClass');`
	 */
	public static List<SObject> createSObjects(SObject prototype, Integer count, String usingDefaultsClassName) {
		return createSObjects(prototype, count, usingDefaultsClassName, false);
	}

	/**
	 * @description A method to generate a list of SObjects from a single prototype supporting just the prototype, count and forceInsert params
	 * @param prototype SObject The prototype object to build from
	 * @param count Integer number of objects to generate
	 * @param forceInsert Boolean If true, results in the list being inserted before the method returns the list.
	 *
	 * @return List<SObject> A generated list of constructed SObjects with default field values specified.
	 * @example `List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, false);`
	 */
	public static List<SObject> createSObjects(SObject prototype, Integer count, Boolean forceInsert) {
		return createSObjects(prototype, count, null, forceInsert);
	}

	/**
	 * @description A method to generate a list of SObjects from a single prototype
	 * @param prototype SObject The prototype object to build from
	 * @param count Integer number of objects to generate
	 * @param usingDefaultsClassName String name of a class to instantiate for custom default values
	 * @param forceInsert Boolean If true, results in the list being inserted before the method returns the list.
	 *
	 * @return List<SObject> A generated list of constructed SObjects with default field values specified.
	 * @example `List<Account> testAccounts = (List<Account>) SObjectFactory.createSObjects(new Account(), 200, 'SomeDefaultsClass', false);`
	 */
	public static List<SObject> createSObjects(
		SObject prototype,
		Integer count,
		String usingDefaultsClassName,
		Boolean forceInsert
	) {
		List<SObject> createdSObjects = new List<SObject>();
		SObject constructedFromPrototype = internalCreateSObject(prototype, usingDefaultsClassName);
		for (Integer iterationCounter = 0; iterationCounter < count; iterationCounter++) {
			SObject clonedSObject = constructedFromPrototype.clone(false, true);
			createdSObjects.add(
				SObjectFactoryHelper.mutateCloneToRespectNameAndAutonumberRules(clonedSObject, !forceInsert, iterationCounter)
			);
		}
		SObjectFactoryHelper.insertIfForced(createdSObjects, forceInsert);
		return createdSObjects;
	}
}
