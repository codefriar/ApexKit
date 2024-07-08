`APIVERSION: 58`

`STATUS: ACTIVE`

**Implemented types**

[HttpCalloutMock](HttpCalloutMock)

## Constructors

### `public HttpCalloutMockFactory(Integer code, String status, String bodyAsString, Map<String,String> headers)`

`SUPPRESSWARNINGS`

This constructor builds the response that will be returned

#### Parameters

| Param          | Description                                               |
| -------------- | --------------------------------------------------------- |
| `code`         | HTTP status code (200, 201, 301, 302, 400, 404, 503, etc) |
| `status`       | HTTP text status. ie: "ok" for 200                        |
| `bodyAsString` | This is the string that will be returned as the body      |
| `headers`      | a map of headers applied to the response object           |

### `public HttpCalloutMockFactory(List<HttpResponse> orderedResponses)`

This constructor accepts a list of responses to be returned.

#### Parameters

| Param              | Description                                               |
| ------------------ | --------------------------------------------------------- |
| `orderedResponses` | HTTP status code (200, 201, 301, 302, 400, 404, 503, etc) |

---

## Fields

### `protected orderedResponses` → `List<HttpResponse>`

---

## Methods

### `public HttpResponse respond(HttpRequest req)`

setMock can only be called once per test so to enable mocking multiple callouts, this response method removes the first item on the list of callouts, and returns that. additional callouts will respond with the next items from the list.

#### Parameters

| Param | Description                       |
| ----- | --------------------------------- |
| `req` | dependency injected by the system |

#### Returns

| Type           | Description  |
| -------------- | ------------ |
| `HttpResponse` | HttpResponse |

### `public static HttpResponse generateHttpResponse(Integer code, String status, String bodyAsString, Map<String,String> headers)`

`SUPPRESSWARNINGS`

Required method for the HttpCalloutMock interface

#### Parameters

| Param          | Description                                               |
| -------------- | --------------------------------------------------------- |
| `code`         | Integer to return as the status code - 200, 301, 404 etc. |
| `status`       | String to return for the status: 'OK' or 'Server Error'   |
| `bodyAsString` | String to return as the body                              |
| `headers`      | Map<String,String> of headers to return                   |

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `HttpResponse` | `HttpResponse` |

---
