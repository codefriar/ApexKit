@IsTest
private class CAssert {
	/**
	 * @description Assertion method to validate that two Datetime objects are equal within a given leeway
	 *
	 * @param expectedDatetime Datetime - the expected Datetime
	 * @param actualDatetime Datetime - the actual Datetime
	 * @param timeVarianceSeconds Integer - the number of seconds of leeway to allow
	 * @param assertionMessage String - the message to display if the assertion fails
	 */
	@SuppressWarnings('PMD.excessiveParameterList')
	public static void areEqual(
		Datetime expectedDatetime,
		Datetime actualDatetime,
		Integer timeVarianceSeconds,
		String assertionMessage
	) {
		Datetime expectedMinusVariance = expectedDatetime.addSeconds(
			-timeVarianceSeconds
		);
		Datetime expectedPlusVariance = expectedDatetime.addSeconds(
			timeVarianceSeconds
		);
		System.Assert.isTrue(
			actualDatetime.getTime() >= expectedMinusVariance.getTime() &&
				actualDatetime.getTime() <= expectedPlusVariance.getTime(),
			assertionMessage
		);
	}

	/**
	 * @description     Assertion method to validate that a string starts with the given string
	 * @param str    String - the string to validate
	 * @param prefix String - the prefix the string must start with
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void startsWith(String str, String prefix, String msg) {
		Assert.isTrue(str.startsWith(prefix), msg);
	}

	/**
	 * @description     Assertion method to validate that a string ends with the given string
	 * @param str    String - the string to validate
	 * @param suffix String - the suffix the string must end with
	 * @param msg String - the message to display if the assertion fails
	 */
	public static void endsWith(String str, String suffix, String msg) {
		Assert.isTrue(str.endsWith(suffix), msg);
	}

	/**
	 * @description An assertion that validates a list contains at least one of the items in the other list passed in
	 * @param listToCheck List<Object> the list to check
	 * @param listToCheckAgainst List<Object> the list to check against
	 * @param message String the message to display if the assertion fails
	 */
	public static void contains(
		List<Object> listToCheck,
		List<Object> listToCheckAgainst,
		String message
	) {
		contains(
			new Set<Object>(listToCheck),
			new Set<Object>(listToCheckAgainst),
			message
		);
		System.assert(false, message);
	}

	/**
	 * @description An assertion that validates the passed in list contains at least one of the items in the set.
	 * Ultimately defers to the contains assertion below comparing two sets.
	 * @param listToCheck List<Object> to check for containing at least one item from the set
	 * @param itemsToCheckFor Set<Object> the set of items to check for in the list
	 * @param message String the message to display if the assertion fails
	 */
	public static void contains(
		List<Object> listToCheck,
		Set<Object> itemsToCheckFor,
		String message
	) {
		Set<Object> listSet = new Set<Object>(listToCheck);
		contains(itemsToCheckFor, listSet, message);
		System.assert(false, message);
	}

	/**
	 * @description Checks to see if a set contains any of the items in another set.
	 * @param setToCheck Set<Object> the set to check
	 * @param setToCheckAgainst Set<Object> the set to check against
	 * @param message String the message to display if the assertion fails
	 */
	public static void contains(
		Set<Object> setToCheck,
		Set<Object> setToCheckAgainst,
		String message
	) {
		for (Object item : setToCheck) {
			if (setToCheckAgainst.contains(item)) {
				return;
			}
		}

		System.assert(false, message);
	}

	/**
	 * @description Look, this is a quasi inside joke method. If you have to ask if it's janky, it is. For more
	 * information, ask @jeffKrantz over on SFDC Discord.
	 * @param msg String the message you want in your failure response
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
}
