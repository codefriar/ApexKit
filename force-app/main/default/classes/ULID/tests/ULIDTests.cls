@isTest /**
 * @description This seems like a woefully inadequate test class.
 * However, the ULID class contains no branching logic to test.
 * The single public method is fully tested by this class' method.
 * Because ULIDs are intentionally random, there's no way to test
 * deterministic output.
 */
class ULIDTests {
	@isTest
	private static void testGenerateMethod() {
		Test.startTest();
		String ulid = ULID.generate();
		Test.stopTest();
		Assert.areNotEqual(null, ulid, 'ulid string should not be null');
		Assert.areEqual(
			26,
			ulid.length(),
			'ulid string should be 26 characters long'
		);
	}
}