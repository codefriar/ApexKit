**Inheritance**

[TriggerFramework](TriggerFramework.md)

## Fields

### `mts`

`TESTVISIBLE`

#### Signature

```apex
private mts
```

#### Type

[MetadataTriggerQueryService](MetadataTriggerQueryService.md)

---

### `triggers`

`TESTVISIBLE`

#### Signature

```apex
private triggers
```

#### Type

List&lt;Metadata_Driven_Trigger\_\_mdt&gt;

---

### `activeHandler`

`TESTVISIBLE`

#### Signature

```apex
private activeHandler
```

#### Type

[TriggerFramework](TriggerFramework.md)

---

### `triggerNew`

#### Signature

```apex
protected triggerNew
```

#### Type

List&lt;SObject&gt;

---

### `triggerOld`

#### Signature

```apex
protected triggerOld
```

#### Type

List&lt;SObject&gt;

---

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

## Constructors

### `MetadataTriggerFramework()`

Constructor used by live triggers.
Because this constructor makes live-use of a
metadata query service that will query live metadata
these two constructors are effectively un-testable without
requiring you to insert custom metadata.

#### Signature

```apex
public MetadataTriggerFramework()
```

---

### `MetadataTriggerFramework(triggerNew, triggerOld, context)`

Constructor used by Apex Triggers

#### Signature

```apex
public MetadataTriggerFramework(List<SObject> triggerNew, List<SObject> triggerOld, TriggerOperation context)
```

#### Parameters

| Name       | Type                | Description                                                  |
| ---------- | ------------------- | ------------------------------------------------------------ |
| triggerNew | List&lt;SObject&gt; | List&lt;SOBject&gt; the new version of the records           |
| triggerOld | List&lt;SObject&gt; | List&lt;SOBject&gt; the old version of the records           |
| context    | TriggerOperation    | TriggerOperation the context of the trigger ie: after update |

---

### `MetadataTriggerFramework(mts)`

`TESTVISIBLE`

Constructor used by unit tests

#### Signature

```apex
private MetadataTriggerFramework(MetadataTriggerQueryService mts)
```

#### Parameters

| Name | Type                                                          | Description                                                                   |
| ---- | ------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| mts  | [MetadataTriggerQueryService](MetadataTriggerQueryService.md) | MetadataTriggerQueryService a potentially mocked version of the query service |

## Methods

### `run()`

`SUPPRESSWARNINGS`

Overrides the standard Run() method, which allows this
metadata based trigger handler can be an incremental update / sit beside
other trigger handlers classes that are directly invoked by a trigger

#### Signature

```apex
public override void run()
```

#### Return Type

**void**

---

### `dispatch(activeHandler)`

method is responsible for calling delegated class methods on metadata specified classes.

#### Signature

```apex
private void dispatch(TriggerFramework activeHandler)
```

#### Parameters

| Name                                      | Type                                    | Description                                                                         |
| ----------------------------------------- | --------------------------------------- | ----------------------------------------------------------------------------------- |
| activeHandler                             | [TriggerFramework](TriggerFramework.md) | An instance of a class to have the appropriate method called on it. This class must |
| implement the TriggerFramework interface. |

#### Return Type

**void**

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

---

### `beforeInsert()`

_Inherited_

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

_Inherited_

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

_Inherited_

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

_Inherited_

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

_Inherited_

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

_Inherited_

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

_Inherited_

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature

```apex
protected virtual void afterUndelete()
```

#### Return Type

**void**
