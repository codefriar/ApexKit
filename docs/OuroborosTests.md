## Fields

### `codeDidTryToReEnqueue`

a test only circuit breaker to ensure that the OuroborosFinalizer is called and that
in turn it calls the Ouroboros code again.

#### Signature

```apex
private codeDidTryToReEnqueue
```

#### Type

Boolean

## Methods

### `testOuroborosFunctionalNegative()`

`ISTEST`

#### Signature

```apex
private static void testOuroborosFunctionalNegative()
```

#### Return Type

**void**

---

### `testClassName()`

`ISTEST`

#### Signature

```apex
private static void testClassName()
```

#### Return Type

**void**

## Classes

### ExampleOuroborosImplementation Class

This is an example implementation of Ouroboros that will be used to test the functionality

#### Fields

##### `executionCount`

###### Signature

```apex
private executionCount
```

###### Type

Integer

---

##### `completedExecutions`

###### Signature

```apex
private completedExecutions
```

###### Type

Integer

#### Methods

##### `hasExitCriteriaBeenMet()`

Required method that returns true if the exit criteria has been met.

###### Signature

```apex
public override Boolean hasExitCriteriaBeenMet()
```

###### Return Type

**Boolean**

Boolean - true if the exit criteria has been met, false otherwise.

---

##### `execute()`

This is the method that will be called when the Ouroboros executes the job.

###### Signature

```apex
public override void execute()
```

###### Return Type

**void**
