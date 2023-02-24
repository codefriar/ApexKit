/**
 * @description An opinionated trigger handler framework.
 */
public virtual class TriggerFramework {
	// static map of handlerName, times run() was invoked
	private static Map<String, TriggerFrameworkLoopCount> loopCountMap;
	public static Set<String> bypassedHandlers;

	// the current context of the trigger, override-able in tests
	@testVisible
	protected TriggerContext triggerContext = new TriggerContext();

	// static initialization
	static {
		loopCountMap = new Map<String, TriggerFrameworkLoopCount>();
		bypassedHandlers = new Set<String>();
	}

	// /**
	//  * @description Constructs a trigger handler object and ensures the context
	//  * is set
	//  */
	// public TriggerFramework() {
	//     // triggerContext.setTriggerContext();
	// }

	/**
	 * @description This is main brokering method that is called by the trigger.
	 * It's responsible for determining the proper context, and calling the
	 * correct method
	 * @example
	 * AccountTriggerFramework.run();
	 */
	public virtual void run() {
		if (standardValidationFails()) {
			return;
		}
		dispatchHandlerMethod(this.triggerContext.context);
	}

	protected Boolean standardValidationFails() {
		/**
		 * Guard statements against invalid execution context and a bypassed handlerName
		 */
		if (this.triggerContext.isInvalidExecutionContext()) {
			return true;
		}

		if (TriggerFramework.bypassedHandlers.contains(getHandlerName())) {
			return true;
		}

		addToLoopCount();
		return false;
	}

	private void dispatchHandlerMethod(TriggerOperation context) {
		// dispatch to the correct handler method
		switch on context {
			when BEFORE_INSERT {
				this.beforeInsert();
			}
			when BEFORE_UPDATE {
				this.beforeUpdate();
			}
			when AFTER_INSERT {
				this.afterInsert();
			}
			when AFTER_UPDATE {
				this.afterUpdate();
			}
			when BEFORE_DELETE {
				this.beforeDelete();
			}
			when AFTER_DELETE {
				this.afterDelete();
			}
			when AFTER_UNDELETE {
				this.afterUndelete();
			}
		}
	}

	/**
	 * @description Allows developers to prevent trigger loops, or allow
	 * a limited number of them by setting the maximum number of times
	 * this trigger is called.
	 * @param max   A valid number (generally 1) of times you'd like
	 * to allow the trigger to run.
	 * @example
	 * In the context of a TriggerFramework class,
	 * this.setMaxLoopCount(5);
	 */
	public void setMaxLoopCount(Integer max) {
		String handlerName = getHandlerName();
		if (!TriggerFramework.loopCountMap.containsKey(handlerName)) {
			TriggerFramework.loopCountMap.put(
				handlerName,
				new TriggerFrameworkLoopCount(max)
			);
		} else {
			TriggerFramework.loopCountMap.get(handlerName).setMax(max);
		}
	}

	/**
	 * @description Allows developers to turn off the max loop count
	 * @example
	 * In the context of a TriggerFramework class,
	 * this.clearMaxLoopCount();
	 */
	public void clearMaxLoopCount() {
		this.setMaxLoopCount(-1);
	}

	/**
	 * @description       Allows developers to conditionally bypass (disable)
	 * other triggers that *also* implement this TriggerFramework
	 * @param handlerName Class name (String) of the trigger handler to bypass
	 * @example
	 * TriggerFramework.bypass('AccountTriggerFramework');
	 */
	public static void bypass(String handlerName) {
		String stackTrace = Polyfills.generateStackTrace();
		Log.get()
			.publish(
				handlerName.toLowerCase() +
					' is being bypassed. This stackTrace may help you debug it. ' +
					stackTrace
			);
		TriggerFramework.bypassedHandlers.add(handlerName.toLowerCase());
	}

	/**
	 * @description       Removes a given trigger handler class name from
	 * the list of bypassed trigger handlers.
	 * @param handlerName Handler class name to remove from the bypass list
	 * @example
	 * TriggerFramework.clearBypass('AccountTriggerFramework');
	 */
	public static void clearBypass(String handlerName) {
		TriggerFramework.bypassedHandlers.remove(handlerName.toLowerCase());
	}

	/**
	 * @description       Allows developers to check whether a given trigger
	 * handler class is currently bypassed.
	 * @param handlerName The name of the trigger handler class to check for
	 * @return           `Boolean`
	 * @example
	 * TriggerFramework.isBypassed('AccountTriggerFramework');
	 */
	public static Boolean isBypassed(String handlerName) {
		return TriggerFramework.bypassedHandlers.contains(
			handlerName.toLowerCase()
		);
	}

	/**
	 * @description removes all classes from the bypass list
	 * @example
	 * TriggerFramework.clearAllBypasses();
	 */
	public static void clearAllBypasses() {
		TriggerFramework.bypassedHandlers.clear();
	}

	/***************************************
	 * private instance methods
	 ***************************************/

	/**
	 * @description increment the loop count
	 * @exception   Throws loop count exception if the max loop count is reached
	 */
	@testVisible
	protected void addToLoopCount() {
		String handlerName = getHandlerName();
		if (TriggerFramework.loopCountMap.containsKey(handlerName)) {
			Boolean exceeded = TriggerFramework.loopCountMap.get(handlerName)
				.increment();
			if (exceeded) {
				Integer max = TriggerFramework.loopCountMap.get(handlerName)
					.max;
				throw new TriggerFrameworkException(
					'Maximum loop count of ' +
						String.valueOf(max) +
						' reached in ' +
						handlerName
				);
			}
		}
	}

	/**
	 * @description Returns the string version of the handler class being
	 * invoked
	 * @return     `String` Name of the Handler
	 */
	@testVisible
	protected String getHandlerName() {
		return Polyfills.classNameFromInstance(this).toLowerCase();
	}

	/***************************************
	 * context methods
	 ***************************************/

	/**
	 * These methods are all intended to be overridden by
	 * individual trigger handlers. They exist here only to
	 * establish the 'software contract' that they exist.
	 */

	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void beforeInsert() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void beforeUpdate() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void beforeDelete() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void afterInsert() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void afterUpdate() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void afterDelete() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected virtual void afterUndelete() {
	}
}