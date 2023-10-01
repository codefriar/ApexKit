@IsTest
public with sharing class ExampleQueueableProcessSteps {
	@TestVisible
	private static Boolean handleExceptionCalled = false;
	public with sharing class Step1 extends QueueableProcess {
		final private Id accountId;

		@SuppressWarnings('PMD.EmptyStatementBlock')
		public Step1() {
		}
		public Step1(Id accountId) {
			this.accountId = accountId;
		}
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

		public override void handleException(Exception e) {
			ExampleQueueableProcessSteps.handleExceptionCalled = true;
		}
	}

	public with sharing class Step2 extends QueueableProcess {
		final private Id accountId;

		@SuppressWarnings('PMD.EmptyStatementBlock')
		public Step2() {
		}
		public Step2(Id accountId) {
			this.accountId = accountId;
		}
		public override void execute() {
			Account acct = fetchAccountByIdForDemoPurposes(this.accountId);
			if (this.dataPassthrough != null) {
				acct.Phone = String.valueOf(this.dataPassthrough);
			}
			Database.update(acct, false, AccessLevel.USER_MODE);
		}
	}

	public static Account fetchAccountByIdForDemoPurposes(Id accountId) {
		return [
			SELECT Id, Name, ShippingStreet
			FROM Account
			WHERE Id = :accountId
			WITH USER_MODE
		];
	}
}
