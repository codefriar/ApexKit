/**
 * @description This class is a polyfill for the handling exceptions. Rather than writing
 * boilerplate exception handling code everywhere, this class can be used to log exceptions.
 */
public with sharing class FailsafeExceptionHandler implements System.Callable {
	/**
	 * @description An instance of Log to log exceptions.
	 */
	@TestVisible
	private final Log logger = Log.get();

	@SuppressWarnings('PMD.EmptyStatementBlock')
	public FailsafeExceptionHandler() {
	}

	/**
	 * @description Constructor usage for a single exception.
	 *
	 * @param incomingException Exception the Exception to be handled.
	 *
	 * @example `new FailsafeExceptionHandler(incomingException);`
	 */
	public FailsafeExceptionHandler(Exception incomingException) {
		this.handledException(incomingException);
		logger.publish();
	}

	/**
	 * @description Constructor usage for a list of exceptions.
	 *
	 * @param incomingExceptions List<Exception> the list of exceptions to be handled.
	 *
	 * @example `new FailsafeExceptionHandler(incomingExceptions);`
	 */
	public FailsafeExceptionHandler(List<Exception> incomingExceptions) {
		this.handleExceptions(incomingExceptions);
		logger.publish();
	}

	/**
	 * @description Handles an incoming exception by adding it to the log list.
	 *
	 * @param incomingException Exception the exception to be handled.
	 */
	public void handledException(Exception incomingException) {
		logger.add(incomingException);
	}

	/**
	 * @description handles an list of incoming exceptions
	 *
	 * @param exceptions List<Exception> the list of exceptions to be handled.
	 */
	public void handleExceptions(List<Exception> exceptions) {
		for (Exception incomingException : exceptions) {
			this.handledException(incomingException);
		}
	}

	/**
	 * @description Implements the Callable interface. This allows the class to be used outside of a package boundary.
	 *
	 * @param action String the action to be performed. The only one handled in this class is 'handleException'.
	 * @param args Map<String, Object> the arguments to be passed to the action. in this case
	 * 'incomingException' => Exception
	 *
	 * @return Object returns null
	 */
	public Object call(String action, Map<String, Object> args) {
		switch on action {
			when 'handleException' {
				this.handledException((Exception) args.get('incomingException'));
			}
			when 'handleExceptions' {
				this.handleExceptions((List<Exception>) args.get('incomingExceptions'));
			}
		}
		logger.publish();
		return null;
	}
}
