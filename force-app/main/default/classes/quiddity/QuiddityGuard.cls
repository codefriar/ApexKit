/**
 * @description contains methods and static lists for rapid acceptance of a particular set of quiddities.
 *
 * Note: I am not responsible for the name 'Quiddity'. Rumor has it the word comes from Sanskrit and means 'essence'.
 */
public with sharing class QuiddityGuard {
	/**
	 * @description a private testvisible variable allowing developers to
	 * inject a custom quiddity value during test execution.
	 */
	@TestVisible
	private static Quiddity testQuiddityOverride;

	/**
	 * @description a non-exhaustive list of Quiddities that do not include user
	 * situations where users could be injecting malicious data.
	 */
	public static List<Quiddity> trustedQuiddities = new List<Quiddity>{
		Quiddity.SYNCHRONOUS,
		Quiddity.QUEUEABLE,
		Quiddity.BATCH_APEX,
		Quiddity.RUNTEST_SYNC,
		Quiddity.RUNTEST_ASYNC,
		Quiddity.RUNTEST_DEPLOY
	};

	/**
	 * @description An exaustive list of quiddities that are valid for a test
	 * execution
	 */
	public static List<Quiddity> trustedTestQuiddities = new List<Quiddity>{
		Quiddity.RUNTEST_SYNC,
		Quiddity.RUNTEST_ASYNC,
		Quiddity.RUNTEST_DEPLOY
	};

	/**
	 * @description A list of quiddities that may include user-defined data and
	 * therefore should not be trusted without manual FLS/CRUD checks
	 */
	public static List<Quiddity> untrustedQuiddities = new List<Quiddity>{
		Quiddity.AURA,
		Quiddity.DISCOVERABLE_LOGIN,
		Quiddity.INBOUND_EMAIL_SERVICE,
		Quiddity.INVOCABLE_ACTION,
		Quiddity.IOT,
		Quiddity.QUICK_ACTION,
		Quiddity.REMOTE_ACTION,
		Quiddity.REST,
		Quiddity.SOAP,
		Quiddity.VF
	};

	/**
	 * @description A method to determine if the current Quiddity context is
	 * within a caller-supplied list of acceptable quiddity values.
	 * @param acceptableQuiddites A list of quiddities to check against
	 * @return `boolean`
	 */
	public static Boolean isAcceptableQuiddity(List<Quiddity> acceptableQuiddites) {
		Quiddity q = System.Request.getCurrent().getQuiddity();

		if (testQuiddityOverride != null) {
			q = testQuiddityOverride;
		}
		return acceptableQuiddites.contains(q);
	}

	/**
	 * @description Method to determine if the current Quiddity context is not acceptable
	 *
	 * @param acceptableQuiddites List<Quiddity> A list of quiddities to allow.
	 *
	 * @return Boolean true if the current quiddity is not in the list of acceptable quiddities.
	 */
	public static Boolean isNotAcceptableQuiddity(List<Quiddity> acceptableQuiddites) {
		return QuiddityGuard.isAcceptableQuiddity(acceptableQuiddites);
	}

	/**
	 * @description method grabs the current quiddity from the request object
	 *
	 * @return Quiddity The current quiddity.
	 */
	public static Quiddity quiddity() {
		return System.Request.getCurrent().getQuiddity();
	}

	/**
	 * @description Syntactic sugar method for determining if the current request quiddity is a known test quiddity.
	 *
	 * @return Boolean true if the current quiddity is in the list of trusted test quiddities.
	 */
	public static Boolean quiddityIsATestContext() {
		return isAcceptableQuiddity(trustedTestQuiddities);
	}
}
