/**
 * @group Trigger Framework
 */
public with sharing class TriggerContext {
	public validTriggerContexts context;
	public Boolean isTriggerBeingTested = false;

	/**
	 * @description internal method to forcibly set the trigger context
	 */
	@testVisible
	private void setTriggerContext() {
		this.setTriggerContext(null, false);
	}

	/**
	 * @description make sure this trigger should continue to run
	 * @return     `Boolean`
	 * @exception   TriggerHandlerException thrown when executing outside of a
	 * trigger
	 */
	@testVisible
	public Boolean isInvalidExecutionContext() {
		if (!this.isTriggerBeingTested || this.context == null) {
			throw new TriggerFramework.TriggerFrameworkException(
				'Trigger handler called outside of Trigger execution'
			);
		}

		return false;
	}

	/**
	 * @description    Internal method for manually setting the trigger context
	 * @param ctx      The current trigger Context
	 * @param testMode Is the trigger running in a test context?
	 */
	@testVisible
	private void setTriggerContext(
		String overriddenContext,
		Boolean overrideForTesting
	) {
		if (!Trigger.isExecuting && !overrideForTesting) {
			this.isTriggerBeingTested = false;
			return;
		} else {
			this.isTriggerBeingTested = true;
		}

		/**
		 * This block is executed during normal operation.
		 */
		if (Trigger.isExecuting && !overrideForTesting) {
			setContextDuringNormalExecution();
		} else if (overriddenContext != null && overrideForTesting) {
			/**
			 * This block is executed when a test is running.
			 */
			setManuallyOverriddenContext(overriddenContext);
		}
	}

	private void setContextDuringNormalExecution() {
		switch on Trigger.operationType {
			when BEFORE_INSERT {
				this.context = ValidTriggerContexts.BEFORE_INSERT;
			}
			when BEFORE_UPDATE {
				this.context = ValidTriggerContexts.BEFORE_UPDATE;
			}
			when BEFORE_DELETE {
				this.context = ValidTriggerContexts.BEFORE_DELETE;
			}
			when AFTER_INSERT {
				this.context = ValidTriggerContexts.AFTER_INSERT;
			}
			when AFTER_UPDATE {
				this.context = ValidTriggerContexts.AFTER_UPDATE;
			}
			when AFTER_DELETE {
				this.context = ValidTriggerContexts.AFTER_DELETE;
			}
			when AFTER_UNDELETE {
				this.context = ValidTriggerContexts.AFTER_UNDELETE;
			}
		}
	}

	private void setManuallyOverriddenContext(String overriddenContext) {
		switch on overriddenContext {
			when 'before insert' {
				this.context = ValidTriggerContexts.BEFORE_INSERT;
			}
			when 'before update' {
				this.context = ValidTriggerContexts.BEFORE_UPDATE;
			}
			when 'before delete' {
				this.context = ValidTriggerContexts.BEFORE_DELETE;
			}
			when 'after insert' {
				this.context = ValidTriggerContexts.AFTER_INSERT;
			}
			when 'after update' {
				this.context = ValidTriggerContexts.AFTER_UPDATE;
			}
			when 'after delete' {
				this.context = ValidTriggerContexts.AFTER_DELETE;
			}
			when 'after undelete' {
				this.context = ValidTriggerContexts.AFTER_UNDELETE;
			}
			when else {
				throw new TriggerFramework.TriggerFrameworkException(
					'Unexpected trigger context manually set'
				);
			}
		}
	}
	/**
	 * @description possible trigger contexts
	 */
	public enum ValidTriggerContexts {
		BEFORE_INSERT,
		BEFORE_UPDATE,
		BEFORE_DELETE,
		AFTER_INSERT,
		AFTER_UPDATE,
		AFTER_DELETE,
		AFTER_UNDELETE
	}
}