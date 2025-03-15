An opinionated trigger handler framework.

## Fields

### `LOOP_COUNT_MAP`

A map of loop counters by handler name

#### Signature

```apex
private static final LOOP_COUNT_MAP
```

#### Type

Map&lt;String,TriggerFrameworkLoopCount&gt;

---

### `bypassedHandlers`

a set of handler names that are bypassed

#### Signature

```apex
public static bypassedHandlers
```

#### Type

Set&lt;String&gt;

---

### `triggerContext`

`TESTVISIBLE`

the current context of the trigger, override-able in tests

#### Signature

```apex
protected triggerContext
```

#### Type

[TriggerContext](TriggerContext.md)

## Methods

### `run()`

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

A method to guard against invalid execution contexts

#### Signature

```apex
protected Boolean standardValidationFails()
```

#### Return Type

**Boolean**

true if the execution context is invalid or if this trigger handler is bypassed

---

### `dispatchHandlerMethod(context)`

A method to dispatch the correct handler method within the handler class, based on the context

#### Signature

```apex
private void dispatchHandlerMethod(TriggerOperation context)
```

#### Parameters

| Name    | Type             | Description                |
| ------- | ---------------- | -------------------------- |
| context | TriggerOperation | The context of the trigger |

#### Return Type

**void**

---

### `setMaxLoopCount(max)`

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

---

### `beforeInsert()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

context methods

#### Signature

```apex
protected virtual void beforeInsert()
```

#### Return Type

**void**

---

### `beforeUpdate()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void beforeUpdate()
```

#### Return Type

**void**

---

### `beforeDelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void beforeDelete()
```

#### Return Type

**void**

---

### `afterInsert()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void afterInsert()
```

#### Return Type

**void**

---

### `afterUpdate()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void afterUpdate()
```

#### Return Type

**void**

---

### `afterDelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void afterDelete()
```

#### Return Type

**void**

---

### `afterUndelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void afterUndelete()
```

#### Return Type

**void**
