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

	public UniversalFlowInputOutputParameter() {
	} //NOPMD
	/**
	 * @description Wraps an Object into different property types that will be used by flows.
	 *
	 * @param value The value to convert into native data types
	 */
	public UniversalFlowInputOutputParameter(Object value) {
		Boolean isBoolean = value instanceof Boolean;
		Boolean isDateTime = value instanceof DateTime;
		Boolean isDate = value instanceof Date;
		Boolean isLong = value instanceof Long;
		Boolean isInteger = value instanceof Integer;
		Boolean isDecimal = value instanceof Decimal;
		Boolean isDouble = value instanceof Double;
		Boolean issObject = value instanceof SObject;
		Boolean isBooleanList = value instanceof List<Boolean>;
		Boolean isDateTimeList = value instanceof List<DateTime>;
		Boolean isDateList = value instanceof List<Date>;
		Boolean isLongList = value instanceof List<Long>;
		Boolean isIntegerList = value instanceof List<Integer>;
		Boolean isDecimalList = value instanceof List<Decimal>;
		Boolean isDoubleList = value instanceof List<Double>;
		Boolean issObjectList = value instanceof List<sObject>;

		if (isBoolean) {
			BooleanValue = (Boolean) value;
		}
		if (isDateTime) {
			DateTimeValue = (DateTime) value;
		}
		if (isDate) {
			DateValue = (Date) value;
		}
		if (isLong) {
			LongValue = (Long) value;
		}
		if (isInteger) {
			IntegerValue = (Integer) value;
		}
		if (isDecimal) {
			DecimalValue = (Decimal) value;
		}
		if (isDouble) {
			DoubleValue = (Double) value;
		}
		if (issObject) {
			sObjectValue = (sObject) value;
		}
		if (isBooleanList) {
			Booleans = (List<Boolean>) value;
		}
		if (isDateTimeList) {
			DateTimes = (List<DateTime>) value;
		}
		if (isDateList) {
			Dates = (List<Date>) value;
		}
		if (isLongList) {
			Longs = (List<Long>) value;
		}
		if (isIntegerList) {
			Integers = (List<Integer>) value;
		}
		if (isDecimalList) {
			Decimals = (List<Decimal>) value;
		}
		if (isDoubleList) {
			Doubles = (List<Double>) value;
		}
		if (issObjectList) {
			sObjects = (List<sObject>) value;
		}
	}
}
