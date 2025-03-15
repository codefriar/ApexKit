**Implements**

HttpCalloutMock

## Fields

### `orderedResponses`

#### Signature

```apex
protected orderedResponses
```

#### Type

List&lt;HttpResponse&gt;

## Constructors

### `HttpCalloutMockFactory(code, status, bodyAsString, headers)`

`SUPPRESSWARNINGS`

This constructor builds the response that will be returned

#### Signature

```apex
public HttpCalloutMockFactory(Integer code, String status, String bodyAsString, Map<String,String> headers)
```

#### Parameters

| Name         | Type                     | Description                                               |
| ------------ | ------------------------ | --------------------------------------------------------- |
| code         | Integer                  | HTTP status code (200, 201, 301, 302, 400, 404, 503, etc) |
| status       | String                   | HTTP text status. ie: &quot;ok&quot; for 200              |
| bodyAsString | String                   | This is the string that will be returned as the body      |
| headers      | Map&lt;String,String&gt; | a map of headers applied to the response object           |

---

### `HttpCalloutMockFactory(orderedResponses)`

This constructor accepts a list of responses to be returned.

#### Signature

```apex
public HttpCalloutMockFactory(List<HttpResponse> orderedResponses)
```

#### Parameters

| Name             | Type                     | Description                                               |
| ---------------- | ------------------------ | --------------------------------------------------------- |
| orderedResponses | List&lt;HttpResponse&gt; | HTTP status code (200, 201, 301, 302, 400, 404, 503, etc) |

## Methods

### `respond(req)`

setMock can only be called once per test so to enable mocking
multiple callouts, this response method removes the first item on the list of
callouts, and returns that. additional callouts will respond with the next items
from the list.

#### Signature

```apex
public HttpResponse respond(HttpRequest req)
```

#### Parameters

| Name | Type        | Description                       |
| ---- | ----------- | --------------------------------- |
| req  | HttpRequest | dependency injected by the system |

#### Return Type

**HttpResponse**

HttpResponse

---

### `generateHttpResponse(code, status, bodyAsString, headers)`

`SUPPRESSWARNINGS`

Required method for the HttpCalloutMock interface

#### Signature

```apex
public static HttpResponse generateHttpResponse(Integer code, String status, String bodyAsString, Map<String,String> headers)
```

#### Parameters

| Name         | Type                     | Description                                                                 |
| ------------ | ------------------------ | --------------------------------------------------------------------------- |
| code         | Integer                  | Integer to return as the status code - 200, 301, 404 etc.                   |
| status       | String                   | String to return for the status: &#x27;OK&#x27; or &#x27;Server Error&#x27; |
| bodyAsString | String                   | String to return as the body                                                |
| headers      | Map&lt;String,String&gt; | Map&lt;String,String&gt; of headers to return                               |

#### Return Type

**HttpResponse**

,[object Object]
