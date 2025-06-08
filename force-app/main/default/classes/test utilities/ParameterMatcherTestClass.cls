/**
 * @description This class is used to test the ParameterMatcher class.
 */
@IsTest
public class ParameterMatcherTestClass {
	public String methodWithParameters(String param1, Integer param2) {
		return param1 + String.valueOf(param2);
	}
}
