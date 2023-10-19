`STATUS: ACTIVE`

An opinionated trigger handler framework.

## Fields

### `private LOOP_COUNT_MAP` → `Map<String,TriggerFrameworkLoopCount>`

A map of loop counters by handler name

### `public bypassedHandlers` → `Set<String>`

a set of handler names that are bypassed

### `protected triggerContext` → `TriggerContext`

`TESTVISIBLE`

the current context of the trigger, override-able in tests

---

## Methods

### `public void run()`

This is main brokering method that is called by the trigger. It's responsible for determining the proper context, and calling the correct method

#### Example

```apex
AccountTriggerFramework.run();
```

### `protected Boolean standardValidationFails()`

A method to guard against invalid execution contexts

#### Returns

| Type      | Description                                                                     |
| --------- | ------------------------------------------------------------------------------- |
| `Boolean` | true if the execution context is invalid or if this trigger handler is bypassed |

### `private void dispatchHandlerMethod(TriggerOperation context)`

A method to dispatch the correct handler method within the handler class, based on the context

#### Parameters

| Param     | Description                |
| --------- | -------------------------- |
| `context` | The context of the trigger |

### `public void setMaxLoopCount(Integer max)`

Allows developers to prevent trigger loops, or allow a limited number of them by setting the maximum number of times this trigger is called.

#### Parameters

| Param | Description                                                                   |
| ----- | ----------------------------------------------------------------------------- |
| `max` | A valid number (generally 1) of times you'd like to allow the trigger to run. |

#### Example

```apex
In the context of a TriggerFramework class,
this.setMaxLoopCount(5);
```

### `public void clearMaxLoopCount()`

Allows developers to turn off the max loop count

#### Example

```apex
In the context of a TriggerFramework class,
this.clearMaxLoopCount();
```

### `public static void bypass(String handlerName)`

Allows developers to conditionally bypass (disable) other triggers that _also_ implement this TriggerFramework

#### Parameters

| Param         | Description                                          |
| ------------- | ---------------------------------------------------- |
| `handlerName` | Class name (String) of the trigger handler to bypass |

#### Example

```apex
TriggerFramework.bypass('AccountTriggerFramework');
```

### `public static void clearBypass(String handlerName)`

Removes a given trigger handler class name from the list of bypassed trigger handlers.

#### Parameters

| Param         | Description                                       |
| ------------- | ------------------------------------------------- |
| `handlerName` | Handler class name to remove from the bypass list |

#### Example

```apex
TriggerFramework.clearBypass('AccountTriggerFramework');
```

### `public static Boolean isBypassed(String handlerName)`

Allows developers to check whether a given trigger handler class is currently bypassed.

#### Parameters

| Param         | Description                                        |
| ------------- | -------------------------------------------------- |
| `handlerName` | The name of the trigger handler class to check for |

#### Returns

| Type      | Description |
| --------- | ----------- |
| `Boolean` | `Boolean`   |

#### Example

```apex
TriggerFramework.isBypassed('AccountTriggerFramework');
```

### `public static void clearAllBypasses()`

removes all classes from the bypass list

#### Example

```apex
TriggerFramework.clearAllBypasses();
```

### `protected void addToLoopCount()`

`TESTVISIBLE`

private instance methods

### `protected String getHandlerName()`

`TESTVISIBLE`

Returns the string version of the handler class being invoked

#### Returns

| Type     | Description                  |
| -------- | ---------------------------- |
| `String` | `String` Name of the Handler |

### `protected void beforeInsert()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

context methods

### `protected void beforeUpdate()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void beforeDelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterInsert()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUpdate()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterDelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUndelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

---
