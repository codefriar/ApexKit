/**
 * @description This provides a common interface for classes & methods developers want to expose to flow.
 * Intrepid developers will note you could just implement the Callable interface in all of your classes.
 * However, this class provides a few benefits:
 * - It provides a common interface for all of your classes, which makes it easier to understand what is exposed to flow.
 * - It provides a common exception type, which makes it easier to handle exceptions in flow.
 * - It provides a common wrapper for returning custom objects, which makes it easier to return custom objects in flow.
 *
 * This is an abstract class. This means the classes you want to expose to flow must extend this class.
 * Extending this class will require you to implement the call() method. This is used by the Callable interface
 * and is how developers can expose multiple class methods to flow without writing 1 class with 1 invocable method per
 * method exposed.
 *
 * It should be noted that you should consider this a pattern. Modifying this pattern on a per-class basis would offer
 * more flexibility, additional focus on input types and output types, and more control over the flow experience.
 */
public abstract class Invocable implements Callable {
	/**
	 * @description This is the class name of the class that extends this class. It's primary use is for logging
	 * exceptions.
	 */
	public String className;
	/**
	 * @description This is the method name of the method called by flow. It's primary use is for logging
	 * exceptions.
	 */
	public String methodName;

	/**
	 * @description This is a required method of the callable interface that this class implements.
	 * You'll need to extend the class you intend to expose to flow with this one, and implement this method.
	 * @param methodName This is a string representing the name of the method you want to call.
	 * @param passedParameters This is a map of parameters you're passing to your method.
	 *
	 * @return Object This returns a generic Object. This is the return value of the method you're calling.
	 */
	abstract public Object call(
		String methodName,
		Map<String, Object> passedParameters
	);

	/**
	 * @description This is a common exception object shared by all classes that extend this class. Used primarially
	 * by this class to throw exceptions when the call() method is not implemented, or when the call() method doesn't
	 * handle the method name or parameters passed to it.
	 */
	public class MallformedCallableException extends Exception {
	}

	/**
	 * @description Method is responsible for constructing and throwing a structured exception when the call() method
	 * is not implemented, or when the call() method doesn't handle the method name or parameters passed to it.
	 */
	protected void throwMalformedCallableException() {
		String className = Polyfills.classNameFromInstance(this);
		throw new MallformedCallableException(
			'Unable to call ' +
				className +
				'.call() because it is not implemented, or call() doesn\'t handle the ' +
				this.methodName +
				' method or parameters'
		);
	}

	/**
	 * @description This is a common object for passing data from a flow, into a class method, and back out to flow.
	 */
	public class UniversalFlowInputOutput {
		/**
		 * @description String representing Apex recognized name of the class you're instantiating.
		 */
		@InvocableVariable(Required=true)
		public String className;
		/**
		 * @description String representing the method name you're calling
		 */
		@InvocableVariable(Required=true)
		public String methodName;
		/**
		 * @description This is a list of individual parameters you're passing to the method you're calling.
		 * @see UniversalFlowInputOutputParameter
		 */
		@InvocableVariable
		public List<UniversalFlowInputOutputParameter> parameters;
		/**
		 * @description While the parameters list is used for passing parameters to the method you're calling,
		 * this single object is used for passing the return value of the method you're calling back to flow.
		 * As a side effect of the way this works, you can build aggregating methods that call multiple methods
		 * and return multiple values - of different types - to the flow via this object.
		 * @see UniversalFlowInputOutputParameter
		 */
		@InvocableVariable
		public UniversalFlowInputOutputParameter result;

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
			Object parameter
		) {
			this.className = className;
			this.methodName = methodName;
			this.result = new UniversalFlowInputOutputParameter(parameter);
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
			for (UniversalFlowInputOutputParameter parameter : parameters) {
				switch on parameter.parameterType.toLowerCase() {
					when 'boolean' {
						paramMap.put(
							parameter.parameterName,
							parameter.booleanValue
						);
					}
					when 'list<boolean>' {
						paramMap.put(
							parameter.parameterName,
							parameter.booleans
						);
					}
					when 'date' {
						paramMap.put(
							parameter.parameterName,
							parameter.dateValue
						);
					}
					when 'list<date>' {
						paramMap.put(parameter.parameterName, parameter.dates);
					}
					when 'datetime' {
						paramMap.put(
							parameter.parameterName,
							parameter.dateTimeValue
						);
					}
					when 'list<datetime>' {
						paramMap.put(
							parameter.parameterName,
							parameter.datetimes
						);
					}
					when 'decimal' {
						paramMap.put(
							parameter.parameterName,
							parameter.decimalValue
						);
					}
					when 'list<decimal>' {
						paramMap.put(
							parameter.parameterName,
							parameter.decimals
						);
					}
					when 'double' {
						paramMap.put(
							parameter.parameterName,
							parameter.doubleValue
						);
					}
					when 'list<double>' {
						paramMap.put(
							parameter.parameterName,
							parameter.doubles
						);
					}
					when 'integer' {
						paramMap.put(
							parameter.parameterName,
							parameter.integerValue
						);
					}
					when 'list<integer>' {
						paramMap.put(
							parameter.parameterName,
							parameter.integers
						);
					}
					when 'long' {
						paramMap.put(
							parameter.parameterName,
							parameter.longValue
						);
					}
					when 'list<long>' {
						paramMap.put(parameter.parameterName, parameter.longs);
					}
					when 'string' {
						paramMap.put(
							parameter.parameterName,
							parameter.stringValue
						);
					}
					when 'list<string>' {
						paramMap.put(
							parameter.parameterName,
							parameter.strings
						);
					}
					when else {
						throw new MallformedCallableException(
							'Unable to determine type of ' +
								parameter.parameterType +
								' for parameter ' +
								parameter.parameterName
						);
					}
				}
			}
			return paramMap;
		}
	}
}