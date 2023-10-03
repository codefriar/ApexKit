@IsTest
private class QueueableProcessTests {
	@TestSetup
	private static void setup() {
		Account testAccount = new Account(
			Name = 'Test Account',
			ShippingStreet = '0'
		);
		insert testAccount;
	}

	@IsTest
	private static void testBasicE2EProcessPositive() {
		Account testAccount = getTestAccount();
		Test.startTest();
		fireQueueableProcess(testAccount);
		Test.stopTest();
		Account checkAccount = getTestAccount();
		Assert.areEqual(
			3,
			Integer.valueOf(checkAccount.ShippingStreet),
			'Expected to find the ShippingStreet field updated to 3'
		);
		Assert.areEqual(
			3,
			Integer.valueOf(checkAccount.BillingStreet),
			'Expected to find the BillingStreet field updated to 2'
		);
	}

	@IsTest
	private static void testBasicE2EProcessPositiveNoInput() {
		Account testAccount = getTestAccount();
		Test.startTest();
		fireQueueableProcess(testAccount);
		Test.stopTest();
		Account checkAccount = getTestAccount();
		Assert.areEqual(
			3,
			Integer.valueOf(checkAccount.ShippingStreet),
			'Expected to find the ShippingStreet field updated to 3'
		);
	}

	private static void fireQueueableProcess(Account testAccount) {
		QueueableProcess queueableProcess = new ExampleQueueableProcessSteps.Step1(
			testAccount.Id
		);
		queueableProcess
			.then(new ExampleQueueableProcessSteps.Step1(testAccount.Id))
			.then(new ExampleQueueableProcessSteps.Step1(testAccount.Id))
			.then(new ExampleQueueableProcessSteps.Step2(testAccount.Id))
			.then(new ExampleQueueableProcessSteps.Step2(testAccount.Id))
			.start(0);
	}

	@IsTest
	private static void testFinalizerHandlesUnhandledExceptionPositiveFailsafeHandlerCalled() {
		Account acct = getTestAccount();
		List<QueueableProcess> processSteps = new List<QueueableProcess>{
			new ExampleQueueableProcessSteps.Step1(acct.Id),
			new ExampleQueueableProcessSteps.Step2(acct.Id)
		};
		EnqueueNextQueueableProcessStep finalizer = new EnqueueNextQueueableProcessStep(
			processSteps,
			null,
			new List<QueueableContext>(),
			new List<FinalizerContext>()
		);
		Test.startTest();
		finalizer.execute(
			new MockFinalizerContext(ParentJobResult.UNHANDLED_EXCEPTION)
		);
		Test.stopTest();
		List<LogEvent__c> logEvents = [
			SELECT Id, Log_Data__c, Severity__c
			FROM LogEvent__c
		];
		Assert.areEqual(2, logEvents.size(), 'Expected to find 2 log events');
	}

	@IsTest
	private static void testFinalizerHandlesUnhandledExceptionPositiveDefaultHandler() {
		Account acct = getTestAccount();
		List<QueueableProcess> processSteps = new List<QueueableProcess>{
			new ExampleQueueableProcessSteps.Step2(acct.Id),
			new ExampleQueueableProcessSteps.Step2(acct.Id)
		};
		EnqueueNextQueueableProcessStep finalizer = new EnqueueNextQueueableProcessStep(
			processSteps,
			null,
			new List<QueueableContext>(),
			new List<FinalizerContext>()
		);

		finalizer.dataProvider = (QueueableProcessDataProvider) Test.createStub(
			QueueableProcessDataProvider.class,
			new QueueableProcessMockDataProvider(
				'ExampleQueueableProcessSteps.Step2'
			)
		);

		Test.startTest();
		finalizer.execute(
			new MockFinalizerContext(ParentJobResult.UNHANDLED_EXCEPTION)
		);
		Test.stopTest();
		Assert.isTrue(
			QueueableProcess.defaultHandleExceptionCalled,
			'Expected to fire handleException'
		);
	}

	@IsTest
	private static void testFinalizerHandlesUnhandledExceptionPositiveCustomHandler() {
		Account acct = getTestAccount();
		List<QueueableProcess> processSteps = new List<QueueableProcess>{
			new ExampleQueueableProcessSteps.Step1(acct.Id),
			new ExampleQueueableProcessSteps.Step2(acct.Id)
		};
		EnqueueNextQueueableProcessStep finalizer = new EnqueueNextQueueableProcessStep(
			processSteps,
			null,
			new List<QueueableContext>(),
			new List<FinalizerContext>()
		);

		finalizer.dataProvider = (QueueableProcessDataProvider) Test.createStub(
			QueueableProcessDataProvider.class,
			new QueueableProcessMockDataProvider(
				'ExampleQueueableProcessSteps.Step1'
			)
		);

		Test.startTest();
		finalizer.execute(
			new MockFinalizerContext(ParentJobResult.UNHANDLED_EXCEPTION)
		);
		Test.stopTest();
		Assert.isTrue(
			ExampleQueueableProcessSteps.handleExceptionCalled,
			'Expected to fire handleException'
		);
	}

	// private helper methods
	private static Account getTestAccount() {
		return [
			SELECT Id, Name, ShippingStreet, BillingStreet
			FROM Account
			WHERE Name = 'Test Account'
		];
	}

	/**
	 * @description This class is used to mock the FinalizerContext variable dependency injected by SF into the
	 * execute method. This allows us to mock a failure in the preceeding QueueableProcess and test the finalizer's
	 * behavior.
	 */
	class MockFinalizerContext implements System.FinalizerContext {
		final ParentJobResult result;
		public Id getAsyncApexJobId() {
			// valid Id, or query one
			return IdFactory.get('AsyncApexJob');
		}
		public Exception getException() {
			return new System.AsyncException('heap breached');
		}
		public String getRequestId() {
			return 'someRequestId';
		}
		public ParentJobResult getResult() {
			return this.result;
		}
		MockFinalizerContext(ParentJobResult mockResult) {
			this.result = mockResult;
		}
	}
}
