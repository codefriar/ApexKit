/**
 * @description A virtual class for making REST API calls
 */
public virtual class RestClient extends RestLib {
	/**
	 * @description Constructor for the RestClient class.
	 *
	 * @param namedCredentialName String value of the named credential to use
	 */
	public RestClient(String namedCredentialName) {
		super(namedCredentialName);
	}

	/**
	 * @description A static wrapper for the main makeApiCall method
	 *
	 * @param namedCredential The named credential to use
	 * @param apiCall HTTPVerb enum value. See Enum above
	 *
	 * @return `HTTPResponse`
	 *
	 * @example
	 * Log.get().publish(RestClient.makeApiCall(new RestLibApiCall('MockBin',
	 *                                      RestClient.HttpVerb.GET,
	 *                                      '4cb453a6-a23b-42ea-a6ba-9be1c1f17050',
	 *                                      '',
	 *                                      '',
	 *                                      new Map<String,String>())));
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public static HttpResponse makeApiCall(
		String namedCredential,
		RestLibApiCall apiCall
	) {
		return new RestClient(namedCredential).makeApiCall(apiCall);
	}
}
