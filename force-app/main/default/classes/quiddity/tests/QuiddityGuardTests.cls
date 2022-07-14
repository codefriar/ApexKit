@isTest
private class QuiddityGuardTests {
    @isTest
    static void testQuiddityGuardFindsTestQuiddityPositive() {
        Test.startTest();
        System.assert(
            QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
            'Expected a testQuiddity to be in the Trusted Quiddities list'
        );
        Test.stopTest();
    }

    @isTest
    static void testQuiddityOverrideReturnsFalsePositive() {
        QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
        Test.startTest();
        System.assertNotEquals(
            true,
            QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
            'Expected Future quiddity to not be in trusted quiddities list'
        );
        Test.stopTest();
    }

    @isTest
    static void testQuiddityPositive() {
        QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
        Test.startTest();
        System.assertNotEquals(
            Quiddity.FUTURE,
            QuiddityGuard.quiddity(),
            'Expected Future quiddity to not be in trusted quiddities list'
        );
        Test.stopTest();
    }

    @isTest
    static void testIsNotAcceptableQuiddityPositive() {
        QuiddityGuard.testQuiddityOverride = Quiddity.VF;
        Test.startTest();
        System.assertNotEquals(
            true,
            QuiddityGuard.isNotAcceptableQuiddity(
                QuiddityGuard.trustedQuiddities
            ),
            'Expected a testQuiddity to not be in the Trusted Quiddities list'
        );
        Test.stopTest();
    }
}
