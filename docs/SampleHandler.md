`ISTEST`

This class is a sample trigger handler for use while testing
the metadataTriggerHandler. Because custom metadata cannot be inserted, and
because the MetadataTriggerHandler instantiates handler classes from custom
metadata records, even when we stub/mock the metadata record retrieval we
still need an actual class that it can instantiate.

Note, this class is annotated with

**IsTest**

to prevent its use outside of
tests, not because it contains tests.

**Inheritance**

[TriggerFramework](TriggerFramework.md)

## Fields

### `bypassedHandlers`

_Inherited_

a set of handler names that are bypassed

#### Signature

```apex
public static bypassedHandlers
```

#### Type

Set&lt;String&gt;

---

### `triggerContext`

_Inherited_

`TESTVISIBLE`

the current context of the trigger, override-able in tests

#### Signature

```apex
protected triggerContext
```

#### Type

[TriggerContext](TriggerContext.md)

## Methods

### `beforeInsert()`

#### Signature

```apex
public override void beforeInsert()
```

#### Return Type

**void**

---

### `beforeUpdate()`

#### Signature

```apex
public override void beforeUpdate()
```

#### Return Type

**void**

---

### `afterInsert()`

#### Signature

```apex
public override void afterInsert()
```

#### Return Type

**void**

---

### `afterUpdate()`

#### Signature

```apex
public override void afterUpdate()
```

#### Return Type

**void**

---

### `beforeDelete()`

#### Signature

```apex
public override void beforeDelete()
```

#### Return Type

**void**

---

### `afterDelete()`

#### Signature

```apex
public override void afterDelete()
```

#### Return Type

**void**

---

### `afterUndelete()`

#### Signature

```apex
public override void afterUndelete()
```

#### Return Type

**void**

---

### `run()`

_Inherited_

This is main brokering method that is called by the trigger.
It&#x27;s responsible for determining the proper context, and calling the
correct method

#### Signature

```apex
public virtual void run()
```

#### Return Type

**void**

#### Example

AccountTriggerFramework.run();

---

### `standardValidationFails()`

_Inherited_

A method to guard against invalid execution contexts

#### Signature

```apex
protected Boolean standardValidationFails()
```

#### Return Type

**Boolean**

true if the execution context is invalid or if this trigger handler is bypassed

---

### `setMaxLoopCount(max)`

_Inherited_

Allows developers to prevent trigger loops, or allow
a limited number of them by setting the maximum number of times
this trigger is called.

#### Signature

```apex
public void setMaxLoopCount(Integer max)
```

#### Parameters

| Name                         | Type    | Description                                           |
| ---------------------------- | ------- | ----------------------------------------------------- |
| max                          | Integer | A valid number (generally 1) of times you&#x27;d like |
| to allow the trigger to run. |

#### Return Type

**void**

#### Example

In the context of a TriggerFramework class,
this.setMaxLoopCount(5);

---

### `clearMaxLoopCount()`

_Inherited_

Allows developers to turn off the max loop count

#### Signature

```apex
public void clearMaxLoopCount()
```

#### Return Type

**void**

#### Example

In the context of a TriggerFramework class,
this.clearMaxLoopCount();

---

### `bypass(handlerName)`

_Inherited_

Allows developers to conditionally bypass (disable)
other triggers that _also_ implement this TriggerFramework

#### Signature

```apex
public static void bypass(String handlerName)
```

#### Parameters

| Name        | Type   | Description                                          |
| ----------- | ------ | ---------------------------------------------------- |
| handlerName | String | Class name (String) of the trigger handler to bypass |

#### Return Type

**void**

#### Example

TriggerFramework.bypass(&#x27;AccountTriggerFramework&#x27;);

---

### `clearBypass(handlerName)`

_Inherited_

Removes a given trigger handler class name from
the list of bypassed trigger handlers.

#### Signature

```apex
public static void clearBypass(String handlerName)
```

#### Parameters

| Name        | Type   | Description                                       |
| ----------- | ------ | ------------------------------------------------- |
| handlerName | String | Handler class name to remove from the bypass list |

#### Return Type

**void**

#### Example

TriggerFramework.clearBypass(&#x27;AccountTriggerFramework&#x27;);

---

### `isBypassed(handlerName)`

_Inherited_

Allows developers to check whether a given trigger
handler class is currently bypassed.

#### Signature

```apex
public static Boolean isBypassed(String handlerName)
```

#### Parameters

| Name        | Type   | Description                                        |
| ----------- | ------ | -------------------------------------------------- |
| handlerName | String | The name of the trigger handler class to check for |

#### Return Type

**Boolean**

,[object Object]

#### Example

TriggerFramework.isBypassed(&#x27;AccountTriggerFramework&#x27;);

---

### `clearAllBypasses()`

_Inherited_

removes all classes from the bypass list

#### Signature

```apex
public static void clearAllBypasses()
```

#### Return Type

**void**

#### Example

TriggerFramework.clearAllBypasses();

---

### `addToLoopCount()`

_Inherited_

`TESTVISIBLE`

private instance methods

#### Signature

```apex
protected void addToLoopCount()
```

#### Return Type

**void**

---

### `getHandlerName()`

_Inherited_

`TESTVISIBLE`

Returns the string version of the handler class being
invoked

#### Signature

```apex
protected String getHandlerName()
```

#### Return Type

**String**

,[object Object], Name of the Handler
