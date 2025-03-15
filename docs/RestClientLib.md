This class is a wrapper around the RestLib class that is intended to be extended by developers
to provide a quick, safe, and reliable way of making REST callouts. By extending this class you&#x27;re locking your
class to a specific Named Credential, which is a best practice for making callouts, and you&#x27;re inheriting methods
like `get` , `post` , `put` , `patch` , and `del` that make it easy to make callouts without having to worry about
setting headers, or other common tasks.

**Inheritance**

[RestClient](RestClient.md) < [RestLib](RestLib.md)

## Properties

### `namedCredentialName`

_Inherited_

`TESTVISIBLE`

The name of the Named Credential to use

#### Signature

```apex
protected namedCredentialName
```

#### Type

String

## Constructors

### `RestClientLib(namedCredentialName)`

default constructor requiring a named credential string

#### Signature

```apex
public RestClientLib(String namedCredentialName)
```

#### Parameters

| Name                | Type   | Description                  |
| ------------------- | ------ | ---------------------------- |
| namedCredentialName | String | String named credential name |

## Methods

### `makeApiCall(method, path, query, body)`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Makes an HTTP Callout to an api resource.
Convenience method that assumes the Default Headers.

#### Signature

```apex
protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body)
```

#### Parameters

| Name   | Type                    | Description                                             |
| ------ | ----------------------- | ------------------------------------------------------- |
| method | [HttpVerb](HttpVerb.md) | HTTPVerb to use. See the enum above.                    |
| path   | String                  | Http path component of the URL. ie: `/path/to/resource` |
| query  | String                  | Query component of the URL ie: after `?foo=bar`         |
| body   | String                  | Body to send with this call.                            |

#### Return Type

**HttpResponse**

,[object Object]

---

### `makeApiCall(method, path, query)`

`TESTVISIBLE`

convenience version of makeApiCall without body param.
Invokes omnibus version above, with blank body param and default headers.

#### Signature

```apex
protected HttpResponse makeApiCall(HttpVerb method, String path, String query)
```

#### Parameters

| Name   | Type                    | Description                                             |
| ------ | ----------------------- | ------------------------------------------------------- |
| method | [HttpVerb](HttpVerb.md) | HTTPVerb to use. See the enum above.                    |
| path   | String                  | Http path component of the URL. ie: `/path/to/resource` |
| query  | String                  | Query component of the URL ie: after `?foo=bar`         |

#### Return Type

**HttpResponse**

,[object Object]

---

### `makeApiCall(method, path)`

`TESTVISIBLE`

convenience version of makeApiCall without body or query
params.
Invokes omnibus version above, with blank body and query params

#### Signature

```apex
protected HttpResponse makeApiCall(HttpVerb method, String path)
```

#### Parameters

| Name   | Type                    | Description                                             |
| ------ | ----------------------- | ------------------------------------------------------- |
| method | [HttpVerb](HttpVerb.md) | HTTPVerb to use. See the enum above.                    |
| path   | String                  | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type

**HttpResponse**

,[object Object]

---

### `get(path)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path

#### Signature

```apex
protected HttpResponse get(String path)
```

#### Parameters

| Name | Type   | Description                                             |
| ---- | ------ | ------------------------------------------------------- |
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type

**HttpResponse**

,[object Object]

---

### `get(path, query)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path
and query

#### Signature

```apex
protected HttpResponse get(String path, String query)
```

#### Parameters

| Name  | Type   | Description                                             |
| ----- | ------ | ------------------------------------------------------- |
| path  | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar`         |

#### Return Type

**HttpResponse**

,[object Object]

---

### `del(path)`

`TESTVISIBLE`

convenience method for deleting a resource based only on
path

#### Signature

```apex
protected HttpResponse del(String path)
```

#### Parameters

| Name | Type   | Description                                             |
| ---- | ------ | ------------------------------------------------------- |
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type

**HttpResponse**

,[object Object]

---

### `del(path, query)`

`TESTVISIBLE`

convenience method for a Delete Call that only requires a
path and query

#### Signature

```apex
protected HttpResponse del(String path, String query)
```

#### Parameters

| Name  | Type   | Description                                             |
| ----- | ------ | ------------------------------------------------------- |
| path  | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar`         |

#### Return Type

**HttpResponse**

,[object Object]

---

### `post(path, body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a path
and body

#### Signature

```apex
protected HttpResponse post(String path, String body)
```

#### Parameters

| Name | Type   | Description                                             |
| ---- | ------ | ------------------------------------------------------- |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]

---

### `post(path, query, body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a
path, query and body

#### Signature

```apex
protected HttpResponse post(String path, String query, String body)
```

#### Parameters

| Name  | Type   | Description                                             |
| ----- | ------ | ------------------------------------------------------- |
| path  | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar`         |
| body  | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]

---

### `put(path, body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path
and body

#### Signature

```apex
protected HttpResponse put(String path, String body)
```

#### Parameters

| Name | Type   | Description                                             |
| ---- | ------ | ------------------------------------------------------- |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]

---

### `put(path, query, body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path,
query and body

#### Signature

```apex
protected HttpResponse put(String path, String query, String body)
```

#### Parameters

| Name  | Type   | Description                                             |
| ----- | ------ | ------------------------------------------------------- |
| path  | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar`         |
| body  | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]

---

### `patch(path, body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a
path and body

#### Signature

```apex
protected HttpResponse patch(String path, String body)
```

#### Parameters

| Name | Type   | Description                                             |
| ---- | ------ | ------------------------------------------------------- |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]

---

### `patch(path, query, body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a
path, query and body

#### Signature

```apex
protected HttpResponse patch(String path, String query, String body)
```

#### Parameters

| Name  | Type   | Description                                             |
| ----- | ------ | ------------------------------------------------------- |
| path  | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar`         |
| body  | String | JSON string to post                                     |

#### Return Type

**HttpResponse**

,[object Object]
