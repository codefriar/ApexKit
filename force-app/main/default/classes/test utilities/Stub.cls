/**
 * @description This class helps you construct and manage StubProvider conforming objects for use in Unit Tests. It,
 * along with it's companion classes:
 *   * MockedMethod
 *   * MethodSignature
 * and their builder-pattern inner classes are designed to work together with a fluent API style like this:
 *
 * @see MockedMethod
 * @see MethodSignature
 * @see StubBuilder
 *
 * @example
 * ```apex
 *  // this is a generic example of what's possible. Given an Object named 'Foo' you want to create a stub of while
 *  // also specifying a couple of methods to be mocked you'd do something like this:
 *
 * Foo fooStub = new StubBuilder('foo.class') // This creates the Stub object to mimic a live instance of `Foo`
	.mockingMethodCall('someMethodName') // specifies a method with no params to mock OR
	.mockingMethodCall('someMethodName',
	.withParameterTypes()
	.returning() || .throwingException() || .throwingException(ExceptionObj)
	.mockingMethodCall('secondMethodName', ...)
	.withParameterTypes()
	.returning() || .throwingException() || .throwingException(ExceptionObj)
	.createStub(true)

 * ```
 * @example
 * ```apex
 * // This example creates a mock MetadataTriggerQueryService
 * MetadataTriggerQueryService metadataTriggerQueryServiceStub = (MetadataTriggerQueryService) new StubBuilder(
				MetadataTriggerQueryService.class
			)
			.mockingMethodCall('getMetadataTriggers')
			.withParameterTypes()
			.returning(new List<Metadata_Driven_Trigger__mdt>())
			.defineStub(true);
 * ```
 *
 */
@IsTest
public with sharing class Stub implements System.StubProvider {
	// marked final, because we don't ever want to be in a situation where we're
	// changing the Stub object type.
	private final Type objectType;
	// marked private, because only this class should be able to directly
	// interact with this list of MockedMethod
	@TestVisible
	private List<MockedMethod> mockedMethods = new List<MockedMethod>();

	/**
	 * @description required constructor finalizing the object type.
	 *
	 * @param objectType Type class: ie: Foo.class
	 */
	public Stub(Type objectType) {
		this.objectType = objectType;
	}

	/**
	 * @description convenience constructor that accepts a pre-built
	 * list of MockedMethod objects.
	 *
	 * @param objectType type class: ie. Foo.class
	 * @param mockedMethods List of MockedMethod objects
	 */
	public Stub(Type objectType, List<MockedMethod> mockedMethods) {
		this(objectType);
		this.mockedMethods = mockedMethods;
	}

	/**
	 * @description method required by the StubProvider interface. Handles the mock execution of the given method call.
	 *
	 * @param obj dependency injected by Apex, object the mock method was call upon
	 * @param methodName dependency injected by Apex, string representation of the name of the method used to construct
	 * a MethodSignature object for comparison.
	 * @param returnType dependency injected by Apex, not currently used.
	 * @param paramTypes dependency injected by Apex, list of parameter types used to construct a MethodSignature object
	 * for comparison.
	 * @param paramNames dependency injected by Apex, not currently used.
	 * @param args dependency injected by Apex, not currently used.
	 *
	 * @return `Object`
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public Object handleMethodCall(
		Object obj,
		String methodName,
		Type returnType,
		List<Type> paramTypes,
		List<String> paramNames,
		List<Object> args
	) {
		// Creates a method signature object from dependency injected variables
		// used for comparing the current method call being handled against the
		// list of MockedMethod objects
		MethodSignature methodSignature = new MethodSignature(methodName, paramTypes);

		// Iterates over the known list of MockedMethod objects. When it finds
		// a match to the currently handled method call, it delegates the return
		// value to the MockedMethod.handleCall() method.
		for (MockedMethod mockedMethod : mockedMethods) {
			if (mockedMethod.doMethodSignaturesAndParametersMatch(methodSignature, args)) {
				return mockedMethod.handleCall();
			}
		}

		// If no matching MockedMethod is found, this exception is thrown.
		throw new Stub.StubException(
			methodName +
				' was called on a Stubbed version of ' +
				this.objectType.toString() +
				' but no mocked method matched it\'s signature and parameter' +
				' values.' +
				' Known mocks include:  ' +
				this.mockedMethods +
				' However the parameter types of this call are: ' +
				paramTypes +
				' and the parameter values of this call are: ' +
				args
		);
	}

	/**
	 * @description Useful for asserting the methods you mocked were, in fact,
	 * called. It does this by invoking the assertMockedMethodWasCalled on each
	 * individual mocked method.
	 */
	public void assertAllMockedMethodsWereCalled() {
		for (MockedMethod mockedMethod : mockedMethods) {
			mockedMethod.assertMockedMethodWasCalled();
		}
	}

	/**
	 * @description returns the this constructed class with it's mocked methods as a single stub object to be used in a
	 * unit test.
	 *
	 * @return `Object` Needs to be cast back to the type of object used.
	 */
	public Object createStub() {
		return Test.createStub(objectType, this);
	}

	/**
	 * @description Class is used by Stub, MethodSignature and MockedMethod
	 * classes for throwing when an exception occurs that is specifically
	 * related to building, using or asserting against the Super Stub framework
	 */
	public class StubException extends Exception {
	}
}
