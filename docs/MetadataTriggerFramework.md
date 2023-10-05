`STATUS: ACTIVE`

A metadata driven extension of the TriggerFramework class

**Inheritance**

[TriggerFramework](https://github.com/codefriar/ApexKit/wiki/TriggerFramework)
&gt;
MetadataTriggerFramework

## Constructors

### `public MetadataTriggerFramework()`

Constructor used by live triggers. Because this constructor makes live-use of a metadata query service that will query live metadata these two constructors are effectively un-testable without requiring you to insert custom metadata.

### `public MetadataTriggerFramework(List<SObject> triggerNew, List<SObject> triggerOld, TriggerOperation context)`

Constructor used by Apex Triggers

#### Parameters

| Param        | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| `triggerNew` | List<SOBject> the new version of the records                 |
| `triggerOld` | List<SOBject> the old version of the records                 |
| `context`    | TriggerOperation the context of the trigger ie: after update |

### `private MetadataTriggerFramework(MetadataTriggerQueryService mts)`

`TESTVISIBLE`

Constructor used by unit tests

#### Parameters

| Param | Description                                                                   |
| ----- | ----------------------------------------------------------------------------- |
| `mts` | MetadataTriggerQueryService a potentially mocked version of the query service |

---

## Fields

### `private activeHandler` → `TriggerFramework`

`TESTVISIBLE`

### `public bypassedHandlers` → `Set<String>`

_Inherited_

a set of handler names that are bypassed

### `private mts` → `MetadataTriggerQueryService`

`TESTVISIBLE`

### `protected triggerContext` → `TriggerContext`

_Inherited_
`TESTVISIBLE`

the current context of the trigger, override-able in tests

### `protected triggerNew` → `List<SObject>`

### `protected triggerOld` → `List<SObject>`

### `private triggers` → `List<Metadata_Driven_Trigger__mdt>`

`TESTVISIBLE`

---

## Methods

### `public override void run()`

`SUPPRESSWARNINGS`

Overrides the standard Run() method, which allows this metadata based trigger handler can be an incremental update / sit beside other trigger handlers classes that are directly invoked by a trigger

### `private void dispatch(TriggerFramework activeHandler)`

method is responsible for calling delegated class methods on metadata specified classes.

#### Parameters

| Param           | Description                                                                                                                   |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `activeHandler` | An instance of a class to have the appropriate method called on it. This class must implement the TriggerFramework interface. |

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

### `protected void afterInsert()`

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
