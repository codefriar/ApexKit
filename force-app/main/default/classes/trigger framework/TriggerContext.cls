public with sharing class TriggerContext {
	public TriggerOperation context;
	public Boolean isTriggerBeingTested = false;

	public TriggerContext() {
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
		System.debug(
			'### Is Trigger being Tested? ' + this.isTriggerBeingTested
		);
		System.debug('### Context: ' + this.context);
		if (!this.isTriggerBeingTested || this.context == null) {
			throw new TriggerFrameworkException(
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
			this.context = Trigger.OperationType;
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
		switch on Trigger.OperationType {
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
				throw new TriggerFrameworkException(
					'Unexpected trigger context manually set'
				);
			}
		}
	}
}