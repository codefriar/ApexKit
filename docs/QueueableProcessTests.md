This class contains tests used for testing the QueueableProcess framework.

## Methods

### `setup()`

`TESTSETUP`

#### Signature

```apex
private static void setup()
```

#### Return Type

**void**

---

### `testBasicE2EProcessPositive()`

`ISTEST`

#### Signature

```apex
private static void testBasicE2EProcessPositive()
```

#### Return Type

**void**

---

### `testBasicE2EProcessPositiveNoInput()`

`ISTEST`

#### Signature

```apex
private static void testBasicE2EProcessPositiveNoInput()
```

#### Return Type

**void**

---

### `fireQueueableProcess(testAccount)`

#### Signature

```apex
private static void fireQueueableProcess(Account testAccount)
```

#### Parameters

| Name        | Type    | Description |
| ----------- | ------- | ----------- |
| testAccount | Account |             |

#### Return Type

**void**

---

### `testFinalizerHandlesUnhandledExceptionPositiveFailsafeHandlerCalled()`

`ISTEST`

#### Signature

```apex
private static void testFinalizerHandlesUnhandledExceptionPositiveFailsafeHandlerCalled()
```

#### Return Type

**void**

---

### `testFinalizerHandlesUnhandledExceptionPositiveDefaultHandler()`

`ISTEST`

#### Signature

```apex
private static void testFinalizerHandlesUnhandledExceptionPositiveDefaultHandler()
```

#### Return Type

**void**

---

### `testFinalizerHandlesUnhandledExceptionPositiveCustomHandler()`

`ISTEST`

#### Signature

```apex
private static void testFinalizerHandlesUnhandledExceptionPositiveCustomHandler()
```

#### Return Type

**void**

---

### `getTestAccount()`

#### Signature

```apex
private static Account getTestAccount()
```

#### Return Type

**Account**

## Classes

### MockFinalizerContext Class

This class is used to mock the FinalizerContext variable dependency injected by SF into the
execute method. This allows us to mock a failure in the preceeding QueueableProcess and test the finalizer&#x27;s
behavior.

**Implements**

System.FinalizerContext

#### Fields

##### `result`

###### Signature

```apex
private final result
```

###### Type

ParentJobResult

#### Constructors

##### `MockFinalizerContext(mockResult)`

###### Signature

```apex
private MockFinalizerContext(ParentJobResult mockResult)
```

###### Parameters

| Name       | Type            | Description |
| ---------- | --------------- | ----------- |
| mockResult | ParentJobResult |             |

#### Methods

##### `getAsyncApexJobId()`

Returns the ID of the Queueable job for which this finalizer is defined.

###### Signature

```apex
public Id getAsyncApexJobId()
```

###### Return Type

**Id**

,[object Object]

---

##### `getException()`

Returns the exception with which the Queueable job failed when getResult is `UNHANDLED_EXCEPTION` , null otherwise.

###### Signature

```apex
public Exception getException()
```

###### Return Type

**Exception**

,[object Object]

---

##### `getRequestId()`

Returns the request ID, a string that uniquely identifies the request, and can be correlated with Event Monitoring logs.
To correlate with the AsyncApexJob table, use the `getAsyncApexJobId` method instead. The Queueable job and the Finalizer execution both share the (same) request ID.

###### Signature

```apex
public String getRequestId()
```

###### Return Type

**String**

,[object Object]

---

##### `getResult()`

Returns the System.ParentJobResult enum, which represents the result of the parent asynchronous Apex Queueable job to which the finalizer is attached. The enum takes these values: `SUCCESS` , `UNHANDLED_EXCEPTION` .

###### Signature

```apex
public ParentJobResult getResult()
```

###### Return Type

**ParentJobResult**

,[object Object]
