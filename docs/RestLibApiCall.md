specified by named credential in other RestLib classes.

## Fields

### `defaultHeaders`

The default headers to use, when none are specified

#### Signature

```apex
public static defaultHeaders
```

#### Type

Map&lt;String,String&gt;

---

### `DEFAULT_TIMEOUT`

The default timeout value in milliseconds

#### Signature

```apex
public static final DEFAULT_TIMEOUT
```

#### Type

Integer

---

### `methodValue`

stores the http verb defined in the enum

#### Signature

```apex
private methodValue
```

#### Type

[HttpVerb](HttpVerb.md)

---

### `pathValue`

Stores the path to the resource

#### Signature

```apex
private pathValue
```

#### Type

String

---

### `encodedQueryValue`

stores the encoded URL parameters

#### Signature

```apex
private encodedQueryValue
```

#### Type

String

---

### `queryValue`

The query string to be appended to the path

#### Signature

```apex
private queryValue
```

#### Type

String

---

### `timeoutValue`

stores the timeout value in milliseconds

#### Signature

```apex
private timeoutValue
```

#### Type

Integer

---

### `bodyValue`

body the string encoded body to be included in the request

#### Signature

```apex
private bodyValue
```

#### Type

String

---

### `headersValue`

#### Signature

```apex
private headersValue
```

#### Type

Map&lt;String,String&gt;

## Properties

### `method`

#### Signature

```apex
public method
```

#### Type

[HttpVerb](HttpVerb.md)

---

### `methodString`

Returns the string representation of the HTTP method

#### Signature

```apex
public methodString
```

#### Type

String

---

### `path`

#### Signature

```apex
public path
```

#### Type

String

---

### `encodedQuery`

#### Signature

```apex
public encodedQuery
```

#### Type

String

---

### `query`

#### Signature

```apex
public query
```

#### Type

String

---

### `timeout`

#### Signature

```apex
public timeout
```

#### Type

Integer

---

### `body`

#### Signature

```apex
public body
```

#### Type

String

---

### `hasBody`

Property returning true if there is a body and the method is POST or PUT

#### Signature

```apex
public hasBody
```

#### Type

Boolean

---

### `headers`

#### Signature

```apex
private final headers
```

#### Type

Map&lt;String,String&gt;

---

### `functionalHeaders`

Returns headers with default values when none are specified

#### Signature

```apex
public functionalHeaders
```

#### Type

Map&lt;String,String&gt;

## Constructors

### `RestLibApiCall()`

`TESTVISIBLE`

#### Signature

```apex
private RestLibApiCall()
```

---

### `RestLibApiCall(method, path, query, body, headers)`

`SUPPRESSWARNINGS`

Basic constructor that builds an instance with the necessary information to make a callout.

#### Signature

```apex
public RestLibApiCall(HttpVerb method, String path, String query, String body, Map<String,String> headers)
```

#### Parameters

| Name    | Type                     | Description                                                          |
| ------- | ------------------------ | -------------------------------------------------------------------- |
| method  | [HttpVerb](HttpVerb.md)  | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL                   |
| path    | String                   | String of the path to the resource                                   |
| query   | String                   | String of the query parameters to be appended to the path            |
| body    | String                   | String of the body to be sent with the request                       |
| headers | Map&lt;String,String&gt; | Map&lt;String, String&gt; of the headers to be sent with the request |

---

### `RestLibApiCall(method, path, query, body)`

`SUPPRESSWARNINGS`

Basic constructor that builds an instance with the necessary information to make a callout.

#### Signature

```apex
public RestLibApiCall(HttpVerb method, String path, String query, String body)
```

#### Parameters

| Name   | Type                    | Description                                               |
| ------ | ----------------------- | --------------------------------------------------------- |
| method | [HttpVerb](HttpVerb.md) | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL        |
| path   | String                  | String of the path to the resource                        |
| query  | String                  | String of the query parameters to be appended to the path |
| body   | String                  | String of the body to be sent with the request            |

## Methods

### `create()`

Creates a new instance for a fluent API call

#### Signature

```apex
public static RestLibApiCall create()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

A new RestLibApiCall instance for fluent chaining

---

### `withMethod(method)`

Sets the HTTP method for this API call

#### Signature

```apex
public RestLibApiCall withMethod(HttpVerb method)
```

#### Parameters

| Name   | Type                    | Description                                        |
| ------ | ----------------------- | -------------------------------------------------- |
| method | [HttpVerb](HttpVerb.md) | HttpVerb enum value ie: GET, POST, PUT, PATCH, DEL |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingGet()`

Convenience method to set HTTP method to GET

#### Signature

```apex
public RestLibApiCall usingGet()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingPost()`

Convenience method to set HTTP method to POST

#### Signature

```apex
public RestLibApiCall usingPost()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingPut()`

Convenience method to set HTTP method to PUT

#### Signature

```apex
public RestLibApiCall usingPut()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingPatch()`

Convenience method to set HTTP method to PATCH

#### Signature

```apex
public RestLibApiCall usingPatch()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingDelete()`

Convenience method to set HTTP method to DELETE

#### Signature

```apex
public RestLibApiCall usingDelete()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `usingHead()`

Convenience method to set HTTP method to HEAD

#### Signature

```apex
public RestLibApiCall usingHead()
```

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withPath(path)`

Sets the path for this API call

#### Signature

```apex
public RestLibApiCall withPath(String path)
```

#### Parameters

| Name | Type   | Description                        |
| ---- | ------ | ---------------------------------- |
| path | String | String of the path to the resource |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withQuery(query)`

Sets the query parameters for this API call

#### Signature

```apex
public RestLibApiCall withQuery(String query)
```

#### Parameters

| Name  | Type   | Description                                               |
| ----- | ------ | --------------------------------------------------------- |
| query | String | String of the query parameters to be appended to the path |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withBody(body)`

Sets the body for this API call

#### Signature

```apex
public RestLibApiCall withBody(String body)
```

#### Parameters

| Name | Type   | Description                                    |
| ---- | ------ | ---------------------------------------------- |
| body | String | String of the body to be sent with the request |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withHeaders(headers)`

Sets the headers for this API call

#### Signature

```apex
public RestLibApiCall withHeaders(Map<String,String> headers)
```

#### Parameters

| Name    | Type                     | Description                                                          |
| ------- | ------------------------ | -------------------------------------------------------------------- |
| headers | Map&lt;String,String&gt; | Map&lt;String, String&gt; of the headers to be sent with the request |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withHeader(key, value)`

Adds a single header to the existing headers

#### Signature

```apex
public RestLibApiCall withHeader(String key, String value)
```

#### Parameters

| Name  | Type   | Description      |
| ----- | ------ | ---------------- |
| key   | String | The header key   |
| value | String | The header value |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `withTimeout(timeout)`

Sets the timeout for this API call

#### Signature

```apex
public RestLibApiCall withTimeout(Integer timeout)
```

#### Parameters

| Name    | Type    | Description                           |
| ------- | ------- | ------------------------------------- |
| timeout | Integer | Integer timeout value in milliseconds |

#### Return Type

**[RestLibApiCall](RestLibApiCall.md)**

The current instance for chaining

---

### `ensureStringEndsInSlash(resource)`

`TESTVISIBLE`

Ensures that the inputted string ends in a `/`
makes callouts more robust.

#### Signature

```apex
private static String ensureStringEndsInSlash(String resource)
```

#### Parameters

| Name     | Type   | Description                  |
| -------- | ------ | ---------------------------- |
| resource | String | string to ensure ends in `/` |

#### Return Type

**String**

inputted string with ,[object Object], if it didn&#x27;t already end in one.
