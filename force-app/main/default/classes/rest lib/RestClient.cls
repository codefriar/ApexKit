public virtual class RestClient extends RestLib {
	public RestClient(String namedCredentialName) {
		super(namedCredentialName);
	}

	/**
	 * @description           A static wrapper for the main makeApiCall method
	 * @param namedCredential The named credential to use
	 * @param method          HTTPVerb enum value. See Enum above
	 * @param path           Http path component of the URL. ie: `/path/to/resource`
	 * @param query           Query component of the URL ie: after `?foo=bar`
	 * @param body            JSON string to post
	 * @param headers         Map<String,String> representing outgoing Request
	 * headers
	 * @return               `HTTPResponse`
	 * @example
	 * Log.get().publish(RestClient.makeApiCall('MockBin',
	 *                                      RestClient.HttpVerb.GET,
	 *                                      '4cb453a6-a23b-42ea-a6ba-9be1c1f17050',
	 *                                      '',
	 *                                      '',
	 *                                      new Map<String,String>()));
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public static HttpResponse makeApiCall(
		String namedCredential,
		RestLibApiCall apiCall
	) {
		return new RestClient(namedCredential).makeApiCall(apiCall);
	}
}