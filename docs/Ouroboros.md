Ouroboros is the ancient mythical symbol of a dragon or serpent eating its own tail. It&#x27;s often
understood as a reference to the circle of life, or the never ending nature life and death. In this case, it&#x27;s a
reference to a Queueable object that enqueues itself when it&#x27;s done executing via a OuroborosFinalizer. This is a
useful pattern when you need to process high volumes of data, but don&#x27;t care if it&#x27;s processed in real time.

**Implements**

Queueable,
Database.AllowsCallouts

## Fields

### `passthrough`

Object that will be passed through to the next iteration of the Ouroboros.

#### Signature

```apex
public passthrough
```

#### Type

Object

## Methods

### `hasExitCriteriaBeenMet()`

This is the method that implementing classes must override. It&#x27;s the method that will be called
to determine if whether or not to re-enqueue the Ouroboros Queueable.

#### Signature

```apex
public abstract Boolean hasExitCriteriaBeenMet()
```

#### Return Type

**Boolean**

Boolean True if the exit criteria has been met.

---

### `execute()`

This is the method that will be called as the executable portion of the Queueable. It&#x27;s the method
developers will populate with their business logic to execute on each iteration of the Ouroboros.

#### Signature

```apex
public abstract void execute()
```

#### Return Type

**void**

---

### `className()`

This method is to be deprecated shortly, in favor of the lookup system built in QueueableProcess.

#### Signature

```apex
public String className()
```

#### Return Type

**String**

String class name. Currently only used in the finalizer for logging purposes.

---

### `execute(context)`

This is the method that will be executed by the Queueable system. It accepts the context object
and calls the implementing class&#x27; `execute` method. It then creates a new instance of the OuroborosFinalizer
class and attaches it to the system context.

#### Signature

```apex
public virtual void execute(QueueableContext context)
```

#### Parameters

| Name    | Type             | Description                                                                          |
| ------- | ---------------- | ------------------------------------------------------------------------------------ |
| context | QueueableContext | QueueableContext The context object dependency injection in by the Queueable system. |

#### Return Type

**void**
