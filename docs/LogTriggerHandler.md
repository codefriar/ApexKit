# LogTriggerHandler

Class handles the post-insert processing of Log events
<br>Extends the TriggerFramework class
<br>Enables the user to define if this handler should silently
ignore errors thrown by dml, or if it should throw a log
exception

**Inheritance**

[TriggerFramework](https://github.com/codefriar/ApexKit/wiki/TriggerFramework)
&gt;
LogTriggerHandler

## Constructors

### `public LogTriggerHandler(List<Log__e> logs, Boolean shouldThrow)`

Constructor, called by trigger.

#### Parameters

| Param         | Description                                                           |
| ------------- | --------------------------------------------------------------------- |
| `logs`        | Logs to process                                                       |
| `shouldThrow` | if true, this class will throw a log exception when DML errors occur. |

### `public LogTriggerHandler(List<Log__e> logs)`

convenience constructor, calls previous constructor but will not throw a log exception on dml errors

#### Parameters

| Param  | Description     |
| ------ | --------------- |
| `logs` | logs to process |

---

## Fields

### `public bypassedHandlers` → `Set<String>`

_Inherited_

a set of handler names that are bypassed

### `private logs` → `List<Log__e>`

### `private shouldThrow` → `Boolean`

### `protected triggerContext` → `TriggerContext`

_Inherited_
`TESTVISIBLE`

the current context of the trigger, override-able in tests

---

## Methods

### `public override void afterInsert()`

Overridden from TriggerFramework. TriggerFramework executes this method when the trigger context is after insert

#### Throws

| Exception      | Description                                   |
| -------------- | --------------------------------------------- |
| `LogException` | on Database.insert failure isSuccess is false |

### `public void run()`

_Inherited_

This is main brokering method that is called by the trigger. It's responsible for determining the proper context, and calling the correct method

#### Example

```apex
AccountTriggerFramework.run();
```

### `protected Boolean standardValidationFails()`

_Inherited_

A method to guard against invalid execution contexts

#### Returns

| Type    | Description                                                                     |
| ------- | ------------------------------------------------------------------------------- |
| Boolean | true if the execution context is invalid or if this trigger handler is bypassed |

### `public void setMaxLoopCount(Integer max)`

_Inherited_

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

_Inherited_

Allows developers to turn off the max loop count

#### Example

```apex
In the context of a TriggerFramework class,
this.clearMaxLoopCount();
```

### `public static void bypass(String handlerName)`

_Inherited_

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

_Inherited_

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

_Inherited_

Allows developers to check whether a given trigger handler class is currently bypassed.

#### Parameters

| Param         | Description                                        |
| ------------- | -------------------------------------------------- |
| `handlerName` | The name of the trigger handler class to check for |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `Boolean`   |

#### Example

```apex
TriggerFramework.isBypassed('AccountTriggerFramework');
```

### `public static void clearAllBypasses()`

_Inherited_

removes all classes from the bypass list

#### Example

```apex
TriggerFramework.clearAllBypasses();
```

### `protected void addToLoopCount()`

_Inherited_

`TESTVISIBLE`

private instance methods

### `protected String getHandlerName()`

_Inherited_

`TESTVISIBLE`

Returns the string version of the handler class being invoked

#### Returns

| Type   | Description                  |
| ------ | ---------------------------- |
| String | `String` Name of the Handler |

### `protected void beforeInsert()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

context methods

### `protected void beforeUpdate()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void beforeDelete()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUpdate()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterDelete()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUndelete()`

_Inherited_

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

---
