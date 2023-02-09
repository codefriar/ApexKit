@isTest
private class QuiddityGuardTests {
	@isTest
	private static void testQuiddityGuardFindsTestQuiddityPositive() {
		Test.startTest();
		Assert.isTrue(
			QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
			'Expected a testQuiddity to be in the Trusted Quiddities list'
		);
		Test.stopTest();
	}

	@isTest
	private static void testQuiddityOverrideReturnsFalsePositive() {
		QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
		Test.startTest();
		Assert.areNotEqual(
			true,
			QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
			'Expected Future quiddity to not be in trusted quiddities list'
		);
		Test.stopTest();
	}

	@isTest
	private static void testQuiddityPositive() {
		QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
		Test.startTest();
		Assert.areNotEqual(
			Quiddity.FUTURE,
			QuiddityGuard.quiddity(),
			'Expected Future quiddity to not be in trusted quiddities list'
		);
		Test.stopTest();
	}

	@isTest
	private static void testIsNotAcceptableQuiddityPositive() {
		QuiddityGuard.testQuiddityOverride = Quiddity.VF;
		Test.startTest();
		Assert.areNotEqual(
			true,
			QuiddityGuard.isNotAcceptableQuiddity(
				QuiddityGuard.trustedQuiddities
			),
			'Expected a testQuiddity to not be in the Trusted Quiddities list'
		);
		Test.stopTest();
	}
}