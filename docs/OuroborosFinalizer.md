`STATUS: ACTIVE`

This is the OuroborosFinalizer class. It is responsible for determining if the Ouroboros should
continue to loop, and if so, enqueueing the next iteration. It also ensure passthrough objects are passed to the
next iteration.

**Implemented types**

[Finalizer](Finalizer)

## Constructors

### `public OuroborosFinalizer(Ouroboros ouroboros)`

Constructor. Requires an instance of an Ouroboros implementing class to be passed in.

#### Parameters

| Param       | Description                                     |
| ----------- | ----------------------------------------------- |
| `ouroboros` | Ouroboros instance to be enqueued, if necessary |

---

## Fields

### `private logger` → `Log`

An instance of the Log class used to create transaction-rollback safe log entries

### `private ouroboros` → `Ouroboros`

An Ouroboros instance is required to be passed to the constructor. This is the instance that will be enqueued, if necessary.

---

## Methods

### `private static Boolean safeToEnqueueAccordingToLimits()`

Method is responsible for determining if it's safe to enqueue the next iteration of the Ouroboros at least in accordance with the Queueable Apex limits. If it's not safe, the circuit breaker is tripped and the next iteration will not be enqueued.

#### Returns

| Type      | Description                                                                            |
| --------- | -------------------------------------------------------------------------------------- |
| `Boolean` | Boolean True if enqueuing the next iteration will not violate any Apex governor limits |

### `public void execute(FinalizerContext context)`

This is the method that is called by the Apex runtime when the Ouroboros instance has completed. It's responsible for determining if it's safe to enqueue the next iteration of the Ouroboros, and if so, if it's also necessary to enqueue the next iteration. If it is, it will enqueue the next iteration.

#### Parameters

| Param     | Description                                                           |
| --------- | --------------------------------------------------------------------- |
| `context` | FinalizerContext This is dependency injected by the Queueable system. |

---
