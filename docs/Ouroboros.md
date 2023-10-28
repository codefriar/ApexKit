`STATUS: ACTIVE`

Ouroboros is the ancient mythical symbol of a dragon or serpent eating its own tail. It's often
understood as a reference to the circle of life, or the never ending nature life and death. In this case, it's a
reference to a Queueable object that enqueues itself when it's done executing via a OuroborosFinalizer. This is a
useful pattern when you need to process high volumes of data, but don't care if it's processed in real time.

**Implemented types**

[Queueable](Queueable)
,
[Database.AllowsCallouts](Database.AllowsCallouts)

## Fields

### `public passthrough` → `Object`

Object that will be passed through to the next iteration of the Ouroboros.

---

## Methods

### `public Boolean hasExitCriteriaBeenMet()`

This is the method that implementing classes must override. It's the method that will be called to determine if whether or not to re-enqueue the Ouroboros Queueable.

#### Returns

| Type    | Description                                     |
| ------- | ----------------------------------------------- |
| Boolean | Boolean True if the exit criteria has been met. |

### `public void execute()`

This is the method that will be called as the executable portion of the Queueable. It's the method developers will populate with their business logic to execute on each iteration of the Ouroboros.

### `public String className()`

This method is to be deprecated shortly, in favor of the lookup system built in QueueableProcess.

#### Returns

| Type   | Description                                                                   |
| ------ | ----------------------------------------------------------------------------- |
| String | String class name. Currently only used in the finalizer for logging purposes. |

### `public void execute(QueueableContext context)`

This is the method that will be executed by the Queueable system. It accepts the context object and calls the implementing class' `execute` method. It then creates a new instance of the OuroborosFinalizer class and attaches it to the system context.

#### Parameters

| Param     | Description                                                                          |
| --------- | ------------------------------------------------------------------------------------ |
| `context` | QueueableContext The context object dependency injection in by the Queueable system. |

---
