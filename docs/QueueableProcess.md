`STATUS: ACTIVE`

This class provides a way for developers to create a process of Queueable classes. This implementation
facilitates the handoff of data into the overarching process and from one process step to the next. While
functionally similar to the way a 'Promise' pattern allows you chain async methods together. However, a true Promise
pattern resolves itself, one way or another, within the same transaction. Therefore, this is not a true Promise
pattern, but an elegant way to logically chain Salesforce Queueables together. As a Developer, you'll need to extend
this class, implementing the necessary `execute` method. Your `execute` method will be invoked asynchronously as part
of a Queueable. You can then chain additional Queueables together using the `then` method provided by this class.
<br>
As each 'step' of the chain is completed the transaction finalizer will be constructed with the remaining steps and
any passthrough data you specify. Passthrough data allows you to pass data between steps.

**Implemented types**

[Queueable](Queueable)
,
[Database.AllowsCallouts](Database.AllowsCallouts)

## Constructors

### `protected QueueableProcess()`

`SUPPRESSWARNINGS`

this is a constructor that is used by extension classes;

---

## Fields

### `public dataPassthrough` → `Object`

### `private defaultHandleExceptionCalled` → `Boolean`

`TESTVISIBLE`

### `public finalizerContextHistory` → `List<FinalizerContext>`

### `public processSteps` → `List<QueueableProcess>`

### `public queueableContextHistory` → `List<QueueableContext>`

---

## Methods

### `public QueueableProcess then(QueueableProcess toAdd)`

This method provides a syntactic sugar for adding a new QueueableProcess to the chain.

#### Parameters

| Param   | Description                                                                                          |
| ------- | ---------------------------------------------------------------------------------------------------- |
| `toAdd` | An instance of a class that extends this QueueableProcess class and implements the `execute` method. |

#### Returns

| Type             | Description                                                                                           |
| ---------------- | ----------------------------------------------------------------------------------------------------- |
| QueueableProcess | Returns a Queueable Process instance that can be used to chain additional QueueableProcess instances. |

### `public Id start()`

This method starts the QueueableProcess chain. It's the entry point for the process.

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id - Id of the Enqueued job. |

### `public Id start(Object initialPassthrough)`

This method starts the QueueableProcess chain. It's the entry point for the process.

#### Parameters

| Param                | Description                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------- |
| `initialPassthrough` | Object - this is the initial passthrough data that will be passed to the first QueueableProcess in the chain. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id - Id of the Enqueued job. |

### `public void execute()`

This must be implemented by extending classes. Developers - implement this method with the work you want executed asynchronously.

### `public void handleException(Exception incomingException)`

this is a default implementation of an handleError method. It's called by the finalizer if the developer doesn't implement their own handleError method. Developers can write per-step error handling by implementing their own handleError method as `public override void handleError(Exception incomingException)`

#### Parameters

| Param               | Description                                                 |
| ------------------- | ----------------------------------------------------------- |
| `incomingException` | Exception - the exception that was thrown during execution. |

### `public void execute(QueueableContext context)`

This is required by the Queueable interface. It's the essence of how the QueueableProcess pattern is implemented in Apex.

#### Parameters

| Param     | Description                                                             |
| --------- | ----------------------------------------------------------------------- |
| `context` | QueueableContext - dependency injected by Salesforce at execution time. |

---
