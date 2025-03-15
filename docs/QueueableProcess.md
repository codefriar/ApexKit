This class provides a way for developers to create a process of Queueable classes. This implementation
facilitates the handoff of data into the overarching process and from one process step to the next. While
functionally similar to the way a &#x27;Promise&#x27; pattern allows you chain async methods together. However, a true Promise
pattern resolves itself, one way or another, within the same transaction. Therefore, this is not a true Promise
pattern, but an elegant way to logically chain Salesforce Queueables together. As a Developer, you&#x27;ll need to extend
this class, implementing the necessary `execute` method. Your `execute` method will be invoked asynchronously as part
of a Queueable. You can then chain additional Queueables together using the `then` method provided by this class.
&lt;br&gt;
As each &#x27;step&#x27; of the chain is completed the transaction finalizer will be constructed with the remaining steps and
any passthrough data you specify. Passthrough data allows you to pass data between steps.

**Implements**

Queueable,
Database.AllowsCallouts

## Fields

### `processSteps`

#### Signature

```apex
public processSteps
```

#### Type

List&lt;QueueableProcess&gt;

---

### `dataPassthrough`

#### Signature

```apex
public dataPassthrough
```

#### Type

Object

---

### `queueableContextHistory`

#### Signature

```apex
public queueableContextHistory
```

#### Type

List&lt;QueueableContext&gt;

---

### `finalizerContextHistory`

#### Signature

```apex
public finalizerContextHistory
```

#### Type

List&lt;FinalizerContext&gt;

---

### `defaultHandleExceptionCalled`

`TESTVISIBLE`

#### Signature

```apex
private static defaultHandleExceptionCalled
```

#### Type

Boolean

## Constructors

### `QueueableProcess()`

`SUPPRESSWARNINGS`

this is a constructor that is used by extension classes;

#### Signature

```apex
protected QueueableProcess()
```

## Methods

### `then(toAdd)`

This method provides a syntactic sugar for adding a new QueueableProcess to the chain.

#### Signature

```apex
public QueueableProcess then(QueueableProcess toAdd)
```

#### Parameters

| Name  | Type                                    | Description                                                                                          |
| ----- | --------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| toAdd | [QueueableProcess](QueueableProcess.md) | An instance of a class that extends this QueueableProcess class and implements the `execute` method. |

#### Return Type

**[QueueableProcess](QueueableProcess.md)**

Returns a Queueable Process instance that can be used to chain additional QueueableProcess instances.

---

### `start()`

This method starts the QueueableProcess chain. It&#x27;s the entry point for the process.

#### Signature

```apex
public Id start()
```

#### Return Type

**Id**

Id - Id of the Enqueued job.

---

### `start(initialPassthrough)`

This method starts the QueueableProcess chain. It&#x27;s the entry point for the process.

#### Signature

```apex
public Id start(Object initialPassthrough)
```

#### Parameters

| Name                           | Type   | Description                                                                    |
| ------------------------------ | ------ | ------------------------------------------------------------------------------ |
| initialPassthrough             | Object | Object - this is the initial passthrough data that will be passed to the first |
| QueueableProcess in the chain. |

#### Return Type

**Id**

Id - Id of the Enqueued job.

---

### `execute()`

This must be implemented by extending classes. Developers - implement this method with the work you
want executed asynchronously.

#### Signature

```apex
public abstract void execute()
```

#### Return Type

**void**

---

### `handleException(incomingException)`

this is a default implementation of an handleError method. It&#x27;s called by the finalizer if the
developer doesn&#x27;t implement their own handleError method. Developers can write per-step error handling
by implementing their own handleError method as `public override void handleError(Exception incomingException)`

#### Signature

```apex
public virtual void handleException(Exception incomingException)
```

#### Parameters

| Name              | Type      | Description                                                 |
| ----------------- | --------- | ----------------------------------------------------------- |
| incomingException | Exception | Exception - the exception that was thrown during execution. |

#### Return Type

**void**

---

### `execute(context)`

This is required by the Queueable interface. It&#x27;s the essence of how the QueueableProcess pattern is
implemented in Apex.

#### Signature

```apex
public virtual void execute(QueueableContext context)
```

#### Parameters

| Name    | Type             | Description                                                             |
| ------- | ---------------- | ----------------------------------------------------------------------- |
| context | QueueableContext | QueueableContext - dependency injected by Salesforce at execution time. |

#### Return Type

**void**
