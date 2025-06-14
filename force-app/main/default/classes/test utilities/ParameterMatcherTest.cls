@IsTest
private class ParameterMatcherTest {
	@IsTest
	static void testAnyParameterMatcher() {
		// Arrange
		ParameterMatcherTestClass mockObject = (ParameterMatcherTestClass) new Stub.Builder(
				ParameterMatcherTestClass.class
			)
			.mockingMethodCall('methodWithParameters')
			.withParameterTypes(String.class, Integer.class)
			.withParameterValues('testValue', ParameterMatcher.ANYVALUE)
			.returning('mocked result')
			.defineStub(true);

		// Act
		String result1 = mockObject.methodWithParameters('testValue', 42);
		String result2 = mockObject.methodWithParameters('testValue', 999);

		// Assert
		Assert.areEqual(
			'mocked result',
			result1,
			'Should return mocked result with any second parameter (42)'
		);
		Assert.areEqual(
			'mocked result',
			result2,
			'Should return mocked result with any second parameter (999)'
		);
	}

	@IsTest
	static void testMultipleAnyParameterMatchers() {
		// Arrange
		ParameterMatcherTestClass mockObject = (ParameterMatcherTestClass) new Stub.Builder(
				ParameterMatcherTestClass.class
			)
			.mockingMethodCall('methodWithParameters')
			.withParameterTypes(String.class, Integer.class)
			.withParameterValues(ParameterMatcher.ANYVALUE, ParameterMatcher.ANYVALUE)
			.returning('any params result')
			.defineStub(true);

		// Act
		String result1 = mockObject.methodWithParameters('value1', 42);
		String result2 = mockObject.methodWithParameters('value2', 999);

		// Assert
		Assert.areEqual(
			'any params result',
			result1,
			'Should return mocked result with any parameters (1)'
		);
		Assert.areEqual(
			'any params result',
			result2,
			'Should return mocked result with any parameters (2)'
		);
	}

	@IsTest
	static void testMixedExactAndAnyMatchers() {
		// Arrange
		ParameterMatcherTestClass mockObject = (ParameterMatcherTestClass) new Stub.Builder(
				ParameterMatcherTestClass.class
			)
			// First stub with exact first parameter and ANY second parameter
			.mockingMethodCall('methodWithParameters')
			.withParameterTypes(String.class, Integer.class)
			.withParameterValues('exact', ParameterMatcher.ANYVALUE)
			.returning('exact first, any second')
			// Second stub with ANY first parameter and exact second parameter
			.mockingMethodCall('methodWithParameters')
			.withParameterTypes(String.class, Integer.class)
			.withParameterValues(ParameterMatcher.ANYVALUE, 42)
			.returning('any first, exact second')
			.defineStub(true);

		// Act & Assert
		Assert.areEqual(
			'exact first, any second',
			mockObject.methodWithParameters('exact', 999),
			'Should match first stub with exact first parameter'
		);

		Assert.areEqual(
			'any first, exact second',
			mockObject.methodWithParameters('different', 42),
			'Should match second stub with exact second parameter'
		);
	}
}
