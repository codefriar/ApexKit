`STATUS: ACTIVE`

This class implements the Apex Transaction Finalizer interface. It's used to implement promises. This
class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
is executed. The QueueableProcess class automatically attaches this finalizer to it's execution.

**Implemented types**

[System.Finalizer](System.Finalizer)

## Constructors

### `public EnqueueNextQueueableProcessStep(List<QueueableProcess> processSteps, Object dataPassthrough, List<QueueableContext> queueableContextHistory, List<FinalizerContext> finalizerContextHistory)`

`SUPPRESSWARNINGS`

Constructor for the EnqueueNextQueueableProcessStep class.

#### Parameters

| Param                     | Description                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `processSteps`            | List<QueueableProcess> A list of QueueableProcess Objects. The first step in the list is executed.                                            |
| `dataPassthrough`         | Object this is either the initial data passed into the first QueueableProcessStep, or the data passed from the previous QueueableProcessStep. |
| `queueableContextHistory` | List<QueueableContext> A list of QueueableContext Objects.                                                                                    |
| `finalizerContextHistory` | List<FinalizerContext> A list of FinalizerContext Objects.                                                                                    |

---

## Fields

### `private dataPassthrough` → `Object`

This field allows you to pass information into your initial QueueableProcessStep. This is also the field that is passed to the next QueueableProcessStep in the list.

### `private dataProvider` → `QueueableProcessDataProvider`

`TESTVISIBLE`

a DataProvider instance. This is used to allow for dependency injection in unit tests.

### `private finalizerContextHistory` → `List<FinalizerContext>`

### `private processSteps` → `List<QueueableProcess>`

A list of QueueableProcess Objects. The first step in the list is executed.

### `private queueableContextHistory` → `List<QueueableContext>`

---

## Methods

### `public void execute(FinalizerContext context)`

This method is required by the Apex Transaction Finalizer interface. It's used to enqueue the next QueueableProcessStep in the list, if one exists.

#### Parameters

| Param     | Description                                                                                                                               |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `context` | FinalizerContext Dependency injected by Salesforce at execution time. Contains the result of the QueueableProcessStep that just executed. |

### `private void handleException(FinalizerContext context)`

---
