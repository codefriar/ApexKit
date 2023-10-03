/**
 * @description This class implements the Apex Transaction Finalizer interface. It's used to implement promises. This
 * class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
 * is executed. The QueueableProcess class automatically attaches this finalizer to it's execution.
 */
public class EnqueueNextQueueableProcessStep implements System.Finalizer {
	/**
	 * @description A list of QueueableProcess Objects. The first step in the list is executed.
	 */
	private final List<QueueableProcess> processSteps;
	/**
	 * @description This field allows you to pass information into your initial QueueableProcessStep. This is also the
	 * field that is passed to the next QueueableProcessStep in the list.
	 */
	private final Object dataPassthrough;

	/**
	 * @description Constructor for the EnqueueNextQueueableProcessStep class.
	 *
	 * @param processSteps List<QueueableProcess> A list of QueueableProcess Objects. The first step in the list is executed.
	 * @param dataPassthrough Object this is either the initial data passed into the first QueueableProcessStep, or the
	 * data passed from the previous QueueableProcessStep.
	 */
	public EnqueueNextQueueableProcessStep(
		List<QueueableProcess> processSteps,
		Object dataPassthrough
	) {
		this.processSteps = processSteps;
		this.dataPassthrough = dataPassthrough;
	}

	/**
	 * @description This method is required by the Apex Transaction Finalizer interface. It's used to enqueue the next
	 * QueueableProcessStep in the list, if one exists.
	 *
	 * @param context FinalizerContext Dependency injected by Salesforce at execution time. Contains the result of the
	 * QueueableProcessStep that just executed.
	 */
	public void execute(FinalizerContext context) {
		Id parentQueueableJobId = context.getAsyncApexJobId();
		switch on context.getResult() {
			when SUCCESS {
				if (this.processSteps.size() > 0) {
					QueueableProcess nextProcessStep = this.processSteps.remove(0);
					nextProcessStep.processSteps = this.processSteps;
					nextProcessStep.dataPassthrough = dataPassthrough;
					System.enqueueJob(nextProcessStep);
				}
			}
			when UNHANDLED_EXCEPTION {
				Log.get().add(context.getException());
				Log.get()
					.publish(
						'Parent Queueable (Job ID: ' + parentQueueableJobId + '): FAILED!'
					);
			}
		}
	}
}
