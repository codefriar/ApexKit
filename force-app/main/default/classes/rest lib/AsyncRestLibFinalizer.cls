/**
 * @description Abstract class defining a common interface with default implementation for finalizers handling
 * AsyncRestApi calls
 */
public with sharing abstract class AsyncRestLibFinalizer implements Finalizer {
	/**
	 * @description the HTTP response object
	 */
	public HttpResponse response;

	/**
	 * @description The extending class must implement this method to handle the HTTP response
	 *
	 * @param response HttpResponse response object to be handled.
	 */
	abstract void execute(HttpResponse response);

	/**
	 * @description Execution method of the finalizer. required by the interface.
	 *
	 * @param fc FinalizerContext Context object dependency injected by Salesforce.
	 */
	private void execute(FinalizerContext fc) {
		this.execute(this.response);
	}
}
