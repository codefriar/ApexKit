/**
 * @description This class contains the object definition used by the Universal Invocable Action. It's designed
 * to expose variables of every type allowed by the InvocableVariable method in a single object. It uses type detection
 * to set the correct property on ouput.
 */
public class UniversalFlowInputOutputParameter {
	/**
	 * @description This is an 'Apex Defined Type'. According to the documentation, the following types are supported:
	 * Boolean, Date, DateTime, Double, Decimal, Integer, Long, and String
	 * https://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5
	 */

	@AuraEnabled
	@InvocableVariable(Required=true)
	public String parameterName;
	@AuraEnabled
	@InvocableVariable(Required=true)
	public String parameterType;

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
	 * @description Default no parameter constructor required by the Invocable Variable/Method system for constructing
	 * an *output* parameter.
	 */
	@SuppressWarnings('PMD.EmptyStatementBlock')
	public UniversalFlowInputOutputParameter() {
	}

	/**
	 * @description Wraps an Object into different property types that will be used by flows.
	 *
	 * @param value The value to convert into native data types
	 */
	public UniversalFlowInputOutputParameter(Object value) {
		Boolean isBoolean = value instanceof Boolean;
		Boolean isDateTime = value instanceof Datetime;
		Boolean isDate = value instanceof Date;
		Boolean isLong = value instanceof Long;
		Boolean isInteger = value instanceof Integer;
		Boolean isDecimal = value instanceof Decimal;
		Boolean isDouble = value instanceof Double;
		Boolean issObject = value instanceof SObject;
		Boolean isBooleanList = value instanceof List<Boolean>;
		Boolean isDateTimeList = value instanceof List<Datetime>;
		Boolean isDateList = value instanceof List<Date>;
		Boolean isLongList = value instanceof List<Long>;
		Boolean isIntegerList = value instanceof List<Integer>;
		Boolean isDecimalList = value instanceof List<Decimal>;
		Boolean isDoubleList = value instanceof List<Double>;
		Boolean issObjectList = value instanceof List<SObject>;

		if (isBoolean) {
			booleanValue = (Boolean) value;
		}
		if (isDateTime) {
			dateTimeValue = (Datetime) value;
		}
		if (isDate) {
			dateValue = (Date) value;
		}
		if (isLong) {
			longValue = (Long) value;
		}
		if (isInteger) {
			integerValue = (Integer) value;
		}
		if (isDecimal) {
			decimalValue = (Decimal) value;
		}
		if (isDouble) {
			doubleValue = (Double) value;
		}
		if (issObject) {
			sobjectValue = (SObject) value;
		}
		if (isBooleanList) {
			booleans = (List<Boolean>) value;
		}
		if (isDateTimeList) {
			datetimes = (List<Datetime>) value;
		}
		if (isDateList) {
			dates = (List<Date>) value;
		}
		if (isLongList) {
			longs = (List<Long>) value;
		}
		if (isIntegerList) {
			integers = (List<Integer>) value;
		}
		if (isDecimalList) {
			decimals = (List<Decimal>) value;
		}
		if (isDoubleList) {
			doubles = (List<Double>) value;
		}
		if (issObjectList) {
			sobjects = (List<SObject>) value;
		}
	}
}
