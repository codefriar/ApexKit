@IsTest
public with sharing class SomeDefaultsClass implements TestFactory.FieldDefaults {
	public Map<Schema.SObjectField, Object> getFieldDefaults() {
		return new Map<Schema.SObjectField, Object>{ Account.Name => 'Test Account' };
	}
}
