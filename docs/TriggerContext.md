## Fields

### `context`

the TriggerOperation this context revolves arround

#### Signature

```apex
public context
```

#### Type

TriggerOperation

---

### `isTriggerBeingTested`

A boolean override for testing purposes

#### Signature

```apex
public isTriggerBeingTested
```

#### Type

Boolean

## Constructors

### `TriggerContext()`

A default contstructor that sets the context to null and override to false

#### Signature

```apex
public TriggerContext()
```

## Methods

### `isInvalidExecutionContext()`

make sure this trigger should continue to run

#### Signature

```apex
public Boolean isInvalidExecutionContext()
```

#### Return Type

**Boolean**

,[object Object], true if the trigger should continue to run

#### Throws

[TriggerFrameworkException](TriggerFrameworkException.md): thrown when executing outside of a,[object Object],trigger

---

### `setTriggerContext(overriddenContext, overrideForTesting)`

`TESTVISIBLE`

Internal method for manually setting the trigger context

#### Signature

```apex
private void setTriggerContext(String overriddenContext, Boolean overrideForTesting)
```

#### Parameters

| Name               | Type    | Description                               |
| ------------------ | ------- | ----------------------------------------- |
| overriddenContext  | String  | The current trigger Context               |
| overrideForTesting | Boolean | Is the trigger running in a test context? |

#### Return Type

**void**

---

### `setContextDuringNormalExecution()`

A method to set the trigger context during normal system execution.

#### Signature

```apex
private void setContextDuringNormalExecution()
```

#### Return Type

**void**

---

### `setManuallyOverriddenContext(overriddenContext)`

A private test visible method for manually overriding the context

#### Signature

```apex
private void setManuallyOverriddenContext(String overriddenContext)
```

#### Parameters

| Name              | Type   | Description                  |
| ----------------- | ------ | ---------------------------- |
| overriddenContext | String | the context to forcibly set. |

#### Return Type

**void**
