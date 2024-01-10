/**
 * @description A class encapsulating the trigger context. Before/after insert/update/delete etc.
 */
public with sharing class TriggerContext {
	/**
	 * @description the TriggerOperation this context revolves arround
	 */
	public TriggerOperation context;
	/**
	 * @description A boolean override for testing purposes
	 */
	public Boolean isTriggerBeingTested = false;

	/**
	 * @description A default contstructor that sets the context to null and override to false
	 */
	public TriggerContext() {
		this.setTriggerContext(null, false);
	}

	/**
	 * @description make sure this trigger should continue to run
	 *
	 * @return `Boolean` true if the trigger should continue to run
	 *
	 * @throws TriggerFrameworkException thrown when executing outside of a
	 * trigger
	 */
	public Boolean isInvalidExecutionContext() {
		if (!this.isTriggerBeingTested || this.context == null) {
			throw new TriggerFrameworkException('Trigger handler called outside of Trigger execution');
		}

		return false;
	}

	/**
	 * @description Internal method for manually setting the trigger context
	 *
	 * @param overriddenContext The current trigger Context
	 * @param overrideForTesting Is the trigger running in a test context?
	 */
	@TestVisible
	private void setTriggerContext(String overriddenContext, Boolean overrideForTesting) {
		if (!Trigger.isExecuting && !overrideForTesting) {
			this.isTriggerBeingTested = false;
			this.context = Trigger.operationType;
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

	/**
	 * @description A method to set the trigger context during normal system execution.
	 */
	private void setContextDuringNormalExecution() {
		switch on Trigger.operationType {
			when BEFORE_INSERT {
				this.context = TriggerOperation.BEFORE_INSERT;
			}
			when BEFORE_UPDATE {
				this.context = TriggerOperation.BEFORE_UPDATE;
			}
			when BEFORE_DELETE {
				this.context = TriggerOperation.BEFORE_DELETE;
			}
			when AFTER_INSERT {
				this.context = TriggerOperation.AFTER_INSERT;
			}
			when AFTER_UPDATE {
				this.context = TriggerOperation.AFTER_UPDATE;
			}
			when AFTER_DELETE {
				this.context = TriggerOperation.AFTER_DELETE;
			}
			when AFTER_UNDELETE {
				this.context = TriggerOperation.AFTER_UNDELETE;
			}
		}
	}

	/**
	 * @description A private test visible method for manually overriding the context
	 *
	 * @param overriddenContext the context to forcibly set.
	 */
	private void setManuallyOverriddenContext(String overriddenContext) {
		switch on overriddenContext {
			when 'before insert' {
				this.context = TriggerOperation.BEFORE_INSERT;
			}
			when 'before update' {
				this.context = TriggerOperation.BEFORE_UPDATE;
			}
			when 'before delete' {
				this.context = TriggerOperation.BEFORE_DELETE;
			}
			when 'after insert' {
				this.context = TriggerOperation.AFTER_INSERT;
			}
			when 'after update' {
				this.context = TriggerOperation.AFTER_UPDATE;
			}
			when 'after delete' {
				this.context = TriggerOperation.AFTER_DELETE;
			}
			when 'after undelete' {
				this.context = TriggerOperation.AFTER_UNDELETE;
			}
			when else {
				throw new TriggerFrameworkException('Unexpected trigger context manually set');
			}
		}
	}
}
