**See** [LogMessage](LogMessage.md)

**See** [LogException](LogException.md)

**See** [LogTriggerHandler](LogTriggerHandler.md)

## Fields

### `publishToStandardLogs`

#### Signature

```apex
public static publishToStandardLogs
```

#### Type

Boolean

---

### `currentInstance`

private instance of this log class that backs the
singleton get() method.

#### Signature

```apex
private static currentInstance
```

#### Type

[Log](Log.md)

---

### `buffer`

private list of LogMessage objects to be published in the
future

#### Signature

```apex
private final buffer
```

#### Type

List&lt;LogMessage&gt;

## Constructors

### `Log()`

establishes the buffer, if one doesn&#x27;t yet exist
private, to ensure we can&#x27;t directly construct this class. Use the
Singleton, Luke.

#### Signature

```apex
private Log()
```

## Methods

### `get()`

Singleton pattern `get` method.

#### Signature

```apex
public static Log get()
```

#### Return Type

**[Log](Log.md)**

,[object Object]

---

### `add(messageToLog)`

Add a message to the buffer without publishing it.
Assumes a null severity

#### Signature

```apex
public void add(String messageToLog)
```

#### Parameters

| Name         | Type   | Description                              |
| ------------ | ------ | ---------------------------------------- |
| messageToLog | String | The string message to add to the buffer. |

#### Return Type

**void**

---

### `add(messageToLog, severity)`

Add a message to the buffer without publishing it.

#### Signature

```apex
public void add(String messageToLog, LoggingLevel severity)
```

#### Parameters

| Name         | Type         | Description                              |
| ------------ | ------------ | ---------------------------------------- |
| messageToLog | String       | The string message to add to the buffer. |
| severity     | LoggingLevel | LogSeverity enum                         |

#### Return Type

**void**

---

### `add(exceptionToLog)`

Add an formatted exception message to the buffer without
publishing it. Assumes a null Severity

#### Signature

```apex
public void add(Exception exceptionToLog)
```

#### Parameters

| Name           | Type      | Description                 |
| -------------- | --------- | --------------------------- |
| exceptionToLog | Exception | Exception to format and log |

#### Return Type

**void**

---

### `add(exceptionToLog, severity)`

Add an formatted exception message to the buffer without
publishing it.

#### Signature

```apex
public void add(Exception exceptionToLog, LoggingLevel severity)
```

#### Parameters

| Name           | Type         | Description                 |
| -------------- | ------------ | --------------------------- |
| exceptionToLog | Exception    | Exception to format and log |
| severity       | LoggingLevel | LogSeverity enum            |

#### Return Type

**void**

---

### `publish()`

Publish any messages currently in the buffer, without adding
any new ones.

#### Signature

```apex
public void publish()
```

#### Return Type

**void**

---

### `alsoPublishToStandardLogs(logEvents)`

`SUPPRESSWARNINGS`

this method will drop the logged statements to the transaction log via system.debug

#### Signature

```apex
private static void alsoPublishToStandardLogs(List<Log__e> logEvents)
```

#### Parameters

| Name      | Type                 | Description                       |
| --------- | -------------------- | --------------------------------- |
| logEvents | List&lt;Log\_\_e&gt; | List&lt;Log\_\_e&gt; to be logged |

#### Return Type

**void**

---

### `publish(exceptionToLog)`

Auto-format exception details, add it to the log buffer,
and then publish the current buffer. Use the equivalent add
method if you intend to add multiple messages rapidly to minimize DML
usage.

#### Signature

```apex
public void publish(Exception exceptionToLog)
```

#### Parameters

| Name           | Type      | Description                 |
| -------------- | --------- | --------------------------- |
| exceptionToLog | Exception | exception to format and log |

#### Return Type

**void**

---

### `publish(messageToLog)`

Auto-format a custom log message string, add it to the log
buffer, and then publish the current buffer. Use the equivalent add
method if you intend to add multiple messages rapidly to minimize DML
usage.

#### Signature

```apex
public void publish(String messageToLog)
```

#### Parameters

| Name         | Type   | Description   |
| ------------ | ------ | ------------- |
| messageToLog | String | String to log |

#### Return Type

**void**

---

### `publish(severity, messageToLog)`

Publish a custom log message string with a specified severity

#### Signature

```apex
public void publish(LoggingLevel severity, String messageToLog)
```

#### Parameters

| Name         | Type         | Description                                          |
| ------------ | ------------ | ---------------------------------------------------- |
| severity     | LoggingLevel | LoggingLevel enum noting the severity of the message |
| messageToLog | String       | String to log                                        |

#### Return Type

**void**
