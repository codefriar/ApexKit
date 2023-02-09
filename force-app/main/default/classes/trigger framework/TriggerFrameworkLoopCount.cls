/**
 * @description inner class for managing the loop count per handler
 */
public with sharing class TriggerFrameworkLoopCount {
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