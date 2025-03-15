boilerplate exception handling code everywhere, this class can be used to log exceptions.

**Implements**

System.Callable

## Fields

### `logger`

`TESTVISIBLE`

An instance of Log to log exceptions.

#### Signature

```apex
private final logger
```

#### Type

[Log](Log.md)

## Constructors

### `FailsafeExceptionHandler()`

`SUPPRESSWARNINGS`

#### Signature

```apex
public FailsafeExceptionHandler()
```

---

### `FailsafeExceptionHandler(incomingException)`

Constructor usage for a single exception.

#### Signature

```apex
public FailsafeExceptionHandler(Exception incomingException)
```

#### Parameters

| Name              | Type      | Description                            |
| ----------------- | --------- | -------------------------------------- |
| incomingException | Exception | Exception the Exception to be handled. |

#### Example

`new FailsafeExceptionHandler(incomingException);`

---

### `FailsafeExceptionHandler(incomingExceptions)`

Constructor usage for a list of exceptions.

#### Signature

```apex
public FailsafeExceptionHandler(List<Exception> incomingExceptions)
```

#### Parameters

| Name               | Type                  | Description                                                 |
| ------------------ | --------------------- | ----------------------------------------------------------- |
| incomingExceptions | List&lt;Exception&gt; | List&lt;Exception&gt; the list of exceptions to be handled. |

#### Example

`new FailsafeExceptionHandler(incomingExceptions);`

## Methods

### `handledException(incomingException)`

Handles an incoming exception by adding it to the log list.

#### Signature

```apex
public void handledException(Exception incomingException)
```

#### Parameters

| Name              | Type      | Description                            |
| ----------------- | --------- | -------------------------------------- |
| incomingException | Exception | Exception the exception to be handled. |

#### Return Type

**void**

---

### `handleExceptions(exceptions)`

handles an list of incoming exceptions

#### Signature

```apex
public void handleExceptions(List<Exception> exceptions)
```

#### Parameters

| Name       | Type                  | Description                                                 |
| ---------- | --------------------- | ----------------------------------------------------------- |
| exceptions | List&lt;Exception&gt; | List&lt;Exception&gt; the list of exceptions to be handled. |

#### Return Type

**void**

---

### `call(action, args)`

Implements the Callable interface. This allows the class to be used outside of a package boundary.

#### Signature

```apex
public Object call(String action, Map<String,Object> args)
```

#### Parameters

| Name                                               | Type                     | Description                                                                                           |
| -------------------------------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------- |
| action                                             | String                   | String the action to be performed. The only one handled in this class is &#x27;handleException&#x27;. |
| args                                               | Map&lt;String,Object&gt; | Map&lt;String, Object&gt; the arguments to be passed to the action. in this case                      |
| &#x27;incomingException&#x27; &#x3D;&gt; Exception |

#### Return Type

**Object**

Object returns null
