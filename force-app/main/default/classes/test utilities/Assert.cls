/**
 * @description Assert class 'shadows' the System.Assert class allowing us to add custom assertion methods accessed
 * via the static Assert.* methods. This allows us to add custom assertion methods that are more readable and provide
 * more flexibility and functionality than the standard System.Assert methods. Ultimately the goal is to provide
 * end-developers with a more readable and flexible way to write assertions.
 */
@SuppressWarnings('PMD.ExcessivePublicCount, PMD.ExcessiveParameterList')
public with sharing class Assert {
	/**
	 * @description Look, this is a quasi inside joke method. If you have to ask if it's janky, it is. For more
	 * information, ask @jeffKrantz over on SFDC Discord.
	 *
	 * @param msg String the message you want in your failure response.
	 */
	public static void isNotJanky(String msg) {
		System.Assert.fail(msg);
	}

	/**
	 * @description An assertion that validates a list is at least a certain size
	 *
	 * @param collection List<Object> - the list to validate
	 * @param minSize Integer - the minimum size the list must be
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void listMeetsMinimumSize(
		List<Object> collection,
		Integer minSize,
		String msg
	) {
		System.Assert.isTrue(collection.size() >= minSize, msg);
	}

	/**
	 * @description An assertion that validates a string is deserializable to untyped JSON
	 *
	 * @param jsonString String - the string to validate
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void stringIsDeserializableAsUntypedJson(
		String jsonString,
		String msg
	) {
		System.Assert.isNotNull(JSON.deserializeUntyped(jsonString), msg);
	}

	/**
	 * @description An assertion to validate that the object is an SObject
	 *
	 * @param obj Object - the object to validate
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void isSObject(Object obj, String msg) {
		System.Assert.isInstanceOfType(obj, SObject.class, msg);
	}

	/**
	 * @description An assertion to validate that the exception is of the expected type
	 *
	 * @param incomingException Exception - the exception to validate
	 * @param expectedExceptionType Type - the expected type of the exception
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void caughtExpectedException(
		Exception incomingException,
		Type expectedExceptionType,
		String msg
	) {
		System.Assert.isInstanceOfType(
			incomingException,
			expectedExceptionType,
			msg
		);
	}

	/**
	 * @description An assertion to validate that the exception is of the expected type and contains the expected
	 * message
	 *
	 * @param incomingException Exception - the exception to validate
	 * @param expectedExceptionType Type - the expected type of the exception
	 * @param expectedExceptionMessage String - A string that must exist in the resulting exception message
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void caughtExpectedException(
		Exception incomingException,
		Type expectedExceptionType,
		String expectedExceptionMessage,
		String msg
	) {
		System.Assert.isInstanceOfType(
			incomingException,
			expectedExceptionType,
			msg
		);
		System.Assert.isTrue(
			incomingException.getMessage()
				.containsIgnoreCase(expectedExceptionMessage),
			msg
		);
	}

	/**
	 * @description An assertion that validates the given value is within a given range
	 *
	 * @param value Integer - the value to validate
	 * @param min Integer - the minimum value the value must be
	 * @param max Integer - the maximum value the value must be
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void isInRange(
		Integer value,
		Integer min,
		Integer max,
		String msg
	) {
		System.Assert.isTrue(value >= min && value <= max, msg);
	}

	/**
	 * @description An Assertion that validates that LogEvent__c records were generated.
	 * Note: this relies on the Log class that's part of ApexKit
	 *
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void logsWereGenerated(String msg) {
		Integer logEvents = [
			SELECT COUNT()
			FROM LogEvent__c
			WITH SYSTEM_MODE
		];
		System.Assert.isTrue(logEvents > 0, msg);
	}

	/**
	 * @description An assertion that validates that LogEvent__c records were generated.
	 * Note this relies on the Log class that's part of ApexKit. This method override accepts no parameters
	 * but delegates to the variant above by specifying a default message.
	 */
	public static void logsWereGenerated() {
		logsWereGenerated(
			'Though expected, no log events were generated - if youre not using test.StopTest the events will never publish'
		);
	}

	////////////////////// PASSTHROUGH TO SYSTEM.ASSERT //////////////////////
	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param expected Object expected value
	 * @param actual Object actual value
	 * @param msg String message to display if the assertion fails
	 */
	public static void areEqual(Object expected, Object actual, String msg) {
		System.Assert.areEqual(expected, actual, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param expected Object expected value
	 * @param actual Object actual value
	 */
	public static void areEqual(Object expected, Object actual) {
		System.Assert.areEqual(expected, actual);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param notExpected Object not expected value
	 * @param actual Object actual value
	 * @param msg String message to display if the assertion fails
	 */
	public static void areNotEqual(
		Object notExpected,
		Object actual,
		String msg
	) {
		System.Assert.areNotEqual(notExpected, actual, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param notExpected Object not expected value
	 * @param actual Object actual value
	 */
	public static void areNotEqual(Object notExpected, Object actual) {
		System.Assert.areNotEqual(notExpected, actual);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param msg String message to display
	 */
	public static void fail(String msg) {
		System.Assert.fail(msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 */
	public static void fail() {
		System.Assert.fail();
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param condition Boolean condition to evaluate
	 * @param msg String message to display if the assertion fails
	 */
	public static void isFalse(Boolean condition, String msg) {
		System.Assert.isFalse(condition, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param condition Boolean condition to evaluate
	 */
	public static void isFalse(Boolean condition) {
		System.Assert.isFalse(condition);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param instance Object instance to evaluate
	 * @param expectedType Type expected type
	 * @param msg String message to display if the assertion fails
	 */
	public static void isInstanceOfType(
		Object instance,
		System.Type expectedType,
		String msg
	) {
		System.Assert.isInstanceOfType(instance, expectedType, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param instance Object instance to evaluate
	 * @param expectedType Type expected type
	 */
	public static void isInstanceOfType(
		Object instance,
		System.Type expectedType
	) {
		System.Assert.isInstanceOfType(instance, expectedType);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param instance Object instance to evaluate
	 * @param notExpectedType Object not expected type
	 * @param msg String message to display if the assertion fails
	 */
	public static void isNotInstanceOfType(
		Object instance,
		System.Type notExpectedType,
		String msg
	) {
		System.Assert.isNotInstanceOfType(instance, notExpectedType, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param instance Object instance to evaluate
	 * @param notExpectedType Object not expected type
	 */
	public static void isNotInstanceOfType(
		Object instance,
		System.Type notExpectedType
	) {
		System.Assert.isNotInstanceOfType(instance, notExpectedType);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param value Object value to evaluate
	 * @param msg String message to display if the assertion fails
	 */
	public static void isNotNull(Object value, String msg) {
		System.Assert.isNotNull(value, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param value Object value to evaluate
	 */
	public static void isNotNull(Object value) {
		System.Assert.isNotNull(value);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param value Object value to evaluate
	 * @param msg String message to display if the assertion fails
	 */
	public static void isNull(Object value, String msg) {
		System.Assert.isNull(value, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param value Object value to evaluate
	 */
	public static void isNull(Object value) {
		System.Assert.isNull(value);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param condition Boolean condition to evaluate
	 * @param msg String message to display if the assertion fails
	 */
	public static void isTrue(Boolean condition, String msg) {
		System.Assert.isTrue(condition, msg);
	}

	/**
	 * @description Passthrough method to the default system assert class
	 *
	 * @param condition Boolean condition to evaluate
	 */
	public static void isTrue(Boolean condition) {
		System.Assert.isTrue(condition);
	}
}
