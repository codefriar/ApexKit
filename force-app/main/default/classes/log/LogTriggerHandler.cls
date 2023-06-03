/**
 * @description Class handles the post-insert processing of Log events
 * <br>Extends the TriggerFramework class
 * <br>Enables the user to define if this handler should silently
 * ignore errors thrown by dml, or if it should throw a log
 * exception
 */
public with sharing class LogTriggerHandler extends TriggerFramework {
	private List<Log__e> logs = new List<Log__e>();
	private Boolean shouldThrow = false;

	/**
	 * @description       Constructor, called by trigger.
	 * @param logs        Logs to process
	 * @param shouldThrow if true, this class will throw a log exception
	 * when DML errors occur.
	 */
	public LogTriggerHandler(List<Log__e> logs, Boolean shouldThrow) {
		this.logs = logs;
		this.shouldThrow = shouldThrow;
	}

	/**
	 * @description convenience constructor, calls previous constructor
	 * but will not throw a log exception on dml errors
	 * @param logs  logs to process
	 */
	public LogTriggerHandler(List<Log__e> logs) {
		this(logs, false);
	}

	/**
	 * @description Overridden from TriggerFramework.
	 * TriggerFramework executes this method when the trigger
	 * context is after insert
	 * @exception   throws LogException on Database.insert
	 * isSuccess is false
	 */
	public override void afterInsert() {
		List<LogEvent__c> events = new List<LogEvent__c>();
		for (Log__e log : logs) {
			events.add(
				new LogEvent__c(
					Log_Data__c = log.Log_Message__c,
					Quiddity__c = log.Quiddity__c,
					Request_Id__c = log.Request_Id__c,
					Severity__c = log.Severity__c
				)
			);
		}

		List<Database.SaveResult> results = Database.insert(events, false);
		Boolean reasonToThrow = false;
		String firstError = '';

		for (Database.SaveResult result : results) {
			if (!result.isSuccess()) {
				reasonToThrow = true;
				firstError = result.getErrors()[0].getMessage();
				System.debug(
					LoggingLevel.ERROR,
					'Failed to Save Log Message + ' + result
				);
			}
		}
		if (reasonToThrow) {
			throw new LogException(
				'Failed to save (at least one) LogEvent__c Records. First error: ' +
				firstError
			);
		}
	}
}