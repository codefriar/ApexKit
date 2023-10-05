@IsTest
private class FailsafeExceptionHandlerTests {
	@IsTest
	static void testDefaultConstructor() {
		Test.startTest();
		FailsafeExceptionHandler handler = new FailsafeExceptionHandler();
		Test.stopTest();
		Assert.isNotNull(handler, 'Handler should not be null');
		Assert.isInstanceOfType(
			handler,
			FailsafeExceptionHandler.class,
			'Handler should be of type FailsafeExceptionHandler'
		);
		Assert.isNotNull(handler.logger, 'Logger should not be null');
	}

	@IsTest
	static void testSingleExceptionConstructor() {
		Test.startTest();
		FailsafeExceptionHandler handler = new FailsafeExceptionHandler(
			new DmlException()
		);
		Test.stopTest();
		Assert.isNotNull(handler, 'Handler should not be null');

		assertLogsGenerated(1, 'when passing a single exception');
	}

	@IsTest
	static void testListExceptionConstructor() {
		Test.startTest();
		List<Exception> theExceptions = new List<Exception>();
		theExceptions.add(new DmlException());
		theExceptions.add(new DmlException());
		FailsafeExceptionHandler handler = new FailsafeExceptionHandler(
			theExceptions
		);
		Test.stopTest();
		Assert.isNotNull(handler, 'Handler should not be null');

		assertLogsGenerated(2, 'when passing a single exception');
	}

	@IsTest
	static void testCallableInterfaceSingleException() {
		FailsafeExceptionHandler handler = new FailsafeExceptionHandler();
		Test.startTest();
		handler.call(
			'handleException',
			new Map<String, Object>{ 'incomingException' => new DmlException() }
		);
		Test.stopTest();
		Assert.isTrue(
			true,
			'Bogus assertion to make pmd happy. Real assertion is in assertLogsGenerated'
		);

		assertLogsGenerated(1, 'when passing a single exception');
	}

	@IsTest
	static void testCallableInterfaceListOfExceptions() {
		FailsafeExceptionHandler handler = new FailsafeExceptionHandler();
		Test.startTest();
		handler.call(
			'handleExceptions',
			new Map<String, Object>{
				'incomingExceptions' => new List<Exception>{
					new DmlException(),
					new DmlException()
				}
			}
		);
		Test.stopTest();
		Assert.isTrue(
			true,
			'Bogus assertion to make pmd happy. Real assertion is in assertLogsGenerated'
		);
		assertLogsGenerated(2, 'when passing a single exception');
	}

	//// Private helpers
	private static void assertLogsGenerated(
		Integer numberOfLogsExpected,
		String friendlyMessage
	) {
		List<LogEvent__c> logEvents = [
			SELECT Id, Log_Data__c, Severity__c
			FROM LogEvent__c
		];
		if (logEvents.size() != numberOfLogsExpected) {
			Assert.fail(
				'Expected ' +
					numberOfLogsExpected +
					' but found ' +
					logEvents.size() +
					' ' +
					friendlyMessage
			);
		}
	}
}
