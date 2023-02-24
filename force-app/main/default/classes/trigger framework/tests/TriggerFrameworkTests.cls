@isTest
@testVisible
private class TriggerFrameworkTests {
	private static final String TRIGGER_CONTEXT_ERROR = 'Trigger handler called outside of Trigger execution';

	private static String lastMethodCalled;

	private static TriggerFrameworkTests.TestHandler handler;

	static {
		handler = new TriggerFrameworkTests.TestHandler();
		// override its internal trigger detection
		handler.triggerContext.isTriggerBeingTested = true;
	}

	/***************************************
	 * unit tests
	 ***************************************/

	// contexts tests

	/**
	 * @description Tests the BeforeInsert method is properly brokered.
	 */
	@isTest
	private static void testBeforeInsert() {
		beforeInsertMode();
		handler.run();
		Assert.areEqual(
			'beforeInsert',
			lastMethodCalled,
			'Last method should be beforeInsert'
		);
	}

	@isTest
	private static void testBeforeUpdate() {
		beforeUpdateMode();
		handler.run();
		Assert.areEqual(
			'beforeUpdate',
			lastMethodCalled,
			'Last method should be beforeUpdate'
		);
	}

	@isTest
	private static void testBeforeDelete() {
		beforeDeleteMode();
		handler.run();
		Assert.areEqual(
			'beforeDelete',
			lastMethodCalled,
			'Last method should be beforeDelete'
		);
	}

	@isTest
	private static void testAfterInsert() {
		afterInsertMode();
		handler.run();
		Assert.areEqual(
			'afterInsert',
			lastMethodCalled,
			'Last method should be afterInsert'
		);
	}

	@isTest
	private static void testAfterUpdate() {
		afterUpdateMode();
		handler.run();
		Assert.areEqual(
			'afterUpdate',
			lastMethodCalled,
			'Last method should be afterUpdate'
		);
	}

	@isTest
	private static void testAfterDelete() {
		afterDeleteMode();
		handler.run();
		Assert.areEqual(
			'afterDelete',
			lastMethodCalled,
			'Last method should be afterDelete'
		);
	}

	@isTest
	private static void testAfterUndelete() {
		afterUndeleteMode();
		handler.run();
		Assert.areEqual(
			'afterUndelete',
			lastMethodCalled,
			'Last method should be afterUndelete'
		);
	}

	@isTest
	private static void testNonTriggerContext() {
		try {
			handler.run();
			Assert.isTrue(false, 'The handler ran but should have thrown');
		} catch (TriggerFrameworkException te) {
			Assert.areEqual(
				TRIGGER_CONTEXT_ERROR,
				te.getMessage(),
				'The exception message should match'
			);
		} catch (Exception e) {
			Assert.isTrue(
				false,
				'The exception thrown was not expected: ' +
					e.getTypeName() +
					': ' +
					e.getMessage()
			);
		}
	}

	// test bypass api

	@isTest
	private static void testBypassAPI() {
		afterUpdateMode();

		// test a bypass and run handler
		TriggerFramework.bypass('TriggerFrameworkTests.TestHandler');
		handler.run();
		Assert.areEqual(
			null,
			lastMethodCalled,
			'Last method should be null when bypassed'
		);
		Assert.areEqual(
			true,
			TriggerFramework.isBypassed('TriggerFrameworkTests.TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// clear that bypass and run handler
		TriggerFramework.clearBypass('TriggerFrameworkTests.TestHandler');
		handler.run();
		Assert.areEqual(
			'afterUpdate',
			lastMethodCalled,
			'Last method called should be afterUpdate'
		);
		Assert.areEqual(
			false,
			TriggerFramework.isBypassed('TriggerFrameworkTests.TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// test a re-bypass and run handler
		TriggerFramework.bypass('TriggerFrameworkTests.TestHandler');
		handler.run();
		Assert.areEqual(
			null,
			lastMethodCalled,
			'Last method should be null when bypassed'
		);
		Assert.areEqual(
			true,
			TriggerFramework.isBypassed('TriggerFrameworkTests.TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// clear all bypasses and run handler
		TriggerFramework.clearAllBypasses();
		handler.run();
		Assert.areEqual(
			'afterUpdate',
			lastMethodCalled,
			'Last method called should be afterUpdate'
		);
		Assert.areEqual(
			false,
			TriggerFramework.isBypassed('TriggerFrameworkTests.TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();
	}

	// instance method tests

	@isTest
	private static void testLoopCount() {
		beforeInsertMode();

		// set the max loops to 2
		handler.setMaxLoopCount(2);

		// run the handler twice
		handler.run();
		handler.run();

		// clear the tests
		resetTest();

		try {
			// try running it. This should exceed the limit.
			handler.run();
			Assert.isTrue(
				false,
				'The handler should throw on the 3rd run when maxloopcount is 3'
			);
		} catch (TriggerFrameworkException te) {
			// we're expecting to get here
			Assert.areEqual(
				null,
				lastMethodCalled,
				'Last method should be null'
			);
		} catch (Exception e) {
			Assert.isTrue(
				false,
				'The exception thrown was not expected: ' +
					e.getTypeName() +
					': ' +
					e.getMessage()
			);
		}

		// clear the tests
		resetTest();

		// now clear the loop count
		handler.clearMaxLoopCount();

		try {
			// re-run the handler. We shouldn't throw now.
			handler.run();
			Assert.areEqual(
				'beforeInsert',
				lastMethodCalled,
				'Last method should be beforeInsert'
			);
		} catch (TriggerFrameworkException te) {
			Assert.isTrue(
				false,
				'Running the handler after clearing the loop count should not throw'
			);
		} catch (Exception e) {
			Assert.isTrue(
				false,
				'The exception thrown was not expected: ' +
					e.getTypeName() +
					': ' +
					e.getMessage()
			);
		}
	}

	@isTest
	private static void testLoopCountClass() {
		TriggerFrameworkLoopCount lc = new TriggerFrameworkLoopCount();
		Assert.areEqual(5, lc.getMax(), 'Max should be five on init');
		Assert.areEqual(0, lc.getCount(), 'Count should be zero on init');

		lc.increment();
		Assert.areEqual(1, lc.getCount(), 'Count should be 1');
		Assert.areEqual(
			false,
			lc.exceeded(),
			'Should not be exceeded with count of 1'
		);

		lc.increment();
		lc.increment();
		lc.increment();
		lc.increment();
		Assert.areEqual(5, lc.getCount(), 'Count should be 5');
		Assert.areEqual(
			false,
			lc.exceeded(),
			'Should not be exceeded with count of 5'
		);

		lc.increment();
		Assert.areEqual(6, lc.getCount(), 'Count should be 6');
		Assert.areEqual(
			true,
			lc.exceeded(),
			'Should not be exceeded with count of 6'
		);
	}

	// private method tests

	@isTest
	private static void testGetHandlerName() {
		Assert.isTrue(
			handler.getHandlerName().containsIgnoreCase('testHandler'),
			'Handler name should match class name'
		);
	}

	// test virtual methods

	@isTest
	private static void testVirtualMethods() {
		TriggerFramework h = new TriggerFramework();
		h.beforeInsert();
		h.beforeUpdate();
		h.beforeDelete();
		h.afterInsert();
		h.afterUpdate();
		h.afterDelete();
		h.afterUndelete();
		Assert.isTrue(
			true,
			'Expected all of these methods to have executed without throwing an exception during tests.'
		);
	}

	/***************************************
	 * testing utilities
	 ***************************************/

	/**
	 * @description Resets the test
	 */
	private static void resetTest() {
		lastMethodCalled = null;
	}

	// modes for testing

	private static void beforeInsertMode() {
		handler.triggerContext.setTriggerContext('before insert', true);
	}

	private static void beforeUpdateMode() {
		handler.triggerContext.setTriggerContext('before update', true);
	}

	private static void beforeDeleteMode() {
		handler.triggerContext.setTriggerContext('before delete', true);
	}

	private static void afterInsertMode() {
		handler.triggerContext.setTriggerContext('after insert', true);
	}

	private static void afterUpdateMode() {
		handler.triggerContext.setTriggerContext('after update', true);
	}

	private static void afterDeleteMode() {
		handler.triggerContext.setTriggerContext('after delete', true);
	}

	private static void afterUndeleteMode() {
		handler.triggerContext.setTriggerContext('after undelete', true);
	}

	/**
	 * test implementation of the TriggerHandler
	 */
	@testVisible
	private class TestHandler extends TriggerFramework {
		public override void beforeInsert() {
			TriggerFrameworkTests.lastMethodCalled = 'beforeInsert';
		}

		public override void beforeUpdate() {
			TriggerFrameworkTests.lastMethodCalled = 'beforeUpdate';
		}

		public override void beforeDelete() {
			TriggerFrameworkTests.lastMethodCalled = 'beforeDelete';
		}

		public override void afterInsert() {
			TriggerFrameworkTests.lastMethodCalled = 'afterInsert';
		}

		public override void afterUpdate() {
			TriggerFrameworkTests.lastMethodCalled = 'afterUpdate';
		}

		public override void afterDelete() {
			TriggerFrameworkTests.lastMethodCalled = 'afterDelete';
		}

		public override void afterUndelete() {
			TriggerFrameworkTests.lastMethodCalled = 'afterUndelete';
		}
	}
}