`STATUS: ACTIVE`

A class for automatically attaching metadata to log messages
like Quiddity and RequestID

**See** [Log](https://github.com/codefriar/ApexKit/wiki/Log)

**See** [LogException](https://github.com/codefriar/ApexKit/wiki/LogException)

**See** [LogTriggerHandler](https://github.com/codefriar/ApexKit/wiki/LogTriggerHandler)

## Constructors

### `public LogMessage(LoggingLevel severity, String message)`

Constructor accepting a message to log. Severity is auto set to info

#### Parameters

| Param      | Description                              |
| ---------- | ---------------------------------------- |
| `severity` | LoggingLevel the severity of the message |
| `message`  | String the string to log                 |

### `public LogMessage(String message)`

Constructor accepting a message to log. Severity is auto set to info

#### Parameters

| Param     | Description              |
| --------- | ------------------------ |
| `message` | String the string to log |

### `public LogMessage(Exception ex)`

Constructor accepting an exception object.

#### Parameters

| Param | Description          |
| ----- | -------------------- |
| `ex`  | any exception object |

---

## Fields

### `private EXCEPTION_STRING_FORMAT` → `String`

---

## Properties

### `public message` → `String`

Public message property.

### `public quiddity` → `Quiddity`

Public read only property for quiddity. Privately set.

### `public requestId` → `String`

public read only property for the request ID. Privately set.

### `public severity` → `LoggingLevel`

Public severity property.

---

## Methods

### `public Log__e toEvent()`

converts this object to an event for publishing

#### Returns

| Type     | Description |
| -------- | ----------- |
| Log\_\_e | `SObject`   |

---
