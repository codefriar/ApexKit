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
 * See also: https://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5
 * Available primitive datatypes available for use in tuple:
 * Boolean, Integer, Long, Decimal, Double, Date, DateTime, and String. Single values and lists are supported for each data type.
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public with sharing class Tuple {
	@AuraEnabled
	@InvocableVariable
	public String key;

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

	/**
	 * @description standard constructor accepting a key and value
	 * @param key String the name of the Tuple's Key.
	 * @param value Object the Tuple's Value.
	 */
	public Tuple(String key, Object value) {
		if (key == null) {
			throw new TupleException('Key cannot be null');
		}
		if (value == null) {
			throw new TupleException('Value cannot be null');
		}
		this.key = key;
		determineTypeAndSetCastedValue(value);
	}

	/**
	 * @description Method is responsible for determining the type of the value and setting the appropriate field.
	 * @param value Object the Tuple's Value.
	 */
	@SuppressWarnings('PMD.CyclomaticComplexity, PMD.StdCyclomaticComplexity')
	private void determineTypeAndSetCastedValue(Object value) {
		if (value instanceof Boolean) {
			this.booleanValue = (Boolean) value;
		} else if (value instanceof List<Boolean>) {
			this.booleans = (List<Boolean>) value;
		} else if (value instanceof Datetime) {
			this.dateTimeValue = (Datetime) value;
		} else if (value instanceof List<Datetime>) {
			this.datetimes = (List<Datetime>) value;
		} else if (value instanceof Date) {
			this.dateValue = (Date) value;
		} else if (value instanceof List<Date>) {
			this.dates = (List<Date>) value;
		} else if (value instanceof Long) {
			this.longValue = (Long) value;
		} else if (value instanceof List<Long>) {
			this.longs = (List<Long>) value;
		} else if (value instanceof Integer) {
			this.integerValue = (Integer) value;
		} else if (value instanceof List<Integer>) {
			this.integers = (List<Integer>) value;
		} else if (value instanceof Decimal) {
			this.decimalValue = (Decimal) value;
		} else if (value instanceof List<Decimal>) {
			this.decimals = (List<Decimal>) value;
		} else if (value instanceof Double) {
			this.doubleValue = (Double) value;
		} else if (value instanceof List<Double>) {
			this.doubles = (List<Double>) value;
		} else if (value instanceof String) {
			this.stringValue = (String) value;
		} else if (value instanceof List<String>) {
			this.strings = (List<String>) value;
		} else if (value instanceof List<SObject>) {
			this.sobjects = (List<SObject>) value;
		} else if (value instanceof SObject) {
			this.sobjectValue = (SObject) value;
		} else {
			throw new TupleException('Unsupported data type: ' + value);
		}
	}

	/**
	 * @description A custom Exception type thrown when the incoming Object is not a recognized Apex-defined-type safe
	 * type.
	 */
	public class TupleException extends Exception {
	}
}