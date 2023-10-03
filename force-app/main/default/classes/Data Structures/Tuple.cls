/**
 * @description Tuple represents a key-value pair. Kinda. Don't come at me math nerds.
 *
 * You may be asking why this exists, given the existence of Map. Unfortuately Map isn't available everywhere.
 * Notably, it's not available in Apex-defined Data Types used by Flow/Invocable actions.
 *
 * Additionally, `Object` is not a valid data type in Apex-defined Data Types, so we can't use a list of objects
 * that have a string key, and Object value. This is the next best thing. A kind of polyfill for Map<String,Object>
 *     for use in Apex-defined Data Types.
 *
 * @see https ://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5
 * Available primitive datatypes available for use in tupple:
 * Boolean, Integer, Long, Decimal, Double, Date, DateTime, and String. Single values and lists are supported for each data type.
 */
public with sharing class Tuple {
	/**
	 * @description This is an 'Apex Defined Type'. According to the documentation, the following types are supported:
	 * Boolean, Date, DateTime, Double, Decimal, Integer, Long, and String
	 * https://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5
	 */

	@AuraEnabled
	@InvocableVariable
	public Boolean[] booleans;
	@AuraEnabled
	@InvocableVariable
	public Boolean booleanValue;
	@AuraEnabled
	@InvocableVariable
	public Date dateValue;
	@AuraEnabled
	@InvocableVariable
	public Date[] dates;
	@AuraEnabled
	@InvocableVariable
	public Datetime[] datetimes;
	@AuraEnabled
	@InvocableVariable
	public Datetime dateTimeValue;
	@AuraEnabled
	@InvocableVariable
	public Double doubleValue;
	@AuraEnabled
	@InvocableVariable
	public Double[] doubles;
	@AuraEnabled
	@InvocableVariable
	public Decimal decimalValue;
	@AuraEnabled
	@InvocableVariable
	public Decimal[] decimals;
	@AuraEnabled
	@InvocableVariable
	public Integer integerValue;
	@AuraEnabled
	@InvocableVariable
	public Integer[] integers;
	@AuraEnabled
	@InvocableVariable
	public Long longValue;
	@AuraEnabled
	@InvocableVariable
	public Long[] longs;
	@AuraEnabled
	@InvocableVariable
	public String stringValue;
	@AuraEnabled
	@InvocableVariable
	public String[] strings;
	@AuraEnabled
	@InvocableVariable
	public SObject sobjectValue;
	@AuraEnabled
	@InvocableVariable
	public SObject[] sobjects;

	/**
	 * @description In order to create a Tuple instance from within a flow, you need a no-arg constructor.
	 */
	@SuppressWarnings('PMD.EmptyStatementBlock')
	public Tuple() {
	}

	public Tuple(String key, Object value) {
	}
}
