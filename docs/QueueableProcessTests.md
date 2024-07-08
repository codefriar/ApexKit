`APIVERSION: 58`

`STATUS: ACTIVE`

This class contains tests used for testing the QueueableProcess framework.

## Methods

### `private static void setup()`

`TESTSETUP`

### `private static void testBasicE2EProcessPositive()`

`ISTEST`

### `private static void testBasicE2EProcessPositiveNoInput()`

`ISTEST`

### `private static void fireQueueableProcess(Account testAccount)`

### `private static void testFinalizerHandlesUnhandledExceptionPositiveFailsafeHandlerCalled()`

`ISTEST`

### `private static void testFinalizerHandlesUnhandledExceptionPositiveDefaultHandler()`

`ISTEST`

### `private static void testFinalizerHandlesUnhandledExceptionPositiveCustomHandler()`

`ISTEST`

### `private static Account getTestAccount()`

---

## Classes

### MockFinalizerContext

This class is used to mock the FinalizerContext variable dependency injected by SF into the
execute method. This allows us to mock a failure in the preceeding QueueableProcess and test the finalizer's
behavior.

**Implemented types**

[System.FinalizerContext](System.FinalizerContext)

#### Constructors

##### `private MockFinalizerContext(ParentJobResult mockResult)`

###### Parameters

| Param        | Description |
| ------------ | ----------- |
| `mockResult` |             |

---

#### Fields

##### `private result` → `ParentJobResult`

---

#### Methods

##### `public Id getAsyncApexJobId()`

Returns the ID of the Queueable job for which this finalizer is defined.

###### Returns

| Type | Description |
| ---- | ----------- |
| `Id` | `Id`        |

##### `public Exception getException()`

Returns the exception with which the Queueable job failed when getResult is `UNHANDLED_EXCEPTION`, null otherwise.

###### Returns

| Type        | Description |
| ----------- | ----------- |
| `Exception` | `Exception` |

##### `public String getRequestId()`

Returns the request ID, a string that uniquely identifies the request, and can be correlated with Event Monitoring logs. To correlate with the AsyncApexJob table, use the `getAsyncApexJobId` method instead. The Queueable job and the Finalizer execution both share the (same) request ID.

###### Returns

| Type     | Description |
| -------- | ----------- |
| `String` | `String`    |

##### `public ParentJobResult getResult()`

Returns the System.ParentJobResult enum, which represents the result of the parent asynchronous Apex Queueable job to which the finalizer is attached. The enum takes these values: `SUCCESS`, `UNHANDLED_EXCEPTION`.

###### Returns

| Type              | Description       |
| ----------------- | ----------------- |
| `ParentJobResult` | `ParentJobResult` |

---

---
