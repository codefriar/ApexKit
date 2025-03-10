@IsTest
/**
 * @description Class models a callable apex method's 'signature' or combination
 * of Name, Parameter types and Parameter values. This is separate from a
 * MockedMethod, because it can be constructed at runtime for comparison against
 * established MockedMethods.
 */
public with sharing class MethodSignature {
	@TestVisible
	private String methodName;
	@TestVisible
	private List<Type> methodParameterTypes;

	/**
	 * @description Constructor requiring a method name and list of parameters. This method cannot be constructed
	 * without these.
	 *
	 * @param methodName String Name of the method to be mocked
	 * @param paramTypes List<System.Type> of the parameters for the method
	 */
	public MethodSignature(String methodName, List<Type> paramTypes) {
		this.methodName = methodName;
		this.methodParameterTypes = paramTypes;
	}

	/**
	 * @description This is used to compare the signature of a
	 * MockedMethod, against another instance. Used at runtime to compare
	 * an actually requested method call against pre-defined mocks.
	 *
	 * @param otherSignature the secondary MethodSignature object to compare against
	 *
	 * @return `Boolean` true if the signatures match, false if they do not
	 */
	public Boolean verifySignatureMatch(MethodSignature otherSignature) {
		return verifyMethodNamesMatch(this.methodName, otherSignature.methodName) &&
			methodParameterTypes.equals(otherSignature.methodParameterTypes);
	}

	/**
	 * @description Returns true if the current MethodSignature's
	 * methodName is a case insensitive match to the comparison's methodName
	 *
	 * @param originalMethodName String name of the method name called
	 * @param comparatorMethodName String name of the method name to compare
	 *
	 * @return `Boolean` true if the method names match,
	 */
	private static Boolean verifyMethodNamesMatch(String originalMethodName, String comparatorMethodName) {
		return originalMethodName.equalsIgnoreCase(comparatorMethodName);
	}

	/**
	 * @description returns the method name for this signature
	 *
	 * @return String method name
	 */
	public String getMethodName() {
		return this.methodName;
	}

	/**
	 * @description While a MethodSignature object can be created directly the
	 * more common use case is to use this Builder class to construct the
	 * MethodSignature object in a Fluent api style.
	 */
	public class Builder {
		private final StubBuilder stubBuilder;
		@TestVisible
		private String methodName;
		public List<Type> parameterTypes;

		// A list of MockedMethod.Builders that have this signature.
		// One MethodSignature may have multiple MockedMethods because the
		// runtime parameter *values* differ.
		final List<MockedMethod.Builder> methodBuilders = new List<MockedMethod.Builder>();

		/**
		 * @description      Constructor.
		 * @param builder    A StubBuilder object
		 * @param methodName String referencing the name of the method minus
		 * things like ()
		 * @param paramTypes A list of System.Types that define the order and
		 * type of parameters for the method.
		 */
		public Builder(StubBuilder builder, String methodName, List<System.Type> paramTypes) {
			this.stubBuilder = builder;
			this.methodName = methodName;
			this.parameterTypes = paramTypes;
		}

		/**
		 * @description This variant handles the situation where a mocked method
		 * was called without parameters.
		 * @return      `MockedMethod.Builder`
		 */
		public MockedMethod.Builder withParameterTypes() {
			return withParameterTypes(new List<System.Type>());
		}

		/**
		 * @description Omnibus variant that handles a list(N) of
		 * parameters.
		 *
		 * @param parameters List<System.Type> of parameters
		 *
		 * @return `MockedMethod.Builder`
		 */
		public MockedMethod.Builder withParameterTypes(List<System.Type> parameters) {
			this.parameterTypes.addAll(parameters);
			MockedMethod.Builder mockedMethodBuilder = new MockedMethod.Builder(this, parameters);

			methodBuilders.add(mockedMethodBuilder);
			return mockedMethodBuilder;
		}

		/**
		 * @description This variant handles a single parameter, brokers to omnibus method.
		 *
		 * @param parameter Type of the parameter
		 *
		 * @return `MockedMethod.Builder`
		 */
		public MockedMethod.Builder withParameterTypes(System.Type parameter) {
			return withParameterTypes(new List<System.Type>{ parameter });
		}

		/**
		 * @description Two parameter variant. Brokers to omnibus method.
		 *
		 * @param parameter Type of the parameter
		 * @param parameter2 Type of the second parameter
		 *
		 * @return `MockedMethod.Builder`
		 */
		public MockedMethod.Builder withParameterTypes(System.Type parameter, System.Type parameter2) {
			return withParameterTypes(new List<System.Type>{ parameter, parameter2 });
		}

		/**
		 * @description Three parameter variant. Brokers to omnibus method.
		 *
		 * @param parameter Type of the parameter
		 * @param parameter2 Type of the second parameter
		 * @param parameter3 Type of the third parameter
		 *
		 * @return `MockedMethod.Builder`
		 */
		public MockedMethod.Builder withParameterTypes(
			System.Type parameter,
			System.Type parameter2,
			System.Type parameter3
		) {
			return withParameterTypes(new List<System.Type>{ parameter, parameter2, parameter3 });
		}

		/**
		 * @description Four parameter variant. Brokers to omnibus method.
		 *
		 * @param parameter Type of the parameter
		 * @param parameter2 Type of the second parameter
		 * @param parameter3 Type of the third parameter
		 * @param parameter4 Type of the fourth parameter
		 *
		 * @return `MockedMethod.Builder`
		 */
		@SuppressWarnings('PMD.ExcessiveParameterList')
		public MockedMethod.Builder withParameterTypes(
			System.Type parameter,
			System.Type parameter2,
			System.Type parameter3,
			System.Type parameter4
		) {
			return withParameterTypes(new List<System.Type>{ parameter, parameter2, parameter3, parameter4 });
		}

		/**
		 * @description Called at the end of building a method signature.
		 * @return      `StubBuilder`
		 */
		public StubBuilder finalizeSignature() {
			return stubBuilder;
		}

		/**
		 * @description Creates the MockedMethod matching this method signature.
		 * @return      `List<MockedMethod>`
		 */
		public List<MockedMethod> buildMockedMethod() {
			MethodSignature signature = new MethodSignature(methodName, parameterTypes);

			List<MockedMethod> methodCalls = new List<MockedMethod>();
			for (MockedMethod.Builder currentMethodBuilder : methodBuilders) {
				methodCalls.add(currentMethodBuilder.createMockedMethod(signature));
			}

			return methodCalls;
		}
	}
}
