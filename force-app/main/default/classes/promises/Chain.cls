/**
 * @description This class implements the Apex Transaction Finalizer interface.
 * It's used to implement promises. This class is constructed with a
 * list of Promise Objects, and any passthrough data. The first
 * promise in the list is executed. The Promise implementing class
 * automatically attaches this finalizer to it's execution.
 */
public class Chain implements Finalizer {
	Promise[] promises;
	Object passthrough;

	public Chain(Promise[] promises, Object passthrough) {
		this.promises = promises;
		this.passthrough = passthrough;
	}

	public void execute(FinalizerContext context) {
		Id parentQueueableJobId = context.getAsyncApexJobId();
		switch on context.getResult() {
			when SUCCESS {
				if (this.promises.size() > 0) {
					Promise next = this.promises.remove(0);
					next.promises = this.promises;
					next.passthrough = passthrough;
					System.enqueueJob(next);
				}
			}
			when UNHANDLED_EXCEPTION {
				Log.get().publish(context.getException());
				Log.get()
					.publish(
						'Parent Queueable (Job ID: ' +
							parentQueueableJobId +
							'): FAILED!'
					);
			}
		}
	}
}