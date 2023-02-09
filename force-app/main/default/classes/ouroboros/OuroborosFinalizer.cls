public with sharing class OuroborosFinalizer implements Finalizer {
	private Ouroboros ouroboros;
	private Log logger = log.get();

	public OuroborosFinalizer(Ouroboros ouroboros) {
		this.ouroboros = ouroboros;
	}

	private boolean safeToEnqueueAccordingToLimits() {
		return (Limits.getLimitQueueableJobs() -
		(Limits.getQueueableJobs() + 1) > 0);
	}

	public void execute(FinalizerContext context) {
		Id parentQueueableJobId = context.getAsyncApexJobId();
		switch on context.getResult() {
			when SUCCESS {
				if (!this.ouroboros.hasExitCriteriaBeenMet()) {
					Type toInstantiate = Polyfills.typeObjFromInstance(
						this.ouroboros
					);
					Ouroboros nextIteration = (Ouroboros) toInstantiate.newInstance();
					nextIteration.passthrough = this.ouroboros.passthrough;
					if (safeToEnqueueAccordingToLimits()) {
						system.enqueueJob(nextIteration);
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