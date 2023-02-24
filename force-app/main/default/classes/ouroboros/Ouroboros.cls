public with sharing abstract class Ouroboros implements Queueable, Database.AllowsCallouts {
	public Object passthrough;
	abstract public boolean hasExitCriteriaBeenMet();

	abstract public void execute();

	public String className() {
		return Polyfills.classNameFromInstance(this);
	}

	public virtual void execute(QueueableContext context) {
		// invoke the abstract method `execute`. see the comment above.
		execute();
		// create a new instance of the finalizer class.
		Finalizer ouroborosFinalizer = new OuroborosFinalizer(this);
		// Attach the finalizer to system context. This will take care
		// of enqueueing the next iteration.
		System.attachFinalizer(ouroborosFinalizer);
	}
}