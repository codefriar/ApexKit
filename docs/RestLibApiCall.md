# RestLibApiCall

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

---
