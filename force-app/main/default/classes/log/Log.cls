/**
 * @description Generic logging framework that persists across DML reversions
 * by publishing a Platform Event
 *
 *  Shared Code
 * @group Log
 *
 */
public with sharing class Log {
	/**
	 * @description private instance of this log class that backs the
	 * singleton get() method.
	 */
	private static Log currentInstance;

	/**
	 * @description private list of LogMessage objects to be published in the
	 * future
	 */
	private List<LogMessage> buffer;

	/**
	 * @description establishes the buffer, if one doesn't yet exist
	 * private, to ensure we can't directly construct this class. Use the
	 * Singleton, Luke.
	 */
	private Log() {
		buffer = new List<LogMessage>();
	}

	/**
	 * @description Singleton pattern `get` method.
	 * @return     `Log`
	 */
	public static Log get() {
		if (currentInstance == null) {
			currentInstance = new Log();
		}
		return currentInstance;
	}

	/**
	 * @description Add a message to the buffer without publishing it.
	 * Assumes a null severity
	 * @param messageToLog  The string message to add to the buffer.
	 */
	public void add(String messageToLog) {
		this.add(messageToLog, null);
	}

	/**
	 * @description Add a message to the buffer without publishing it.
	 * @param messageToLog The string message to add to the buffer.
	 * @param severity     LogMessage.LogSeverity enum
	 */
	public void add(String messageToLog, LogMessage.LogSeverity severity) {
		LogMessage msg = new LogMessage(messageToLog);
		if (severity != null) {
			msg.severity = severity;
		}
		buffer.add(msg);
	}

	/**
	 * @description Add an formatted exception message to the buffer without
	 * publishing it. Assumes a null Severity
	 * @param exceptionToLog Exception to format and log
	 */
	public void add(Exception exceptionToLog) {
		this.add(exceptionToLog, null);
	}

	/**
	 * @description Add an formatted exception message to the buffer without
	 * publishing it.
	 * @param exceptionToLog Exception to format and log
	 * @param severity       LogMessage.LogSeverity enum
	 */
	public void add(Exception exceptionToLog, LogMessage.LogSeverity severity) {
		LogMessage msg = new LogMessage(exceptionToLog);
		if (severity != null) {
			msg.severity = severity;
		}
		buffer.add(msg);
	}

	/**
	 * @description Publish any messages currently in the buffer, without adding
	 * any new ones.
	 */
	public void publish() {
		List<SObject> rawLogs = new List<SObject>();
		for (LogMessage msg : this.buffer) {
			rawLogs.add(msg.toEvent());
		}
		if (QuiddityGuard.quiddityIsATestContext()) {
			System.debug('Publishing Log via Event Bus');
		}
		List<Database.SaveResult> publishResults = EventBus.publish(rawLogs);
		if (publishResults.size() > 0) {
			for (Database.SaveResult result : publishResults) {
				if (result.isSuccess()) {
					System.debug('Log published successfully');
				} else {
					for (Database.Error err : result.getErrors()) {
						System.debug(
							'Error returned: ' +
							err.getStatusCode() +
							' - ' +
							err.getMessage()
						);
					}
				}
			}
		}
		system.debug('publishedResults: ' + publishResults);
		this.buffer.clear();
	}

	/**
	 * @description Auto-format exception details, add it to the log buffer,
	 * and then publish the current buffer. Use the equivalent add
	 * method if you intend to add multiple messages rapidly to minimize DML
	 * usage.
	 * @param exceptionToLog exception to format and log
	 */
	public void publish(Exception exceptionToLog) {
		this.buffer.add(new LogMessage(exceptionToLog));
		this.publish();
	}

	/**
	 * @description Auto-format a custom log message string, add it to the log
	 * buffer, and then publish the current buffer. Use the equivalent add
	 * method if you intend to add multiple messages rapidly to minimize DML
	 * usage.
	 * @param messageToLog String to log
	 */
	public void publish(String messageToLog) {
		this.buffer.add(new LogMessage(messageToLog));
		this.publish();
	}
}