/**
 * @description This class provides an implementation of the Promise
 * pattern. The promise pattern allows developers to have asynchronous
 * flow control without the need to handle callbacks. Developers will
 * extend this class, implementing the necessary `execute` method.
 * The contents of your execute method will be executed asynchronously.
 * Using the `then` method of this class, you can construct chains of
 * asynchronous operations. As each 'step' of the chain is completed
 * the transaction finalizer will be constructed with the remaining
 * steps and any passthrough data you specify. Passthrough data allows
 * you to pass data between steps.
 */
public abstract class Promise implements Queueable, Database.AllowsCallouts {
	public List<Promise> promises = new List<Promise>();
	public Object passthrough;

	protected Promise then(object toAdd) {
		promises.add((Promise) toAdd);
		return this;
	}

	// This must be implemented by extending classes.
	// Developers - implement this method with the work you want executed
	// asynchronously.
	abstract public void execute();

	// This is required by the Queueable interface. It's the
	// essence of how the Promise pattern is implemented in Apex.
	public virtual void execute(QueueableContext context) {
		// invoke the abstract method `execute`. see the comment above.
		execute();
		// create a new instance of the finalizer class.
		// note that we're passing in the list of promises
		// and the passthrough data.
		Finalizer chain = new Chain(this.promises, this.passthrough);
		// Attach the finalizer to system context. This will take care
		// of enqueueing the next promise in the chain.
		System.attachFinalizer(chain);
	}
}