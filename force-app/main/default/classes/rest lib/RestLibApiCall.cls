public with sharing class RestLibApiCall {
	/**
	 * @description The default headers to use, when none are specified
	 */
	@testVisible
	public static Map<String, String> defaultHeaders = new Map<String, String>{
		'Content-Type' => 'application/json',
		'Accept' => 'application/json'
	};

	public HttpVerb method { get; private set; }
	public String path { get; private set; }
	public String encodedQuery { get; private set; }
	public String query { get; private set; }
	public String body { get; private set; }
	public Boolean hasBody {
		get {
			return String.isNotBlank(body) &&
				(method == HttpVerb.POST ||
				method == HttpVerb.PUT);
		}
	}
	Map<String, String> headers { get; private set; }
	public Map<String, String> functionalHeaders {
		get {
			if (headers == null) {
				return RestLibApiCall.defaultHeaders;
			}
			return headers;
		}
	}

	@testVisible
	private RestLibApiCall() {
	}

	public RestLibApiCall(
		HttpVerb method,
		String path,
		String query,
		String body,
		Map<String, String> headers
	) {
		this.method = method;
		this.path = ensureStringEndsInSlash(path);
		this.query = query;
		this.body = body;
		this.headers = headers;

		this.encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
		if (method == HttpVerb.PATCH) {
			method = HttpVerb.POST;
			encodedQuery += '?_HttpMethod=PATCH';
		}
	}

	public RestLibApiCall(
		HttpVerb method,
		String path,
		String query,
		String body
	) {
		this(method, path, query, body, RestLibApiCall.defaultHeaders);
	}

	// Private Helper Methods
	/**
	 * @description Ensures that the inputted string ends in a `/`
	 * makes callouts more robust.
	 * @param   resource string to ensure ends in `/`
	 * @return  inputted string with `/` if it didn't already end in one.
	 */
	@testVisible
	private String ensureStringEndsInSlash(String resource) {
		if (resource.endsWith('/')) {
			return resource;
		}
		return resource + '/';
	}
}