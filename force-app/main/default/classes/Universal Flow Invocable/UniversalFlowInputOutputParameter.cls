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
	@InvocableVariable
	public SObject sobjectValue;
	@InvocableVariable
	public SObject[] sobjects;

	public UniversalFlowInputOutputParameter() {
	} //NOPMD
	public UniversalFlowInputOutputParameter(Object value) {
		String returnType = Polyfills.classNameFromInstance(value);
		switch on returnType.toLowerCase() {
			when 'boolean' {
				booleanValue = (Boolean) value;
			}
			when 'list<boolean>' {
				booleans = (List<Boolean>) value;
			}
			when 'date' {
				dateValue = (Date) value;
			}
			when 'list<date>' {
				dates = (List<Date>) value;
			}
			when 'datetime' {
				dateTimeValue = (Datetime) value;
			}
			when 'list<datetime>' {
				datetimes = (List<Datetime>) value;
			}
			when 'decimal' {
				decimalValue = (Decimal) value;
			}
			when 'list<decimal>' {
				decimals = (List<Decimal>) value;
			}
			when 'double' {
				doubleValue = (Double) value;
			}
			when 'list<double>' {
				doubles = (List<Double>) value;
			}
			when 'integer' {
				integerValue = (Integer) value;
			}
			when 'list<integer>' {
				integers = (List<Integer>) value;
			}
			when 'long' {
				longValue = (Long) value;
			}
			when 'list<long>' {
				longs = (List<Long>) value;
			}
			when 'string' {
				stringValue = (String) value;
			}
			when 'list<string>' {
				strings = (List<String>) value;
			}
			when 'sobject' {
				sobjectValue = (SObject) value;
			}
			when 'list<sobject>' {
				sobjects = (List<SObject>) value;
			}
			when else {
				throw new Invocable.MalformedCallableException(
					'Unable to wrap ' + returnType + ' in CustomObjectWrapper'
				);
			}
		}
	}
}
