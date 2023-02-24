public with sharing virtual class RestClientLib extends RestClient {
	public RestClientLib(String namedCredentialName) {
		super(namedCredentialName);
	}

	/**
	 * @description  Makes an HTTP Callout to an api resource.
	 * Convenience method that assumes the Default Headers.
	 * @param method HTTPVerb to use. See the enum above.
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @param body   Body to send with this call.
	 * @return      `HttpResponse`
	 */
	@testVisible
	@SuppressWarnings('PMD.ExcessiveParameterList')
	protected HttpResponse makeApiCall(
		HttpVerb method,
		String path,
		String query,
		String body
	) {
		return this.makeApiCall(new RestLibApiCall(method, path, query, body));
	}

	/**
	 * @description  convenience version of makeApiCall without body param.
	 * Invokes omnibus version above, with blank body param and default headers.
	 * @param method HTTPVerb to use. See the enum above.
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @return      `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse makeApiCall(
		HttpVerb method,
		String path,
		String query
	) {
		return this.makeApiCall(new RestLibApiCall(method, path, query, ''));
	}

	/**
	 * @description  convenience version of makeApiCall without body or query
	 * params.
	 * Invokes omnibus version above, with blank body and query params
	 * @param method HTTPVerb to use. See the enum above.
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @return      `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse makeApiCall(HttpVerb method, String path) {
		return this.makeApiCall(new RestLibApiCall(method, path, '', ''));
	}

	/**
	 * @description convenience method for a GET Call that only requires a path
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse get(String path) {
		return this.makeApiCall(HttpVerb.GET, path);
	}

	/**
	 * @description convenience method for a GET Call that only requires a path
	 * and query
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse get(String path, String query) {
		return this.makeApiCall(HttpVerb.GET, path, query);
	}

	/**
	 * @description convenience method for deleting a resource based only on
	 * path
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse del(String path) {
		return this.makeApiCall(HttpVerb.DEL, path);
	}

	/**
	 * @description convenience method for a Delete Call that only requires a
	 * path and query
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse del(String path, String query) {
		return this.makeApiCall(HttpVerb.DEL, path, query);
	}

	/**
	 * @description convenience method for a POST Call that only requires a path
	 * and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse post(String path, String body) {
		return this.makeApiCall(HttpVerb.POST, path, '', body);
	}

	/**
	 * @description convenience method for a POST Call that only requires a
	 * path, query and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse post(String path, String query, String body) {
		return this.makeApiCall(HttpVerb.POST, path, query, body);
	}

	/**
	 * @description convenience method for a PUT Call that only requires a path
	 * and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse put(String path, String body) {
		return this.makeApiCall(HttpVerb.PUT, path, '', body);
	}

	/**
	 * @description convenience method for a PUT Call that only requires a path,
	 * query and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse put(String path, String query, String body) {
		return this.makeApiCall(HttpVerb.PUT, path, query, body);
	}

	/**
	 * @description convenience method for a PATCH Call that only requires a
	 * path and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse patch(String path, String body) {
		return this.makeApiCall(HttpVerb.PATCH, path, '', body);
	}

	/**
	 * @description convenience method for a PATCH Call that only requires a
	 * path, query and body
	 * @param path   Http path component of the URL. ie: `/path/to/resource`
	 * @param query  Query component of the URL ie: after `?foo=bar`
	 * @param body   JSON string to post
	 * @return     `HTTPResponse`
	 */
	@testVisible
	protected HttpResponse patch(String path, String query, String body) {
		return this.makeApiCall(HttpVerb.PATCH, path, query, body);
	}
}