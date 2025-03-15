continue to loop, and if so, enqueueing the next iteration. It also ensure passthrough objects are passed to the
next iteration.

**Implements**

Finalizer

## Fields

### `ouroboros`

An Ouroboros instance is required to be passed to the constructor. This is the instance that will
be enqueued, if necessary.

#### Signature

```apex
private final ouroboros
```

#### Type

[Ouroboros](Ouroboros.md)

---

### `logger`

An instance of the Log class used to create transaction-rollback safe log entries

#### Signature

```apex
private final logger
```

#### Type

[Log](Log.md)

## Constructors

### `OuroborosFinalizer(ouroboros)`

Constructor. Requires an instance of an Ouroboros implementing class to be passed in.

#### Signature

```apex
public OuroborosFinalizer(Ouroboros ouroboros)
```

#### Parameters

| Name      | Type                      | Description                                     |
| --------- | ------------------------- | ----------------------------------------------- |
| ouroboros | [Ouroboros](Ouroboros.md) | Ouroboros instance to be enqueued, if necessary |

## Methods

### `safeToEnqueueAccordingToLimits()`

Method is responsible for determining if it&#x27;s safe to enqueue the next iteration of the Ouroboros
at least in accordance with the Queueable Apex limits. If it&#x27;s not safe, the circuit breaker is tripped and the
next iteration will not be enqueued.

#### Signature

```apex
private static Boolean safeToEnqueueAccordingToLimits()
```

#### Return Type

**Boolean**

Boolean True if enqueuing the next iteration will not violate any Apex governor limits

---

### `execute(context)`

This is the method that is called by the Apex runtime when the Ouroboros instance has completed.
It&#x27;s responsible for determining if it&#x27;s safe to enqueue the next iteration of the Ouroboros, and if so, if it&#x27;s
also necessary to enqueue the next iteration. If it is, it will enqueue the next iteration.

#### Signature

```apex
public void execute(FinalizerContext context)
```

#### Parameters

| Name    | Type             | Description                                                           |
| ------- | ---------------- | --------------------------------------------------------------------- |
| context | FinalizerContext | FinalizerContext This is dependency injected by the Queueable system. |

#### Return Type

**void**
