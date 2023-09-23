/**
 * @description This is a common object for passing data from a flow, into a class method, and back out to flow.
 */
public class UniversalFlowInputOutput {
	/**
	 * @description String representing Apex recognized name of the class you're instantiating.
	 */
  @AuraEnabled
	@InvocableVariable(Required=true)
	public String className;
	/**
	 * @description String representing the method name you're calling
	 */
  @AuraEnabled
	@InvocableVariable(Required=true)
	public String methodName;
	/**
	 * @description This is a list of individual parameters you're passing to the method you're calling.
	 * @see UniversalFlowInputOutputParameter
	 */
  @AuraEnabled
	@InvocableVariable
	public List<UniversalFlowInputOutputParameter> parameters;
	/**
	 * @description While the parameters list is used for passing parameters to the method you're calling,
	 * this single object is used for passing the return value of the method you're calling back to flow.
	 * As a side effect of the way this works, you can build aggregating methods that call multiple methods
	 * and return multiple values - of different types - to the flow via this object.
	 * @see UniversalFlowInputOutputParameter
	 */
  @AuraEnabled
	@InvocableVariable
	public UniversalFlowInputOutputParameter result;
  @AuraEnabled
  @InvocableVariable
  public Boolean success;

	/**
	 * @description Flow requires a 0 argument constructor, so we provide one here.
	 */
	public UniversalFlowInputOutput() {
	} //NOPMD

	/**
	 * @description This constructor variant is used by this class, and the the UniversalInvocable class to
	 * construct the return object.
	 * @param className String Name of the class called
	 * @param methodName String Name of the method called
	 * @param parameter UniversalFlowInputOutputParameter The return value of the called method is automatically
	 * cast to it's respective primitive type and stored in this object.
	 */
	public UniversalFlowInputOutput(
		String className,
		String methodName,
		Object returnValue,
    Boolean isError
	) {
		this.className = className;
		this.methodName = methodName;
		this.result = new UniversalFlowInputOutputParameter(returnValue);
    this.success = !isError;
	}

	/**
	 * @description Method is responsible for converting the list of UniversalFlowInputOutputParameter objects
	 * delivered by the Flow action framework, to a Map<String, Object> needed by the Callable interface. Note, this
	 * is a hard limitation of the Flow action framework and the Apex Defined Data Types. This is not a limitation
	 * of this pattern / framework. If you want to, say pass a list of records to a method, you'll need to pass a
	 * list of strings, and query for the objects in the Apex. #sorryNothingICanDo.
	 * @return Map<String, Object> This returns a map of parameters you're passing to your method.
	 */
	public Map<String, Object> toCallableParamMap() {
		Map<String, Object> paramMap = new Map<String, Object>();
		if (parameters == null) {
			return paramMap;
		}
		for (UniversalFlowInputOutputParameter parameter : parameters) {
			Object value;

			if (parameter.booleanValue != null) {
				value = parameter.booleanValue;
			}
			if (parameter.booleans != null) {
				value = parameter.booleans;
			}
			if (parameter.dateTimeValue != null) {
				value = parameter.dateTimeValue;
			}
			if (parameter.datetimes != null) {
				value = parameter.datetimes;
			}
			if (parameter.dateValue != null) {
				value = parameter.dateValue;
			}
			if (parameter.dates != null) {
				value = parameter.dates;
			}
			if (parameter.integerValue != null) {
				value = parameter.integerValue;
			}
			if (parameter.integers != null) {
				value = parameter.integers;
			}
			if (parameter.longValue != null) {
				value = parameter.longValue;
			}
			if (parameter.longs != null) {
				value = parameter.longs;
			}
			if (parameter.doubleValue != null) {
				value = parameter.doubleValue;
			}
			if (parameter.doubles != null) {
				value = parameter.doubles;
			}
			if (parameter.decimalValue != null) {
				value = parameter.decimalValue;
			}
			if (parameter.decimals != null) {
				value = parameter.decimals;
			}
			if (parameter.sobjectValue != null) {
				value = parameter.sobjectValue;
			}
			if (parameter.sobjects != null) {
				value = parameter.sobjects;
			}
			if (parameter.stringValue != null) {
				value = parameter.stringValue;
			}
			if (parameter.strings != null) {
				value = parameter.strings;
			}
			paramMap.put(parameter.parameterName, value);
		}
		return paramMap;
	}
	/**
	 * @description Used to provide a usable key for the Map that uses this method.
	 *
	 * @return      `String`  This value maps unique class/method names
	 */
	public override String toString() {
		return (className + '/' + methodName).toLowerCase();
	}
  
}
