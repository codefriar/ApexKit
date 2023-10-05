`APIVERSION: 58`

`STATUS: ACTIVE`

## Fields

### `private codeDidTryToReEnqueue` → `Boolean`

a test only circuit breaker to ensure that the OuroborosFinalizer is called and that in turn it calls the Ouroboros code again.

---

## Methods

### `private static void testOuroborosFunctionalNegative()`

`ISTEST`

### `private static void testClassName()`

## `ISTEST`

## Classes

### ExampleOuroborosImplementation

This is an example implementation of Ouroboros that will be used to test the functionality

**Inheritance**

[Ouroboros](https://github.com/codefriar/ApexKit/wiki/Ouroboros)
&gt;
ExampleOuroborosImplementation

#### Fields

##### `private completedExecutions` → `Integer`

##### `private executionCount` → `Integer`

---

#### Methods

##### `public override Boolean hasExitCriteriaBeenMet()`

Required method that returns true if the exit criteria has been met.

###### Returns

| Type    | Description                                                        |
| ------- | ------------------------------------------------------------------ |
| Boolean | Boolean - true if the exit criteria has been met, false otherwise. |

##### `public override void execute()`

This is the method that will be called when the Ouroboros executes the job.

---

---
