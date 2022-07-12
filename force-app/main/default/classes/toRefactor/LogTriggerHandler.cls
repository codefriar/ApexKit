/**
 * @group Log
 */
public with sharing class LogTriggerHandler {
	private List<Log__e> logs = new List<Log__e>();
	private Boolean shouldThrow = false;

	public LogTriggerHandler(List<Log__e> logs, Boolean shouldThrow) {
		this.logs = logs;
		this.shouldThrow = shouldThrow;
	}

	public LogTriggerHandler(List<Log__e> logs) {
		this(logs, false);
	}

	public void afterInsert() {
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
		for (Database.SaveResult result : results) {
			if (!result.isSuccess()) {
				System.debug(
					LoggingLevel.ERROR,
					'Failed to Save Log Message + ' + result
				);
			}
		}
	}
}