## Methods

### `testConstructorPositive()`

`ISTEST`

Executes a positive test case of the Constructor.
Expects the named credential to be set.

#### Signature

```apex
private static void testConstructorPositive()
```

#### Return Type

**void**

---

### `testRestLibApiCallFluentInterface()`

`ISTEST`

Tests the fluent interface for RestLibApiCall with GET

#### Signature

```apex
private static void testRestLibApiCallFluentInterface()
```

#### Return Type

**void**

---

### `testRestLibApiCallFluentInterfaceWithPost()`

`ISTEST`

Tests the fluent interface for RestLibApiCall with POST and body

#### Signature

```apex
private static void testRestLibApiCallFluentInterfaceWithPost()
```

#### Return Type

**void**

---

### `testRestLibApiCallFluentInterfaceWithPatch()`

`ISTEST`

Tests the fluent interface for RestLibApiCall with PATCH (which is handled specially)

#### Signature

```apex
private static void testRestLibApiCallFluentInterfaceWithPatch()
```

#### Return Type

**void**

---

### `testStaticMakeApiCallFullParamsPositive()`

`ISTEST`

Note: we do not have a constructor test for the no param
constructor. Because it&#x27;s access modifier is protected
we cannot use that constructor - the compiler throws an error
noting the method is not visible

#### Signature

```apex
private static void testStaticMakeApiCallFullParamsPositive()
```

#### Return Type

**void**

---

### `testStaticMakeApiCallNoHeadersOrBodyParamsPositive()`

`ISTEST`

#### Signature

```apex
private static void testStaticMakeApiCallNoHeadersOrBodyParamsPositive()
```

#### Return Type

**void**

---

### `testStaticMakeApiCallNoHeadersOrBodyOrQueryParamsPositive()`

`ISTEST`

#### Signature

```apex
private static void testStaticMakeApiCallNoHeadersOrBodyOrQueryParamsPositive()
```

#### Return Type

**void**

---

### `testGetWithPathAndQueryPositive()`

`ISTEST`

Convenience, Instance Methods
These 6 methods are not utilized by our API service
class.

#### Signature

```apex
private static void testGetWithPathAndQueryPositive()
```

#### Return Type

**void**

---

### `testGetWithPathPositive()`

`ISTEST`

Positive test case for convenience method needing only
path and query params.

#### Signature

```apex
private static void testGetWithPathPositive()
```

#### Return Type

**void**

---

### `testDelWithPathPositive()`

`ISTEST`

#### Signature

```apex
private static void testDelWithPathPositive()
```

#### Return Type

**void**

---

### `testDelWithPathAndQueryPositive()`

`ISTEST`

#### Signature

```apex
private static void testDelWithPathAndQueryPositive()
```

#### Return Type

**void**

---

### `testPostWithPathAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPostWithPathAndBodyPositive()
```

#### Return Type

**void**

---

### `testPostWithPathQueryAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPostWithPathQueryAndBodyPositive()
```

#### Return Type

**void**

---

### `testPutWithPathAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPutWithPathAndBodyPositive()
```

#### Return Type

**void**

---

### `testPutWithPathQueryAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPutWithPathQueryAndBodyPositive()
```

#### Return Type

**void**

---

### `testPatchWithPathQueryAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPatchWithPathQueryAndBodyPositive()
```

#### Return Type

**void**

---

### `testPatchWithPathAndBodyPositive()`

`ISTEST`

#### Signature

```apex
private static void testPatchWithPathAndBodyPositive()
```

#### Return Type

**void**

---

### `testProtectedRestLibConstructorPositive()`

`ISTEST`

#### Signature

```apex
private static void testProtectedRestLibConstructorPositive()
```

#### Return Type

**void**

---

### `testEnsureStringEndsInSlashPositiveStartWithoutSlash()`

`ISTEST`

#### Signature

```apex
private static void testEnsureStringEndsInSlashPositiveStartWithoutSlash()
```

#### Return Type

**void**
