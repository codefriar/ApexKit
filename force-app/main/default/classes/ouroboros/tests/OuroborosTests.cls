@isTest
class OuroborosTests {
	private Boolean codeDidTryToReEnqueue = false;

	public class ExampleOuroborosImplementation extends Ouroboros {
		Integer executionCount = 1;
		Integer completedExecutions = 0;
		public override Boolean hasExitCriteriaBeenMet() {
			if ((Integer) this.passthrough >= executionCount) {
				return true;
			}
			return false;
		}

		public override void execute() {
			this.completedExecutions++;
		}
	}

	@isTest
	private static void testOuroborosFunctionalNegative() {
		ExampleOuroborosImplementation example = new ExampleOuroborosImplementation();
		example.passthrough = 0;
		Boolean didCatchProperException = false;
		Test.startTest();
		system.enqueueJob(example);
		Test.stopTest();
		Assert.isTrue(
			TestPolyfills.circuitBreakerTripped,
			'Expected OuroborosFinalizer to have tripped the circuitBreaker but it wasn\'t'
		);
	}

	@isTest
	private static void testClassName() {
		Test.startTest();
		Assert.areNotEqual(
			null,
			new OuroborosTests.ExampleOuroborosImplementation().className()
		);
		Test.stopTest();
	}
}