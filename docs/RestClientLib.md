`STATUS: ACTIVE`

This class is a wrapper around the RestLib class that is intended to be extended by developers
to provide a quick, safe, and reliable way of making REST callouts. By extending this class you're locking your
class to a specific Named Credential, which is a best practice for making callouts, and you're inheriting methods
like `get`, `post`, `put`, `patch`, and `del` that make it easy to make callouts without having to worry about
setting headers, or other common tasks.

**Inheritance**

[RestLib](https://github.com/codefriar/ApexKit/wiki/RestLib)
&gt;
[RestClient](https://github.com/codefriar/ApexKit/wiki/RestClient)
&gt;
RestClientLib

## Constructors

### `public RestClientLib(String namedCredentialName)`

default constructor requiring a named credential string

#### Parameters

| Param                 | Description                  |
| --------------------- | ---------------------------- |
| `namedCredentialName` | String named credential name |

---

## Properties

### `protected namedCredentialName` → `String`

_Inherited_
`TESTVISIBLE`

The name of the Named Credential to use

---

## Methods

### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body)`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Makes an HTTP Callout to an api resource. Convenience method that assumes the Default Headers.

#### Parameters

| Param    | Description                                             |
| -------- | ------------------------------------------------------- |
| `method` | HTTPVerb to use. See the enum above.                    |
| `path`   | Http path component of the URL. ie: `/path/to/resource` |
| `query`  | Query component of the URL ie: after `?foo=bar`         |
| `body`   | Body to send with this call.                            |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HttpResponse` |

### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query)`

`TESTVISIBLE`

convenience version of makeApiCall without body param. Invokes omnibus version above, with blank body param and default headers.

#### Parameters

| Param    | Description                                             |
| -------- | ------------------------------------------------------- |
| `method` | HTTPVerb to use. See the enum above.                    |
| `path`   | Http path component of the URL. ie: `/path/to/resource` |
| `query`  | Query component of the URL ie: after `?foo=bar`         |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse makeApiCall(HttpVerb method, String path)`

`TESTVISIBLE`

convenience version of makeApiCall without body or query params. Invokes omnibus version above, with blank body and query params

#### Parameters

| Param    | Description                                             |
| -------- | ------------------------------------------------------- |
| `method` | HTTPVerb to use. See the enum above.                    |
| `path`   | Http path component of the URL. ie: `/path/to/resource` |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse get(String path)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path

#### Parameters

| Param  | Description                                             |
| ------ | ------------------------------------------------------- |
| `path` | Http path component of the URL. ie: `/path/to/resource` |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse get(String path, String query)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path and query

#### Parameters

| Param   | Description                                             |
| ------- | ------------------------------------------------------- |
| `path`  | Http path component of the URL. ie: `/path/to/resource` |
| `query` | Query component of the URL ie: after `?foo=bar`         |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse del(String path)`

`TESTVISIBLE`

convenience method for deleting a resource based only on path

#### Parameters

| Param  | Description                                             |
| ------ | ------------------------------------------------------- |
| `path` | Http path component of the URL. ie: `/path/to/resource` |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse del(String path, String query)`

`TESTVISIBLE`

convenience method for a Delete Call that only requires a path and query

#### Parameters

| Param   | Description                                             |
| ------- | ------------------------------------------------------- |
| `path`  | Http path component of the URL. ie: `/path/to/resource` |
| `query` | Query component of the URL ie: after `?foo=bar`         |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse post(String path, String body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a path and body

#### Parameters

| Param  | Description                                             |
| ------ | ------------------------------------------------------- |
| `path` | Http path component of the URL. ie: `/path/to/resource` |
| `body` | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse post(String path, String query, String body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a path, query and body

#### Parameters

| Param   | Description                                             |
| ------- | ------------------------------------------------------- |
| `path`  | Http path component of the URL. ie: `/path/to/resource` |
| `query` | Query component of the URL ie: after `?foo=bar`         |
| `body`  | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse put(String path, String body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path and body

#### Parameters

| Param  | Description                                             |
| ------ | ------------------------------------------------------- |
| `path` | Http path component of the URL. ie: `/path/to/resource` |
| `body` | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse put(String path, String query, String body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path, query and body

#### Parameters

| Param   | Description                                             |
| ------- | ------------------------------------------------------- |
| `path`  | Http path component of the URL. ie: `/path/to/resource` |
| `query` | Query component of the URL ie: after `?foo=bar`         |
| `body`  | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse patch(String path, String body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a path and body

#### Parameters

| Param  | Description                                             |
| ------ | ------------------------------------------------------- |
| `path` | Http path component of the URL. ie: `/path/to/resource` |
| `body` | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

### `protected HttpResponse patch(String path, String query, String body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a path, query and body

#### Parameters

| Param   | Description                                             |
| ------- | ------------------------------------------------------- |
| `path`  | Http path component of the URL. ie: `/path/to/resource` |
| `query` | Query component of the URL ie: after `?foo=bar`         |
| `body`  | JSON string to post                                     |

#### Returns

| Type         | Description    |
| ------------ | -------------- |
| HttpResponse | `HTTPResponse` |

---
