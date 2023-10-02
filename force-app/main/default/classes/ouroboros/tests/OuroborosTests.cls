@IsTest
class OuroborosTests {
	private Boolean codeDidTryToReEnqueue = false;

	public class ExampleOuroborosImplementation extends Ouroboros {
		Integer executionCount = 1;
		Integer completedExecutions = 0;
		/**
		 * @description Required method that returns true if the exit criteria has been met.
		 *
		 * @return Boolean - true if the exit criteria has been met, false otherwise.
		 */
		public override Boolean hasExitCriteriaBeenMet() {
			if ((Integer) this.passthrough >= executionCount) {
				return true;
			}
			return false;
		}

		/**
		 * @description This is the method that will be called when the Ouroboros executes the job.
		 */
		public override void execute() {
			this.completedExecutions++;
		}
	}

	@IsTest
	private static void testOuroborosFunctionalNegative() {
		ExampleOuroborosImplementation example = new ExampleOuroborosImplementation();
		example.passthrough = 0;
		Test.startTest();
		System.enqueueJob(example);
		Test.stopTest();
		Assert.isTrue(
			TestPolyfills.circuitBreakerTripped,
			'Expected OuroborosFinalizer to have tripped the circuitBreaker but it was not'
		);
	}

	@IsTest
	private static void testClassName() {
		Test.startTest();
		Assert.areNotEqual(
			null,
			new OuroborosTests.ExampleOuroborosImplementation().className(),
			'Expected className to return a non-null value'
		);
		Test.stopTest();
	}
}
