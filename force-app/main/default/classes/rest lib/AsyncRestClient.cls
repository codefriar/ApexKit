public with sharing class AsyncRestClient implements System.Queueable, Database.AllowsCallouts {
	private String namedCredentialName;
	private RestLibApiCall apiCall;
	private Type handlerClass;

	public AsyncRestClient(
		String NamedCredentialName,
		RestLibApiCall apiCall,
		Type handlerClass
	) {
		this.NamedCredentialName = NamedCredentialName;
		this.apiCall = apiCall;
		this.handlerClass = handlerClass;
	}

	public void execute(QueueableContext qc) {
		AsyncRestLibFinalizer theFinalizer = (AsyncRestLibFinalizer) handlerClass.newInstance();
		theFinalizer.response = RestClient.makeApiCall(
			this.namedCredentialName,
			apiCall
		);
		System.attachFinalizer(theFinalizer);
	}
}