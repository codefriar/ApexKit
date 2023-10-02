/**
 * @description wraps a restlib backed api call in a queueable context
 */
public with sharing class AsyncRestClient implements System.Queueable, Database.AllowsCallouts {
	/**
	 * @description the named credential to use for the api call
	 */
	private final String namedCredentialName;

	/**
	 * @description The RestLibApiCall that describes your callout
	 */
	private final RestLibApiCall apiCall;

	/**
	 * @description The handler class to instantiate to handle the response
	 */
	private final Type handlerClass;

	/**
	 * @description Default constructor
	 *
	 * @param namedCredentialName String representing the named credential to use
	 * @param apiCall RestLibApiCall The RestLibApiCall that describes your callout
	 * @param handlerClass Type a type reference to the finalizer to be used.
	 */
	public AsyncRestClient(
		String namedCredentialName,
		RestLibApiCall apiCall,
		Type handlerClass
	) {
		this.namedCredentialName = namedCredentialName;
		this.apiCall = apiCall;
		this.handlerClass = handlerClass;
	}

	/**
	 * @description This method will be executed by the Queueable system and is responsible for making the Api call.
	 * The finalizer is attached according to the passed in handlerClass
	 *
	 * @param qc QueueableContext Dependency Injected by the Queueable system
	 */
	public void execute(QueueableContext qc) {
		AsyncRestLibFinalizer theFinalizer = (AsyncRestLibFinalizer) handlerClass.newInstance();
		theFinalizer.response = RestClient.makeApiCall(
			this.namedCredentialName,
			apiCall
		);
		System.attachFinalizer(theFinalizer);
	}
}
