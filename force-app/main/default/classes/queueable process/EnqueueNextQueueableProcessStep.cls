/**
 * @description This class implements the Apex Transaction Finalizer interface. It's used to implement promises. This
 * class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
 * is executed. The QueueableProcess class automatically attaches this finalizer to it's execution.
 */
public with sharing class EnqueueNextQueueableProcessStep implements System.Finalizer {
	/**
	 * @description a DataProvider instance. This is used to allow for dependency injection in unit tests.
	 */
	@TestVisible
	QueueableProcessDataProvider dataProvider = new QueueableProcessDataProvider();

	/**
	 * @description A list of QueueableProcess Objects. The first step in the list is executed.
	 */
	private final List<QueueableProcess> processSteps;
	/**
	 * @description This field allows you to pass information into your initial QueueableProcessStep. This is also the
	 * field that is passed to the next QueueableProcessStep in the list.
	 */
	private final Object dataPassthrough;

	private final List<QueueableContext> queueableContextHistory;

	private List<FinalizerContext> finalizerContextHistory;

	/**
	 * @description Constructor for the EnqueueNextQueueableProcessStep class.
	 *
	 * @param processSteps List<QueueableProcess> A list of QueueableProcess Objects. The first step in the list is
	 *
	 * executed.
	 * @param dataPassthrough Object this is either the initial data passed into the first QueueableProcessStep, or the
	 * data passed from the previous QueueableProcessStep.
	 * @param queueableContextHistory List<QueueableContext> A list of QueueableContext Objects.
	 * @param finalizerContextHistory List<FinalizerContext> A list of FinalizerContext Objects.
	 */

	@SuppressWarnings('PMD.ExcessiveParameterList')
	public EnqueueNextQueueableProcessStep(
		List<QueueableProcess> processSteps,
		Object dataPassthrough,
		List<QueueableContext> queueableContextHistory,
		List<FinalizerContext> finalizerContextHistory
	) {
		this.processSteps = processSteps;
		this.dataPassthrough = dataPassthrough;
		this.queueableContextHistory = queueableContextHistory;
		this.finalizerContextHistory = finalizerContextHistory;
	}

	/**
	 * @description This method is required by the Apex Transaction Finalizer interface. It's used to enqueue the next
	 * QueueableProcessStep in the list, if one exists.
	 *
	 * @param context FinalizerContext Dependency injected by Salesforce at execution time. Contains the result of the
	 * QueueableProcessStep that just executed.
	 */
	public void execute(FinalizerContext context) {
		if (this.finalizerContextHistory == null) {
			this.finalizerContextHistory = new List<FinalizerContext>();
		}
		this.finalizerContextHistory.add(context);
		if (this.finalizerContextHistory == null) {
			this.finalizerContextHistory = new List<FinalizerContext>();
		}
		this.finalizerContextHistory.add(context);
		switch on context.getResult() {
			when SUCCESS {
				if (this.processSteps.size() > 0) {
					QueueableProcess nextProcessStep = this.processSteps.remove(0);
					nextProcessStep.processSteps = this.processSteps;
					nextProcessStep.dataPassthrough = dataPassthrough;
					nextProcessStep.queueableContextHistory = this.queueableContextHistory;
					nextProcessStep.finalizerContextHistory = this.finalizerContextHistory;
					System.enqueueJob(nextProcessStep);
				}
			}
			when UNHANDLED_EXCEPTION {
				this.handleException(context);
			}
		}
	}

	private void handleException(FinalizerContext context) {
		try {
			String className = this.dataProvider.getClassName(
				context.getAsyncApexJobId()
			);
			QueueableProcess parentQueueable = (QueueableProcess) Type.forName(
					className
				)
				?.newInstance();
			parentQueueable.handleException(context.getException());
		} catch (QueryException qe) {
			Callable exceptionHandler = (Callable) Type.forName(
					'FailsafeExceptionHandler'
				)
				.newInstance();
			List<Exception> exceptions = new List<Exception>{
				qe,
				context.getException()
			};
			exceptionHandler
				?.call(
					'handleExceptions',
					new Map<String, List<Exception>>{ 'incomingExceptions' => exceptions }
				);
		}
	}
}
