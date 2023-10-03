/**
 * @description This is the OuroborosFinalizer class. It is responsible for determining if the Ouroboros should
 * continue to loop, and if so, enqueueing the next iteration. It also ensure passthrough objects are passed to the
 * next iteration.
 */
public with sharing class OuroborosFinalizer implements Finalizer {
	/**
	 * @description An Ouroboros instance is required to be passed to the constructor. This is the instance that will
	 * be enqueued, if necessary.
	 */
	private final Ouroboros ouroboros;

	/**
	 * @description An instance of the Log class used to create transaction-rollback safe log entries
	 */
	private final Log logger = Log.get();

	/**
	 * @description Constructor. Requires an instance of an Ouroboros implementing class to be passed in.
	 *
	 * @param ouroboros Ouroboros instance to be enqueued, if necessary
	 */
	public OuroborosFinalizer(Ouroboros ouroboros) {
		this.ouroboros = ouroboros;
	}

	/**
	 * @description Method is responsible for determining if it's safe to enqueue the next iteration of the Ouroboros
	 * at least in accordance with the Queueable Apex limits. If it's not safe, the circuit breaker is tripped and the
	 * next iteration will not be enqueued.
	 *
	 * @return Boolean True if enqueuing the next iteration will not violate any Apex governor limits
	 */
	private static Boolean safeToEnqueueAccordingToLimits() {
		return (Limits.getLimitQueueableJobs() - (Limits.getQueueableJobs() + 1) >
		0);
	}

	/**
	 * @description This is the method that is called by the Apex runtime when the Ouroboros instance has completed.
	 * It's responsible for determining if it's safe to enqueue the next iteration of the Ouroboros, and if so, if it's
	 * also necessary to enqueue the next iteration. If it is, it will enqueue the next iteration.
	 *
	 * @param context FinalizerContext This is dependency injected by the Queueable system.
	 */
	public void execute(FinalizerContext context) {
		Id parentQueueableJobId = context.getAsyncApexJobId();
		switch on context.getResult() {
			when SUCCESS {
				if (!this.ouroboros.hasExitCriteriaBeenMet()) {
					Type toInstantiate = Polyfills.typeObjFromInstance(this.ouroboros);
					Ouroboros nextIteration = (Ouroboros) toInstantiate.newInstance();
					nextIteration.passthrough = this.ouroboros.passthrough;
					if (safeToEnqueueAccordingToLimits()) {
						System.enqueueJob(nextIteration);
					} else {
						TestPolyfills.circuitBreakerTripped = true;
						logger.add(
							'Limits Class shows the maximum number of queueable jobs has been reached. The next iteration will not be enqueued.'
						);
						logger.publish();
					}
				}
			}
			when UNHANDLED_EXCEPTION {
				logger.publish(
					'Previous instance of the Ouroboros implementing class ' +
						this.ouroboros.className() +
						' failed with an exception. The previous instance\'s jobId was ' +
						parentQueueableJobId +
						'. The exception was: ' +
						context.getException()
				);
			}
		}
	}
}
