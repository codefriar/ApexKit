like Quiddity and RequestID

**See** [Log](Log.md)

**See** [LogException](LogException.md)

**See** [LogTriggerHandler](LogTriggerHandler.md)

## Fields

### `EXCEPTION_STRING_FORMAT`

#### Signature

```apex
private static final EXCEPTION_STRING_FORMAT
```

#### Type

String

## Properties

### `requestId`

public read only property for the request ID. Privately set.

#### Signature

```apex
public requestId
```

#### Type

String

---

### `quiddity`

Public read only property for quiddity. Privately set.

#### Signature

```apex
public quiddity
```

#### Type

Quiddity

---

### `message`

Public message property.

#### Signature

```apex
public message
```

#### Type

String

---

### `severity`

Public severity property.

#### Signature

```apex
public severity
```

#### Type

LoggingLevel

## Constructors

### `LogMessage(severity, message)`

Constructor accepting a message to log.
Severity is auto set to info

#### Signature

```apex
public LogMessage(LoggingLevel severity, String message)
```

#### Parameters

| Name     | Type         | Description                              |
| -------- | ------------ | ---------------------------------------- |
| severity | LoggingLevel | LoggingLevel the severity of the message |
| message  | String       | String the string to log                 |

---

### `LogMessage(message)`

Constructor accepting a message to log.
Severity is auto set to info

#### Signature

```apex
public LogMessage(String message)
```

#### Parameters

| Name    | Type   | Description              |
| ------- | ------ | ------------------------ |
| message | String | String the string to log |

---

### `LogMessage(ex)`

Constructor accepting an exception object.

#### Signature

```apex
public LogMessage(Exception ex)
```

#### Parameters

| Name | Type      | Description          |
| ---- | --------- | -------------------- |
| ex   | Exception | any exception object |

## Methods

### `toEvent()`

converts this object to an event for publishing

#### Signature

```apex
public Log__e toEvent()
```

#### Return Type

**Log\_\_e**

,[object Object]
