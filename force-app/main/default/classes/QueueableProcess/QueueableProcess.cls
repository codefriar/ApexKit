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
	public List<QueueableContext> queueableContextHistory;
	public List<FinalizerContext> finalizerContextHistory;
	@TestVisible
	private static Boolean defaultHandleExceptionCalled = false;

	/**
	 * @description this is a constructor that is used by extension classes;
	 */
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected QueueableProcess() {
	}

	/**
	 * @description This method provides a syntatic sugar for adding a new QueueableProcess to the chain.
	 *
	 * @param toAdd An instance of a class that extends this QueueableProcess class and implements the `execute` method.
	 *
	 * @return Returns a Queueable Process instance that can be used to chain additional QueueableProcess instances.
	 */
	public QueueableProcess then(QueueableProcess toAdd) {
		processSteps.add(toAdd);
		return this;
	}

	/**
	 * @description This method starts the QueueableProcess chain. It's the entry point for the process.
	 *
	 * @return Id - Id of the Enqueued job.
	 */
	public Id start() {
		return start(null);
	}

	/**
	 * @description This method starts the QueueableProcess chain. It's the entry point for the process.
	 *
	 * @param intialPassthroughData Object - this is the initial passthrough data that will be passed to the first
	 * QueueableProcess in the chain.
	 *
	 * @return Id - Id of the Enqueued job.
	 */
	public Id start(Object intialPassthroughData) {
		this.dataPassthrough = intialPassthroughData;
		return System.enqueueJob(this);
	}

	/**
	 * @description This must be implemented by extending classes. Developers - implement this method with the work you
	 * want executed asynchronously.
	 */
	abstract public void execute();

	virtual public void handleException(Exception incomingException) {
		QueueableProcess.defaultHandleExceptionCalled = true;
		System.debug(incomingException.getMessage()); // NOPMD
	}

	/**
	 * @description This is required by the Queueable interface. It's the essence of how the QueueableProcess pattern is
	 * implemented in Apex.
	 *
	 * @param context QueueableContext - dependency injected by Salesforce at execution time.
	 */
	public virtual void execute(QueueableContext context) {
		// if the queueableContextHistory is null, initialize it.
		if (this.queueableContextHistory == null) {
			this.queueableContextHistory = new List<QueueableContext>();
		}
		this.queueableContextHistory.add(context);
		// invoke the abstract method `execute`. see the comment above.
		execute();
		// create a new instance of the finalizer class. Note that we're passing in the list of remaining steps and the
		// passthrough data.
		Finalizer nextStep = new EnqueueNextQueueableProcessStep(
			this.processSteps,
			this.dataPassthrough,
			this.queueableContextHistory,
			this.finalizerContextHistory
		);
		// Attach the finalizer to system context. This will take care of enqueueing the next QueueableProcess step in
		// the nextStep.
		System.attachFinalizer(nextStep);
	}
}
