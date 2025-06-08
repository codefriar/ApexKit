/**
 * @description This class provides an example implementation of the FieldDefaults interface.
 * It provides default values for the Account object.
 */
@IsTest
public with sharing class SomeDefaultsClass implements SObjectFactory.FieldDefaults {
	/**
	 * @description Returns a map of field defaults for the given object.
	 * While this specifies the Account object, it could be any object.
	 * Just ensure that key returned in this map is valid Object.Field syntax
	 * for an SObject field.
	 *
	 * @return Map of Schema.SObjectField to Object containing field defaults
	 */
	public Map<Schema.SObjectField, Object> getFieldDefaults() {
		return new Map<Schema.SObjectField, Object>{
			Account.Name => 'Test Account'
		};
	}
}
