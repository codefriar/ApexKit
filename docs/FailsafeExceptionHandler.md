`STATUS: ACTIVE`

This class is a polyfill for the handling exceptions. Rather than writing
boilerplate exception handling code everywhere, this class can be used to log exceptions.

**Implemented types**

[System.Callable](System.Callable)

## Constructors

### `public FailsafeExceptionHandler()`

`SUPPRESSWARNINGS`

### `public FailsafeExceptionHandler(Exception incomingException)`

Constructor usage for a single exception.

#### Parameters

| Param               | Description                            |
| ------------------- | -------------------------------------- |
| `incomingException` | Exception the Exception to be handled. |

#### Example

```apex
`new FailsafeExceptionHandler(incomingException);`
```

### `public FailsafeExceptionHandler(List<Exception> incomingExceptions)`

Constructor usage for a list of exceptions.

#### Parameters

| Param                | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `incomingExceptions` | List<Exception> the list of exceptions to be handled. |

#### Example

```apex
`new FailsafeExceptionHandler(incomingExceptions);`
```

---

## Fields

### `private logger` → `Log`

`TESTVISIBLE`

An instance of Log to log exceptions.

---

## Methods

### `public void handledException(Exception incomingException)`

Handles an incoming exception by adding it to the log list.

#### Parameters

| Param               | Description                            |
| ------------------- | -------------------------------------- |
| `incomingException` | Exception the exception to be handled. |

### `public void handleExceptions(List<Exception> exceptions)`

handles an list of incoming exceptions

#### Parameters

| Param        | Description                                           |
| ------------ | ----------------------------------------------------- |
| `exceptions` | List<Exception> the list of exceptions to be handled. |

### `public Object call(String action, Map<String,Object> args)`

Implements the Callable interface. This allows the class to be used outside of a package boundary.

#### Parameters

| Param    | Description                                                                                                 |
| -------- | ----------------------------------------------------------------------------------------------------------- |
| `action` | String the action to be performed. The only one handled in this class is 'handleException'.                 |
| `args`   | Map<String, Object> the arguments to be passed to the action. in this case 'incomingException' => Exception |

#### Returns

| Type   | Description         |
| ------ | ------------------- |
| Object | Object returns null |

---
