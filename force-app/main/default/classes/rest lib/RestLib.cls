public with sharing virtual class RestLib {
	/**
	 * @description The name of the Named Credential to use
	 */
	@testVisible
	protected String namedCredentialName { get; set; }

	/**
	 * @description Constructor that sets Named Credential
	 * @param  namedCredential name of the Named Credential to use
	 */
	public RestLib(String namedCredential) {
		this.namedCredentialName = namedCredential;
	}

	/**
	 * @description This constructor isn't intended for use, which is why it's
	 * access modifier is 'Protected'. However, any child class extending
	 * this class will either have to implement constructors matching the one
	 * above, or this constructor must exist. In order to make this abstraction
	 * as useful as possible, we've elected to leave this constructor here,
	 * but unavailable to anything but inner classes and classes that
	 * extend this one.
	 */
	@testVisible
	@SuppressWarnings('PMD.EmptyStatementBlock')
	protected RestLib() {
	}

	/**
	 * @description Omnibus callout method. This is the primary method for
	 * making a REST callout. Most of the other methods in this class serve
	 * as convenient, syntactic sugar on this method.
	 * @param   method Enum HTTP verb to use. i.e. GET
	 * @param   path patch component of the callout url i.e. `/services/data/v39.0/SObjects`
	 * @param   query Query portion of the URL i.e. `?q=SELECT Id FROM Account`
	 * @param   body JSON string representing the body of the callout in post/patch situations
	 * @param   headers A map<String,String> of headers to use while making this callout
	 * @return HttpResponse  HttpResponse Obj
	 */
	@testVisible
	@SuppressWarnings('PMD.ExcessiveParameterList')
	protected HttpResponse makeApiCall(RestLibApiCall apiCall) {
		HttpRequest apiRequest = new HttpRequest();
		if (apiCall.method == HttpVerb.DEL) {
			apiRequest.setMethod('DELETE');
		} else {
			apiRequest.setMethod(String.valueOf(apiCall.method));
		}
		for (String header : apiCall.functionalHeaders.keySet()) {
			apiRequest.setHeader(header, apiCall.functionalHeaders.get(header));
		}
		if (apiCall.hasBody) {
			apiRequest.setBody(apiCall.body);
		}
		apiRequest.setEndpoint(
			'callout:' +
				this.namedCredentialName +
				apiCall.path +
				apiCall.encodedQuery
		);
		Http http = new Http();
		return http.send(apiRequest);
	}
}