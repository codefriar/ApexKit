@SuppressWarnings(
	'PMD.ExcessivePublicCount, PMD.CyclomaticComplexity, PMD.FieldDeclarationsShouldBeAtStart, PMD.EmptyStatementBlock'
)
/**
 * @description An opinionated trigger handler framework.
 * @group Trigger Framework
 */
public virtual class TriggerFramework {
	// static map of handlerName, times run() was invoked
	private static Map<String, TriggerFramework.TriggerFrameworkLoopCount> loopCountMap;
	public static Set<String> bypassedHandlers;

	// the current context of the trigger, override-able in tests
	@testVisible
	protected TriggerContext triggerContext = new TriggerContext();

	// static initialization
	static {
		loopCountMap = new Map<String, TriggerFramework.TriggerFrameworkLoopCount>();
		bypassedHandlers = new Set<String>();
	}

	/**
	 * @description Constructs a trigger handler object and ensures the context
	 * is set
	 */
	public TriggerFramework() {
		// this.setTriggerContext();
	}

	/**
	 * @description This is main brokering method that is called by the trigger.
	 * It's responsible for determining the proper context, and calling the
	 * correct method
	 * @example
	 * AccountTriggerFramework.run();
	 */
	public virtual void run() {
		standardValidation();
		dispatchHandlerMethod(this.triggerContext.context);
	}

	protected void standardValidation() {
		/**
		 * Guard statements against invalid execution context and a bypassed handlerName
		 */
		if (this.triggerContext.isInvalidExecutionContext()) {
			return;
		}

		if (TriggerFramework.bypassedHandlers.contains(getHandlerName())) {
			return;
		}

		addToLoopCount();
	}

	private void dispatchHandlerMethod(
		TriggerContext.ValidTriggerContexts context
	) {
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
				new TriggerFramework.TriggerFrameworkLoopCount(max)
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
				Integer max = TriggerFramework.loopCountMap.get(handlerName).max;
				throw new TriggerFramework.TriggerFrameworkException(
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
	protected virtual void beforeInsert() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void beforeUpdate() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void beforeDelete() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void afterInsert() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void afterUpdate() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void afterDelete() {
	}
	/**
	 * @description Virtual method for the implementing class to override
	 */
	@testVisible
	protected virtual void afterUndelete() {
	}

	/**
	 * @description Inner class for managing the loop count per handler
	 */
	public class TriggerFrameworkLoopCount {
		public Integer max;
		public Integer count;

		/**
		 * @description Loop counter method with default of 5.
		 */
		public TriggerFrameworkLoopCount() {
			this.max = 5;
			this.count = 0;
		}

		/**
		 * @description Sets loop count based on the param.
		 * @param max   Maximum number of loops to allow.
		 */
		public TriggerFrameworkLoopCount(Integer max) {
			this.max = max;
			this.count = 0;
		}

		/**
		 * @description Increment the internal counter returning the results of
		 * this.exceeded().
		 * @return     `Boolean` true if count will exceed max count or is less
		 * than 0.
		 */
		public Boolean increment() {
			this.count++;
			return this.exceeded();
		}

		/**
		 * @description Determines if this we're about to exceed the loop count.
		 * @return     `Boolean` true if less than 0 or more than max.
		 */
		public Boolean exceeded() {
			if (this.max < 0) {
				return false;
			}
			if (this.count > this.max) {
				return true;
			}
			return false;
		}

		/**
		 * @description Returns the max loop count.
		 * @return     `Integer` max loop count.
		 */
		public Integer getMax() {
			return this.max;
		}

		/**
		 * @description Returns the current loop count.
		 * @return     `Integer` current loop count.
		 */
		public Integer getCount() {
			return this.count;
		}

		/**
		 * @description Sets the max loop size
		 * @param max   The integer to set max to.
		 */
		public void setMax(Integer max) {
			this.max = max;
		}
	}

	public class TriggerFrameworkException extends Exception {
	}
}