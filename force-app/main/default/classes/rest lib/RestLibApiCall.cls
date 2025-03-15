/**
 * @description This class encapsulates the information needed to make a callout except the endpoint which is
 * specified by named credential in other RestLib classes.
 */
public with sharing class RestLibApiCall {
	/**
	 * @description The default headers to use, when none are specified
	 */
	public static Map<String, String> defaultHeaders = new Map<String, String>{
		'Content-Type' => 'application/json',
		'Accept' => 'application/json'
	};

	/**
	 * @description The default timeout value in milliseconds
	 */
	public static final Integer DEFAULT_TIMEOUT = 120000;

	/**
	 * @description stores the httpverb defined in the enum
	 */
	private HttpVerb methodValue;
	public HttpVerb method {
		get {
			return methodValue;
		}
		private set {
			methodValue = value;
		}
	}

	/**
	 * @description Returns the string representation of the HTTP method
	 * @return String representation of the HTTP method (returns 'DELETE' for DEL)
	 */
	public String methodString {
		get {
			if (method == HttpVerb.DEL) {
				return 'DELETE';
			}
			return method.name();
		}
	}
	/**
	 * @description Stores the path to the resource
	 */
	private String pathValue;
	public String path {
		get {
			if (String.isBlank(pathValue)) {
				return '/';
			}
			return pathValue.startsWith('/') ? pathValue : '/' + pathValue;
		}
		private set {
			pathValue = value;
		}
	}
	/**
	 * @description stores the encoded URL parameters
	 */
	private String encodedQueryValue;
	public String encodedQuery {
		get {
			if (String.isBlank(encodedQueryValue)) {
				return null;
			}
			return encodedQueryValue.startsWith('?')
				? encodedQueryValue
				: '?' + encodedQueryValue;
		}
		private set {
			encodedQueryValue = value;
		}
	}
	/**
	 * @description The query string to be appended to the path
	 */
	private String queryValue;
	public String query {
		get {
			return queryValue;
		}
		private set {
			queryValue = value;
		}
	}

	/**
	 * @description stores the timeout value in milliseconds
	 */
	private Integer timeoutValue;
	public Integer timeout {
		get {
			return timeoutValue != null ? timeoutValue : DEFAULT_TIMEOUT;
		}
		private set {
			timeoutValue = value;
		}
	}
	/**
	 * @description body the string encoded body to be included in the request
	 */
	private String bodyValue;
	public String body {
		get {
			return bodyValue;
		}
		private set {
			bodyValue = value;
		}
	}
	/**
	 * @description Property returning true if there is a body and the method is POST or PUT
	 */
	public Boolean hasBody {
		get {
			return String.isNotBlank(bodyValue) &&
				(methodValue == HttpVerb.POST ||
				methodValue == HttpVerb.PUT);
		}
	}
	private Map<String, String> headersValue;
	final Map<String, String> headers {
		get {
			return headersValue;
		}
		private set {
			headersValue = value;
		}
	}

	/**
	 * @description Returns headers with default values when none are specified
	 * @return Map of headers with defaults applied when necessary
	 */
	public Map<String, String> functionalHeaders {
		get {
			if (headersValue == null) {
				return RestLibApiCall.defaultHeaders;
			}
			return headersValue;
		}
	}

	@testVisible
	// prettier-ignore
	private RestLibApiCall() {} // NOPMD

	/**
	 * @description Creates a new instance for a fluent API call
	 * @return A new RestLibApiCall instance for fluent chaining
	 */
	public static RestLibApiCall create() {
		return new RestLibApiCall();
	}

	/**
	 * @description Sets the HTTP method for this API call
	 * @param method HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withMethod(HttpVerb method) {
		this.methodValue = method;
		if (method == HttpVerb.PATCH) {
			// Handle PATCH as POST with custom parameter
			this.methodValue = HttpVerb.POST;
			if (this.encodedQueryValue == null) {
				this.encodedQueryValue = '?_HttpMethod=PATCH';
			} else {
				this.encodedQueryValue += '?_HttpMethod=PATCH';
			}
		}
		return this;
	}

	/**
	 * @description Convenience method to set HTTP method to GET
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingGet() {
		return withMethod(HttpVerb.GET);
	}

	/**
	 * @description Convenience method to set HTTP method to POST
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingPost() {
		return withMethod(HttpVerb.POST);
	}

	/**
	 * @description Convenience method to set HTTP method to PUT
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingPut() {
		return withMethod(HttpVerb.PUT);
	}

	/**
	 * @description Convenience method to set HTTP method to PATCH
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingPatch() {
		return withMethod(HttpVerb.PATCH);
	}

	/**
	 * @description Convenience method to set HTTP method to DELETE
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingDelete() {
		return withMethod(HttpVerb.DEL);
	}

	/**
	 * @description Convenience method to set HTTP method to HEAD
	 * @return The current instance for chaining
	 */
	public RestLibApiCall usingHead() {
		return withMethod(HttpVerb.HEAD);
	}

	/**
	 * @description Sets the path for this API call
	 * @param path String of the path to the resource
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withPath(String path) {
		this.pathValue = ensureStringEndsInSlash(path);
		return this;
	}

	/**
	 * @description Sets the query parameters for this API call
	 * @param query String of the query parameters to be appended to the path
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withQuery(String query) {
		this.queryValue = query;
		this.encodedQueryValue = EncodingUtil.urlEncode(query, 'UTF-8');
		return this;
	}

	/**
	 * @description Sets the body for this API call
	 * @param body String of the body to be sent with the request
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withBody(String body) {
		this.bodyValue = body;
		return this;
	}

	/**
	 * @description Sets the headers for this API call
	 * @param headers Map<String, String> of the headers to be sent with the request
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withHeaders(Map<String, String> headers) {
		this.headersValue = headers;
		return this;
	}

	/**
	 * @description Adds a single header to the existing headers
	 * @param key The header key
	 * @param value The header value
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withHeader(String key, String value) {
		if (this.headersValue == null) {
			this.headersValue = new Map<String, String>();
		}
		this.headersValue.put(key, value);
		return this;
	}

	/**
	 * @description Sets the timeout for this API call
	 * @param timeout Integer timeout value in milliseconds
	 * @return The current instance for chaining
	 */
	public RestLibApiCall withTimeout(Integer timeout) {
		this.timeout = timeout;
		return this;
	}

	/**
	 * @description Basic constructor that builds an instance with the necessary information to make a callout.
	 *
	 * @param method HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL
	 * @param path String of the path to the resource
	 * @param query String of the query parameters to be appended to the path
	 * @param body String of the body to be sent with the request
	 * @param headers Map<String, String> of the headers to be sent with the request
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
	public RestLibApiCall(
		HttpVerb method,
		String path,
		String query,
		String body,
		Map<String, String> headers
	) {
		this.methodValue = method;
		this.pathValue = ensureStringEndsInSlash(path);
		this.queryValue = query;
		this.bodyValue = body;
		this.headersValue = headers;

		this.encodedQueryValue = EncodingUtil.urlEncode(query, 'UTF-8');
		if (method == HttpVerb.PATCH) {
			this.methodValue = HttpVerb.POST;
			this.encodedQueryValue += '?_HttpMethod=PATCH';
		}
	}

	/**
	 * @description Basic constructor that builds an instance with the necessary information to make a callout.
	 *
	 * @param method HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL
	 * @param path String of the path to the resource
	 * @param query String of the query parameters to be appended to the path
	 * @param body String of the body to be sent with the request
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
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
	@TestVisible
	private static String ensureStringEndsInSlash(String resource) {
		if (resource.endsWith('/')) {
			return resource;
		}
		return resource + '/';
	}
}
