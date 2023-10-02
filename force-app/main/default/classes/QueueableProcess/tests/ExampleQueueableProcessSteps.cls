@IsTest
/**
 * @description This class contains two inner classes used for testing the QueueableProcess framework.
 */
public with sharing class ExampleQueueableProcessSteps {
	/**
	 * @description A 'circuit breaker' to be tripped when the handle exception method is called. This is only
	 * used for testing.
	 */
	@TestVisible
	private static Boolean handleExceptionCalled = false;

	/**
	 * @description Step1 is an inner class that conforms to QueueableProcess. It represents an example step in a
	 * process that updates an account's shipping street. It also increments the data passthrough by 1.
	 */
	public with sharing class Step1 extends QueueableProcess {
		/**
		 * @description The Account Id to work with
		 */
		final private Id accountId;

		/**
		 * @description This is a required no-arg/no-opp constructor. When/if the class is instantiated by the
		 * error handler, this constructor is used.
		 */
		@SuppressWarnings('PMD.EmptyStatementBlock')
		public Step1() {
		}

		/**
		 * @description The normal constructor. Accepts a accountId.
		 *
		 * @param accountId Id the account id to process.
		 */
		public Step1(Id accountId) {
			this.accountId = accountId;
		}

		/**
		 * @description This is the main execute method required by the QueueableProcess abstract class. This is where
		 * developers will place the code to execute asynchronously in this step. In this case, all it does is fetch
		 * an account and increment the shipping street by 1. #riviting.
		 */
		public override void execute() {
			Account acct = fetchAccountByIdForDemoPurposes(this.accountId);
			Integer castedInteger = Integer.valueOf(acct.ShippingStreet);
			acct.ShippingStreet = String.valueOf(castedInteger + 1);
			if (this.dataPassthrough != null) {
				this.dataPassthrough = 1 + (Integer) this.dataPassthrough;
				acct.BillingStreet = String.valueOf(this.dataPassthrough);
			}
			Database.update(acct, false, AccessLevel.USER_MODE);
		}

		/**
		 * @description This is an optionally overridable method from the QueueableProcess abstract class. If this
		 * method is defined on your class, should the execute method above fail at runtime, the QueueableProcess
		 * finalizer will instantiate this class, and call this method. This allows developers to write per-step
		 * customized error handling. In this case, we're just setting a static boolean to true so we can test the
		 * functionality.
		 *
		 * @param e Exception any exception object.
		 */
		public override void handleException(Exception e) {
			ExampleQueueableProcessSteps.handleExceptionCalled = true;
		}
	}

	/**
	 * @description This is a second example of a QueueableProcess step. It's very similar to the first, but it
	 * manipulates the account phone field.
	 */
	public with sharing class Step2 extends QueueableProcess {
		/**
		 * @description The Account Id to work with
		 */
		final private Id accountId;

		/**
		 * @description a no-arg/no-opp constructor. This is required for the QueueableProcess framework to be
		 * instantiated dynamically should an error condition occur during the execution of the process.
		 */
		@SuppressWarnings('PMD.EmptyStatementBlock')
		public Step2() {
		}
		/**
		 * @description Standard constructor accepting an account id.
		 *
		 * @param accountId Id the account id to process.
		 */
		public Step2(Id accountId) {
			this.accountId = accountId;
		}

		/**
		 * @description This is the main execute method required by the QueueableProcess abstract class. This is where
		 * developers will place the code they want to execute asynchronously in this step. In this case, all it does
		 * update the account phone field when the data Passthrough isn't null.
		 */
		public override void execute() {
			Account acct = fetchAccountByIdForDemoPurposes(this.accountId);
			if (this.dataPassthrough != null) {
				acct.Phone = String.valueOf(this.dataPassthrough);
			}
			Database.update(acct, false, AccessLevel.USER_MODE);
		}
	}

	/**
	 * @description A de-duplication effort to fetch the account by ID. Used only by this class' examples.
	 *
	 * @param accountId Id account id to fetch.
	 *
	 * @return Account returns the account object referenced by id.
	 */
	public static Account fetchAccountByIdForDemoPurposes(Id accountId) {
		return [
			SELECT Id, Name, ShippingStreet
			FROM Account
			WHERE Id = :accountId
			WITH USER_MODE
		];
	}
}
