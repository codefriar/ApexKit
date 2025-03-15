class is constructed with a list of QueueableProcess Objects, and any passthrough data. The first promise in the list
is executed. The QueueableProcess class automatically attaches this finalizer to it&#x27;s execution.

**Implements**

System.Finalizer

## Fields

### `dataProvider`

`TESTVISIBLE`

a DataProvider instance. This is used to allow for dependency injection in unit tests.

#### Signature

```apex
private dataProvider
```

#### Type

[QueueableProcessDataProvider](QueueableProcessDataProvider.md)

---

### `processSteps`

A list of QueueableProcess Objects. The first step in the list is executed.

#### Signature

```apex
private final processSteps
```

#### Type

List&lt;QueueableProcess&gt;

---

### `dataPassthrough`

This field allows you to pass information into your initial QueueableProcessStep. This is also the
field that is passed to the next QueueableProcessStep in the list.

#### Signature

```apex
private final dataPassthrough
```

#### Type

Object

---

### `queueableContextHistory`

#### Signature

```apex
private final queueableContextHistory
```

#### Type

List&lt;QueueableContext&gt;

---

### `finalizerContextHistory`

#### Signature

```apex
private finalizerContextHistory
```

#### Type

List&lt;FinalizerContext&gt;

## Constructors

### `EnqueueNextQueueableProcessStep(processSteps, dataPassthrough, queueableContextHistory, finalizerContextHistory)`

`SUPPRESSWARNINGS`

Constructor for the EnqueueNextQueueableProcessStep class.

#### Signature

```apex
public EnqueueNextQueueableProcessStep(List<QueueableProcess> processSteps, Object dataPassthrough, List<QueueableContext> queueableContextHistory, List<FinalizerContext> finalizerContextHistory)
```

#### Parameters

| Name                    | Type                         | Description                                                                                                                                                   |
| ----------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| processSteps            | List&lt;QueueableProcess&gt; | List&lt;QueueableProcess&gt; A list of QueueableProcess Objects. The first step in the list is,[object Object],,[object Object],executed.                     |
| dataPassthrough         | Object                       | Object this is either the initial data passed into the first QueueableProcessStep, or the,[object Object],data passed from the previous QueueableProcessStep. |
| queueableContextHistory | List&lt;QueueableContext&gt; | List&lt;QueueableContext&gt; A list of QueueableContext Objects.                                                                                              |
| finalizerContextHistory | List&lt;FinalizerContext&gt; | List&lt;FinalizerContext&gt; A list of FinalizerContext Objects.                                                                                              |

## Methods

### `execute(context)`

This method is required by the Apex Transaction Finalizer interface. It&#x27;s used to enqueue the next
QueueableProcessStep in the list, if one exists.

#### Signature

```apex
public void execute(FinalizerContext context)
```

#### Parameters

| Name                                     | Type             | Description                                                                                      |
| ---------------------------------------- | ---------------- | ------------------------------------------------------------------------------------------------ |
| context                                  | FinalizerContext | FinalizerContext Dependency injected by Salesforce at execution time. Contains the result of the |
| QueueableProcessStep that just executed. |

#### Return Type

**void**

---

### `handleException(context)`

#### Signature

```apex
private void handleException(FinalizerContext context)
```

#### Parameters

| Name    | Type             | Description |
| ------- | ---------------- | ----------- |
| context | FinalizerContext |             |

#### Return Type

**void**
