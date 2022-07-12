/**
 * @group Trigger Framework
 */
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
	static void testBeforeInsert() {
		beforeInsertMode();
		handler.run();
		System.assertEquals(
			'beforeInsert',
			lastMethodCalled,
			'Last method should be beforeInsert'
		);
	}

	@isTest
	static void testBeforeUpdate() {
		beforeUpdateMode();
		handler.run();
		System.assertEquals(
			'beforeUpdate',
			lastMethodCalled,
			'Last method should be beforeUpdate'
		);
	}

	@isTest
	static void testBeforeDelete() {
		beforeDeleteMode();
		handler.run();
		System.assertEquals(
			'beforeDelete',
			lastMethodCalled,
			'Last method should be beforeDelete'
		);
	}

	@isTest
	static void testAfterInsert() {
		afterInsertMode();
		handler.run();
		System.assertEquals(
			'afterInsert',
			lastMethodCalled,
			'Last method should be afterInsert'
		);
	}

	@isTest
	static void testAfterUpdate() {
		afterUpdateMode();
		handler.run();
		System.assertEquals(
			'afterUpdate',
			lastMethodCalled,
			'Last method should be afterUpdate'
		);
	}

	@isTest
	static void testAfterDelete() {
		afterDeleteMode();
		handler.run();
		System.assertEquals(
			'afterDelete',
			lastMethodCalled,
			'Last method should be afterDelete'
		);
	}

	@isTest
	static void testAfterUndelete() {
		afterUndeleteMode();
		handler.run();
		System.assertEquals(
			'afterUndelete',
			lastMethodCalled,
			'Last method should be afterUndelete'
		);
	}

	@isTest
	static void testNonTriggerContext() {
		try {
			handler.run();
			System.assert(false, 'The handler ran but should have thrown');
		} catch (TriggerFramework.TriggerFrameworkException te) {
			System.assertEquals(
				TRIGGER_CONTEXT_ERROR,
				te.getMessage(),
				'The exception message should match'
			);
		} catch (Exception e) {
			System.assert(
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
	static void testBypassAPI() {
		afterUpdateMode();

		// test a bypass and run handler
		TriggerFramework.bypass('TestHandler');
		handler.run();
		System.assertEquals(
			null,
			lastMethodCalled,
			'Last method should be null when bypassed'
		);
		System.assertEquals(
			true,
			TriggerFramework.isBypassed('TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// clear that bypass and run handler
		TriggerFramework.clearBypass('TestHandler');
		handler.run();
		System.assertEquals(
			'afterUpdate',
			lastMethodCalled,
			'Last method called should be afterUpdate'
		);
		System.assertEquals(
			false,
			TriggerFramework.isBypassed('TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// test a re-bypass and run handler
		TriggerFramework.bypass('TestHandler');
		handler.run();
		System.assertEquals(
			null,
			lastMethodCalled,
			'Last method should be null when bypassed'
		);
		System.assertEquals(
			true,
			TriggerFramework.isBypassed('TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();

		// clear all bypasses and run handler
		TriggerFramework.clearAllBypasses();
		handler.run();
		System.assertEquals(
			'afterUpdate',
			lastMethodCalled,
			'Last method called should be afterUpdate'
		);
		System.assertEquals(
			false,
			TriggerFramework.isBypassed('TestHandler'),
			'Test handler should be bypassed'
		);
		resetTest();
	}

	// instance method tests

	@isTest
	static void testLoopCount() {
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
			System.assert(
				false,
				'The handler should throw on the 3rd run when maxloopcount is 3'
			);
		} catch (TriggerFramework.TriggerFrameworkException te) {
			// we're expecting to get here
			System.assertEquals(null, lastMethodCalled, 'Last method should be null');
		} catch (Exception e) {
			System.assert(
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
			System.assertEquals(
				'beforeInsert',
				lastMethodCalled,
				'Last method should be beforeInsert'
			);
		} catch (TriggerFramework.TriggerFrameworkException te) {
			System.assert(
				false,
				'Running the handler after clearing the loop count should not throw'
			);
		} catch (Exception e) {
			System.assert(
				false,
				'The exception thrown was not expected: ' +
				e.getTypeName() +
				': ' +
				e.getMessage()
			);
		}
	}

	@isTest
	static void testLoopCountClass() {
		TriggerFramework.TriggerFrameworkLoopCount lc = new TriggerFramework.TriggerFrameworkLoopCount();
		System.assertEquals(5, lc.getMax(), 'Max should be five on init');
		System.assertEquals(0, lc.getCount(), 'Count should be zero on init');

		lc.increment();
		System.assertEquals(1, lc.getCount(), 'Count should be 1');
		System.assertEquals(
			false,
			lc.exceeded(),
			'Should not be exceeded with count of 1'
		);

		lc.increment();
		lc.increment();
		lc.increment();
		lc.increment();
		System.assertEquals(5, lc.getCount(), 'Count should be 5');
		System.assertEquals(
			false,
			lc.exceeded(),
			'Should not be exceeded with count of 5'
		);

		lc.increment();
		System.assertEquals(6, lc.getCount(), 'Count should be 6');
		System.assertEquals(
			true,
			lc.exceeded(),
			'Should not be exceeded with count of 6'
		);
	}

	// private method tests

	@isTest
	static void testGetHandlerName() {
		System.assert(
			handler.getHandlerName().containsIgnoreCase('testHandler'),
			'Handler name should match class name'
		);
	}

	// test virtual methods

	@isTest
	static void testVirtualMethods() {
		TriggerFramework h = new TriggerFramework();
		h.beforeInsert();
		h.beforeUpdate();
		h.beforeDelete();
		h.afterInsert();
		h.afterUpdate();
		h.afterDelete();
		h.afterUndelete();
		System.assert(
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

	// test implementation of the TriggerHandler

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