/**
 * @description This class provides a way for developers to create a process of Queueable classes. This implementation
 * facilitates the handoff of data into the overarching process and from one process step to the next. While
 * functionally similar to the way a 'Promise' pattern allows you chain async methods together. However, a true Promise
 * pattern resolves itself, one way or another, within the same transaction. Therefore, this is not a true Promise
 * pattern, but an elegant way to logically chain Salesforce Queueables together. As a Developer, you'll need to extend
 * this class, implementing the necessary `execute` method. Your `execute` method will be invoked asynchronously as part
 * of a Queueable. You can then chain additional Queueables together using the `then` method provided by this class.
 *
 * As each 'step' of the chain is completed the transaction finalizer will be constructed with the remaining steps and
 * any passthrough data you specify. Passthrough data allows you to pass data between steps.
 */
public abstract class QueueableProcess implements Queueable, Database.AllowsCallouts {
	public List<QueueableProcess> processSteps = new List<QueueableProcess>();
	public Object dataPassthrough;

	/**
	 * @description This method provides a syntatic sugar for adding a new QueueableProcess to the chain.
	 *
	 * @param toAdd An instance of a class that extends this QueueableProcess class and implements the `execute` method.
	 *
	 * @return Returns a Queueable Process instance that can be used to chain additional QueueableProcess instances.
	 */
	protected QueueableProcess then(Object toAdd) {
		processSteps.add((QueueableProcess) toAdd);
		return this;
	}

	/**
	 * @description This must be implemented by extending classes. Developers - implement this method with the work you
	 * want executed asynchronously.
	 */
	abstract public void execute();

	/**
	 * @description This is required by the Queueable interface. It's the essence of how the QueueableProcess pattern is
	 * implemented in Apex.
	 *
	 * @param context QueueableContext - dependency injected by Salesforce at execution time.
	 */
	public virtual void execute(QueueableContext context) {
		// invoke the abstract method `execute`. see the comment above.
		execute();
		// create a new instance of the finalizer class. Note that we're passing in the list of remaining steps and the
		// passthrough data.
		Finalizer chain = new EnqueueNextQueueableProcessStep(
			this.processSteps,
			this.dataPassthrough
		);
		// Attach the finalizer to system context. This will take care of enqueueing the next QueueableProcess step in
		// the chain.
		System.attachFinalizer(chain);
	}
}
