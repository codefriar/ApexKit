@isTest
private class RestLibTests {
	/**
	 * @description Executes a positive test case of the Constructor.
	 * Expects the named credential to be set.
	 */
	@isTest
	private static void testConstructorPositive() {
		RestClient rc;

		Test.startTest();
		rc = new RestClient('dummyNamedCredential');
		Test.stopTest();

		Assert.areEqual(
			'dummyNamedCredential',
			rc.namedCredentialName,
			'Expected the name credential to match'
		);
	}

	/**
	 * @description Tests the fluent interface for RestLibApiCall with GET
	 */
	@isTest
	private static void testRestLibApiCallFluentInterface() {
		Test.startTest();
		RestLibApiCall apiCall = RestLibApiCall.create()
			.usingGet()
			.withPath('/test')
			.withQuery('param=value')
			.withHeader('Test-Header', 'TestValue');
		Test.stopTest();

		Assert.areEqual(HttpVerb.GET, apiCall.method, 'Method should be GET');
		Assert.areEqual(
			'/test/',
			apiCall.path,
			'Path should be /test/ with trailing slash'
		);
		Assert.areEqual(
			'param=value',
			apiCall.query,
			'Query should be set correctly'
		);
		Assert.isTrue(
			apiCall.functionalHeaders.containsKey('Test-Header'),
			'Custom header should be present'
		);
		Assert.areEqual(
			'TestValue',
			apiCall.functionalHeaders.get('Test-Header'),
			'Header value should match'
		);
	}

	/**
	 * @description Tests the fluent interface for RestLibApiCall with POST and body
	 */
	@isTest
	private static void testRestLibApiCallFluentInterfaceWithPost() {
		String testBody = '{"test":"value"}';

		Test.startTest();
		RestLibApiCall apiCall = RestLibApiCall.create()
			.usingPost()
			.withPath('/resource')
			.withBody(testBody)
			.withHeaders(
				new Map<String, String>{
					'Content-Type' => 'application/json',
					'X-Custom' => 'CustomValue'
				}
			);
		Test.stopTest();

		Assert.areEqual(HttpVerb.POST, apiCall.method, 'Method should be POST');
		Assert.areEqual(
			'/resource/',
			apiCall.path,
			'Path should be /resource/ with trailing slash'
		);
		Assert.areEqual(testBody, apiCall.body, 'Body should be set correctly');
		Assert.isTrue(apiCall.hasBody, 'hasBody should be true for POST with body');
		Assert.areEqual(
			'CustomValue',
			apiCall.functionalHeaders.get('X-Custom'),
			'Custom header should be set'
		);
		Assert.areEqual(
			'application/json',
			apiCall.functionalHeaders.get('Content-Type'),
			'Content-Type should be set'
		);
	}

	/**
	 * @description Tests the fluent interface for RestLibApiCall with PATCH (which is handled specially)
	 */
	@isTest
	private static void testRestLibApiCallFluentInterfaceWithPatch() {
		String testBody = '{"field":"newValue"}';

		Test.startTest();
		RestLibApiCall apiCall = RestLibApiCall.create()
			.usingPatch()
			.withPath('/resource/123')
			.withBody(testBody);
		Test.stopTest();

		// PATCH is converted to POST with special parameters
		Assert.areEqual(
			HttpVerb.POST,
			apiCall.method,
			'Method should be POST when using PATCH'
		);
		Assert.areEqual(
			'/resource/123/',
			apiCall.path,
			'Path should be correct with trailing slash'
		);
		Assert.areEqual(testBody, apiCall.body, 'Body should be set correctly');
		Assert.isTrue(
			apiCall.hasBody,
			'hasBody should be true for PATCH with body'
		);
		Assert.isTrue(
			apiCall.encodedQuery.contains('_HttpMethod=PATCH'),
			'Should have PATCH parameter in query'
		);
	}

	/**
	 * Note: we do not have a constructor test for the no param
	 * constructor. Because it's access modifier is protected
	 * we cannot use that constructor - the compiler throws an error
	 * noting the method is not visible
	 */

	/**
	 * @description Executes a positive test case against the RestClients'
	 * makeApiCall method, this time specifying all the method params
	 */
	@isTest
	private static void testStaticMakeApiCallFullParamsPositive() {
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = RestClient.makeApiCall(
			'DummyNamedCredential',
			new RestLibApiCall(HttpVerb.GET, '/', '', '', null)
		);
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected the return status code to be 200'
		);
	}

	@isTest
	private static void testStaticMakeApiCallNoHeadersOrBodyParamsPositive() {
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = RestClient.makeApiCall(
			'DummyNamedCredential',
			new RestLibApiCall(HttpVerb.GET, '/', '', '')
		);
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected the return status code to be 200'
		);
	}

	@isTest
	private static void testStaticMakeApiCallNoHeadersOrBodyOrQueryParamsPositive() {
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		RestLibApiCall call = new RestLibApiCall(HttpVerb.GET, '/', '', '');
		HttpResponse response = RestClient.makeApiCall(
			'DummyNamedCredential',
			call
		);
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected the return status code to be 200'
		);
	}

	/**
	 * Convenience, Instance Methods
	 * These 6 methods are not utilized by our API service
	 * class.
	 */

	/**
	 * @description Positive test case for convenience method needing only
	 * path and query params.
	 */
	@isTest
	private static void testGetWithPathAndQueryPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.get('/', '?test');
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected to get the 200 response code'
		);
	}

	/**
	 * @description Positive test case for convenience method needing only
	 * path and query params.
	 */
	@isTest
	private static void testGetWithPathPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.get('/');
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected to get the 200 response code'
		);
	}

	@isTest
	private static void testDelWithPathPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.del('/');
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected to get the 200 response code'
		);
	}

	@isTest
	private static void testDelWithPathAndQueryPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			200,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.del('/', 'foo');
		Test.stopTest();

		Assert.areEqual(
			200,
			response.getStatusCode(),
			'Expected to get the 200 response code'
		);
	}

	@isTest
	private static void testPostWithPathAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.post('/', '{"Id": "003ae3fn12df25k309"}');
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testPostWithPathQueryAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.post('/', '', '{"Id": "003ae3fn12df25k309"}');
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testPutWithPathAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.put('/', '{"Id": "003ae3fn12df25k309"}');
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testPutWithPathQueryAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.put('/', '', '{"Id": "003ae3fn12df25k309"}');
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testPatchWithPathQueryAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.patch(
			'/',
			'q=foo',
			'{"Id": "003ae3fn12df25k309"}'
		);
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testPatchWithPathAndBodyPositive() {
		RestClientLib rc = new RestClientLib('DummyNamedCredential');
		HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
			201,
			'OK',
			'OK',
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		HttpResponse response = rc.patch('/', '{"Id": "003ae3fn12df25k309"}');
		Test.stopTest();

		Assert.areEqual(
			201,
			response.getStatusCode(),
			'Expected to get the 201 response code'
		);
	}

	@isTest
	private static void testProtectedRestLibConstructorPositive() {
		RestLib rl = new RestLib();
		Assert.areNotEqual(null, rl, 'Expected the RestLib to be created');
	}

	@isTest
	private static void testEnsureStringEndsInSlashPositiveStartWithoutSlash() {
		RestLibApiCall rlac = new RestLibApiCall();
		Test.startTest();
		String result = RestLibApiCall.ensureStringEndsInSlash('noSlash');
		Test.stopTest();
		Assert.isTrue(
			result.endsWith('/'),
			'Expected the result to end with a slash'
		);
	}
}
