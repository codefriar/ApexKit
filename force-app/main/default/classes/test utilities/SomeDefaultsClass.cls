@IsTest
public with sharing class SomeDefaultsClass implements SObjectFactory.FieldDefaults {
	public Map<Schema.SObjectField, Object> getFieldDefaults() {
		return new Map<Schema.SObjectField, Object>{ Account.Name => 'Test Account' };
	}
}
