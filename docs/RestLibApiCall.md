`STATUS: ACTIVE`

This class encapsulates the information needed to make a callout except the endpoint which is
specified by named credential in other RestLib classes.

## Constructors

### `private RestLibApiCall()`

`TESTVISIBLE`

### `public RestLibApiCall(HttpVerb method, String path, String query, String body, Map<String,String> headers)`

`SUPPRESSWARNINGS`

Basic constructor that builds an instance with the necessary information to make a callout.

#### Parameters

| Param     | Description                                                    |
| --------- | -------------------------------------------------------------- |
| `method`  | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL             |
| `path`    | String of the path to the resource                             |
| `query`   | String of the query parameters to be appended to the path      |
| `body`    | String of the body to be sent with the request                 |
| `headers` | Map<String, String> of the headers to be sent with the request |

### `public RestLibApiCall(HttpVerb method, String path, String query, String body)`

`SUPPRESSWARNINGS`

Basic constructor that builds an instance with the necessary information to make a callout.

#### Parameters

| Param    | Description                                               |
| -------- | --------------------------------------------------------- |
| `method` | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL        |
| `path`   | String of the path to the resource                        |
| `query`  | String of the query parameters to be appended to the path |
| `body`   | String of the body to be sent with the request            |

---

## Fields

### `public defaultHeaders` → `Map<String,String>`

The default headers to use, when none are specified

---

## Properties

### `public body` → `String`

body the string encoded body to be included in the request

### `public encodedQuery` → `String`

stores the encoded URL parameters

### `public functionalHeaders` → `Map<String,String>`

### `public hasBody` → `Boolean`

Property returning true if there is a body and the method is POST or PUT

### `private headers` → `Map<String,String>`

### `public method` → `HttpVerb`

stores the httpverb defined in the enum

### `public path` → `String`

Stores the path to the resource

### `public query` → `String`

The query string to be appended to the path

---

## Methods

### `public static RestLibApiCall create()`

Creates a new instance for a fluent API call.

#### Returns

| Type           | Description                                       |
| -------------- | ------------------------------------------------- |
| RestLibApiCall | A new RestLibApiCall instance for fluent chaining |

### `public RestLibApiCall withMethod(HttpVerb method)`

Sets the HTTP method for this API call.

#### Parameters

| Param    | Description                                        |
| -------- | -------------------------------------------------- |
| `method` | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingGet()`

Convenience method to set HTTP method to GET.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingPost()`

Convenience method to set HTTP method to POST.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingPut()`

Convenience method to set HTTP method to PUT.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingPatch()`

Convenience method to set HTTP method to PATCH.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingDelete()`

Convenience method to set HTTP method to DELETE.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall usingHead()`

Convenience method to set HTTP method to HEAD.

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall withPath(String path)`

Sets the path for this API call.

#### Parameters

| Param  | Description                        |
| ------ | ---------------------------------- |
| `path` | String of the path to the resource |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall withQuery(String query)`

Sets the query parameters for this API call.

#### Parameters

| Param   | Description                                               |
| ------- | --------------------------------------------------------- |
| `query` | String of the query parameters to be appended to the path |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall withBody(String body)`

Sets the body for this API call.

#### Parameters

| Param  | Description                                    |
| ------ | ---------------------------------------------- |
| `body` | String of the body to be sent with the request |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall withHeaders(Map<String, String> headers)`

Sets the headers for this API call.

#### Parameters

| Param     | Description                                                    |
| --------- | -------------------------------------------------------------- |
| `headers` | Map<String, String> of the headers to be sent with the request |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `public RestLibApiCall withHeader(String key, String value)`

Adds a single header to the existing headers.

#### Parameters

| Param   | Description      |
| ------- | ---------------- |
| `key`   | The header key   |
| `value` | The header value |

#### Returns

| Type           | Description                       |
| -------------- | --------------------------------- |
| RestLibApiCall | The current instance for chaining |

### `private static String ensureStringEndsInSlash(String resource)`

`TESTVISIBLE`

Ensures that the inputted string ends in a `/` makes callouts more robust.

#### Parameters

| Param      | Description                  |
| ---------- | ---------------------------- |
| `resource` | string to ensure ends in `/` |

#### Returns

| Type   | Description                                               |
| ------ | --------------------------------------------------------- |
| String | inputted string with `/` if it didn't already end in one. |

## Usage Examples

### Basic GET Request

```apex
RestLibApiCall apiCall = RestLibApiCall.create()
    .usingGet()
    .withPath('/accounts')
    .withQuery('limit=10');

HttpResponse response = RestClient.makeApiCall('MyNamedCredential', apiCall);
```

### POST with Body and Custom Headers

```apex
RestLibApiCall apiCall = RestLibApiCall.create()
    .usingPost()
    .withPath('/accounts')
    .withBody(JSON.serialize(newAccount))
    .withHeader('X-Custom-Header', 'CustomValue');

HttpResponse response = RestClient.makeApiCall('MyNamedCredential', apiCall);
```

### PATCH Request

```apex
RestLibApiCall apiCall = RestLibApiCall.create()
    .usingPatch()
    .withPath('/accounts/001xx000003DGb2AAG')
    .withBody(JSON.serialize(accountUpdates));

HttpResponse response = RestClient.makeApiCall('MyNamedCredential', apiCall);
```

---
