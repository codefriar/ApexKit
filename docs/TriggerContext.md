`STATUS: ACTIVE`

A class encapsulating the trigger context. Before/after insert/update/delete etc.

## Constructors

### `public TriggerContext()`

A default contstructor that sets the context to null and override to false

---

## Fields

### `public context` → `TriggerOperation`

the TriggerOperation this context revolves arround

### `public isTriggerBeingTested` → `Boolean`

A boolean override for testing purposes

---

## Methods

### `public Boolean isInvalidExecutionContext()`

make sure this trigger should continue to run

#### Returns

| Type    | Description                                          |
| ------- | ---------------------------------------------------- |
| Boolean | `Boolean` true if the trigger should continue to run |

#### Throws

| Exception                   | Description                                |
| --------------------------- | ------------------------------------------ |
| `TriggerFrameworkException` | thrown when executing outside of a trigger |

### `private void setTriggerContext(String overriddenContext, Boolean overrideForTesting)`

`TESTVISIBLE`

Internal method for manually setting the trigger context

#### Parameters

| Param                | Description                               |
| -------------------- | ----------------------------------------- |
| `overriddenContext`  | The current trigger Context               |
| `overrideForTesting` | Is the trigger running in a test context? |

### `private void setContextDuringNormalExecution()`

A method to set the trigger context during normal system execution.

### `private void setManuallyOverriddenContext(String overriddenContext)`

A private test visible method for manually overriding the context

#### Parameters

| Param               | Description                  |
| ------------------- | ---------------------------- |
| `overriddenContext` | the context to forcibly set. |

---
