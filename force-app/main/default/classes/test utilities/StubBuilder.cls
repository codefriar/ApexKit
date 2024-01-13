/**
 * @description Builder pattern for creating stubs with a fluent interface.
 * Note, there are three 'Builder' classes, each an inner class of the object that the builder builds. In this case,
 * this builder inner class is responsible for building Stub objects.
 *
 * While you can directly instantiate the Stub class, the idea is that you will actually use the Builder
 * class/interface to create Stubs
 *
 * @see Stub
 */
@IsTest
public class StubBuilder {
	/**
	 * @description holds the System.Type reference for the object that
	 * you're building a stub for.
	 */
	private final Type objectType;

	/**
	 * @description Internally, we need to maintain a list of signature
	 * builder objects so that we can roll-up the creation of objects.
	 */
	final List<MethodSignature.Builder> signatureBuilders = new List<MethodSignature.Builder>();

	/**
	 * @description Constructor requiring the objectType. We do that to
	 * enforce that all Stub builders have an object type.
	 *
	 * @param objType Type class: ie. Foo.class
	 */
	public StubBuilder(Type objType) {
		this.objectType = objType;
	}

	/**
	 * @description This method, and it's overloaded variants below,
	 * all work to add a new MockedMethod to the stub object. Semantically
	 * the idea is that you'll invoke one of these 'mockingMethodCall'
	 * methods for every method you want your stub to react to. Because this
	 * builder class is designed around method chaining, you can invoke a
	 * number of these in a row. See the example invocation at the top of
	 * this class.
	 *
	 * @param methodName Required, name of the method that will be mocked
	 * @param paramTypes List of System.Types that the mocked method should
	 * respond to.
	 *
	 * @return `MethodSignature.Builder` - returns the builder
	 * object for chaining.
	 */
	public MethodSignature.Builder mockingMethodCall(String methodName, List<Type> paramTypes) {
		MethodSignature.Builder constructedSignature = new MethodSignature.Builder(this, methodName, paramTypes);
		signatureBuilders.add(constructedSignature);
		return constructedSignature;
	}

	/**
	 * @description Overloaded variant of the main 'mockingMethodCall'
	 * method. See docs for the first instance of mockingMethodCall in this
	 * class.
	 *
	 * @param methodName Method name to be mocked.
	 *
	 * @return `MethodSignature.Builder`
	 */
	public MethodSignature.Builder mockingMethodCall(String methodName) {
		return mockingMethodCall(methodName, new List<Type>());
	}

	/**
	 * @description Overloaded variant of the main 'mockingMethodCall'
	 * method. See docs for the first instance of mockingMethodCall in this
	 * class.
	 *
	 * @param methodName required. method name to be mocked.
	 * @param paramType Type of single parameter.
	 *
	 * @return `MethodSignature.Builder`
	 */
	public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType) {
		return mockingMethodCall(methodName, new List<Type>{ paramType }).withParameterTypes();
	}

	/**
	 * @description Overloaded variant of the main 'mockingMethodCall'
	 * method. See docs for the first instance of mockingMethodCall in this
	 * class.
	 *
	 * @param methodName required. method name to be mocked.
	 * @param paramType param type 1.
	 * @param paramType2 param type 2.
	 *
	 * @return `MethodSignature.Builder`
	 */
	public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType, Type paramType2) {
		return mockingMethodCall(methodName, new List<Type>{ paramType, paramType2 }).withParameterTypes();
	}

	/**
	 * @description Overloaded variant of the main 'mockingMethodCall'
	 * method. See docs for the first instance of mockingMethodCall in this
	 * class.
	 *
	 * @param methodName required. method name to be mocked.
	 * @param paramType param type 1.
	 * @param paramType2 param type 2.
	 * @param paramType3 param type 3.
	 *
	 * @return `MethodSignature.Builder`
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3) {
		return mockingMethodCall(methodName, new List<Type>{ paramType, paramType2, paramType3 }).withParameterTypes();
	}

	/**
	 * @description Overloaded variant of the main 'mockingMethodCall'
	 * method. See docs for the first instance of mockingMethodCall in this
	 * class.
	 *
	 * @param methodName required. method name to be mocked.
	 * @param paramType param type 1.
	 * @param paramType2 param type 2.
	 * @param paramType3 param type 3.
	 * @param paramType4 param type 4.
	 *
	 * @return `MethodSignature.Builder`
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public MockedMethod.Builder mockingMethodCall(
		String methodName,
		Type paramType,
		Type paramType2,
		Type paramType3,
		Type paramType4
	) {
		return mockingMethodCall(methodName, new List<Type>{ paramType, paramType2, paramType3, paramType4 })
			.withParameterTypes();
	}

	/**
	 * @description Generates a Stub object from this builder object.
	 *
	 * @param generateInjectableStub true, calls the stub objects' createStub method automatically
	 *
	 * @return `Stub`
	 */
	public Object defineStub(Boolean generateInjectableStub) {
		return this.defineStub().createStub();
	}

	/**
	 * @description Method generates a Stub object from this builder object.
	 *
	 * @return Stub object to be used to mock the object type.
	 */
	public Stub defineStub() {
		List<MockedMethod> mockedMethods = new List<MockedMethod>();
		for (MethodSignature.Builder constructedSignature : signatureBuilders) {
			mockedMethods.addAll(constructedSignature.buildMockedMethod());
		}
		return new Stub(objectType, mockedMethods);
	}
}
