@IsTest
private class ParameterMatcherTest {
    
    private class TestClass {
        public String methodWithParameters(String param1, Integer param2) {
            return param1 + String.valueOf(param2);
        }
    }
    
    @IsTest
    static void testAnyParameterMatcher() {
        // Arrange
        TestClass mockObject = (TestClass) new Stub.Builder(TestClass.class)
            .mockingMethodCall('methodWithParameters')
            .withParameterTypes(String.class, Integer.class)
            .withParameterValues('testValue', ParameterMatcher.ANY)
            .returning('mocked result')
            .defineStub(true);
        
        // Act
        String result1 = mockObject.methodWithParameters('testValue', 42);
        String result2 = mockObject.methodWithParameters('testValue', 999);
        
        // Assert
        Assert.areEqual('mocked result', result1, 'Should return mocked result with any second parameter (42)');
        Assert.areEqual('mocked result', result2, 'Should return mocked result with any second parameter (999)');
    }
    
    @IsTest
    static void testMultipleAnyParameterMatchers() {
        // Arrange
        TestClass mockObject = (TestClass) new Stub.Builder(TestClass.class)
            .mockingMethodCall('methodWithParameters')
            .withParameterTypes(String.class, Integer.class)
            .withParameterValues(ParameterMatcher.ANY, ParameterMatcher.ANY)
            .returning('any params result')
            .defineStub(true);
        
        // Act
        String result1 = mockObject.methodWithParameters('value1', 42);
        String result2 = mockObject.methodWithParameters('value2', 999);
        
        // Assert
        Assert.areEqual('any params result', result1, 'Should return mocked result with any parameters (1)');
        Assert.areEqual('any params result', result2, 'Should return mocked result with any parameters (2)');
    }
    
    @IsTest
    static void testMixedExactAndAnyMatchers() {
        // Arrange
        TestClass mockObject = (TestClass) new Stub.Builder(TestClass.class)
            // First stub with exact first parameter and ANY second parameter
            .mockingMethodCall('methodWithParameters')
            .withParameterTypes(String.class, Integer.class)
            .withParameterValues('exact', ParameterMatcher.ANY)
            .returning('exact first, any second')
            // Second stub with ANY first parameter and exact second parameter
            .mockingMethodCall('methodWithParameters')
            .withParameterTypes(String.class, Integer.class)
            .withParameterValues(ParameterMatcher.ANY, 42)
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