`TESTVISIBLE`

## Fields

### `TRIGGER_CONTEXT_ERROR`

#### Signature

```apex
private static final TRIGGER_CONTEXT_ERROR
```

#### Type

String

---

### `lastMethodCalled`

#### Signature

```apex
private static lastMethodCalled
```

#### Type

String

---

### `handler`

#### Signature

```apex
private static handler
```

#### Type

TriggerFrameworkTests.TestHandler

## Methods

### `testBeforeInsert()`

`ISTEST`

unit tests

#### Signature

```apex
private static void testBeforeInsert()
```

#### Return Type

**void**

---

### `testBeforeUpdate()`

`ISTEST`

#### Signature

```apex
private static void testBeforeUpdate()
```

#### Return Type

**void**

---

### `testBeforeDelete()`

`ISTEST`

#### Signature

```apex
private static void testBeforeDelete()
```

#### Return Type

**void**

---

### `testAfterInsert()`

`ISTEST`

#### Signature

```apex
private static void testAfterInsert()
```

#### Return Type

**void**

---

### `testAfterUpdate()`

`ISTEST`

#### Signature

```apex
private static void testAfterUpdate()
```

#### Return Type

**void**

---

### `testAfterDelete()`

`ISTEST`

#### Signature

```apex
private static void testAfterDelete()
```

#### Return Type

**void**

---

### `testAfterUndelete()`

`ISTEST`

#### Signature

```apex
private static void testAfterUndelete()
```

#### Return Type

**void**

---

### `testNonTriggerContext()`

`ISTEST`

#### Signature

```apex
private static void testNonTriggerContext()
```

#### Return Type

**void**

---

### `testBypassAPI()`

`ISTEST`

#### Signature

```apex
private static void testBypassAPI()
```

#### Return Type

**void**

---

### `testLoopCount()`

`ISTEST`

#### Signature

```apex
private static void testLoopCount()
```

#### Return Type

**void**

---

### `testLoopCountClass()`

`ISTEST`

#### Signature

```apex
private static void testLoopCountClass()
```

#### Return Type

**void**

---

### `testGetHandlerName()`

`ISTEST`

#### Signature

```apex
private static void testGetHandlerName()
```

#### Return Type

**void**

---

### `testVirtualMethods()`

`ISTEST`

#### Signature

```apex
private static void testVirtualMethods()
```

#### Return Type

**void**

---

### `resetTest()`

testing utilities

#### Signature

```apex
private static void resetTest()
```

#### Return Type

**void**

---

### `beforeInsertMode()`

#### Signature

```apex
private static void beforeInsertMode()
```

#### Return Type

**void**

---

### `beforeUpdateMode()`

#### Signature

```apex
private static void beforeUpdateMode()
```

#### Return Type

**void**

---

### `beforeDeleteMode()`

#### Signature

```apex
private static void beforeDeleteMode()
```

#### Return Type

**void**

---

### `afterInsertMode()`

#### Signature

```apex
private static void afterInsertMode()
```

#### Return Type

**void**

---

### `afterUpdateMode()`

#### Signature

```apex
private static void afterUpdateMode()
```

#### Return Type

**void**

---

### `afterDeleteMode()`

#### Signature

```apex
private static void afterDeleteMode()
```

#### Return Type

**void**

---

### `afterUndeleteMode()`

#### Signature

```apex
private static void afterUndeleteMode()
```

#### Return Type

**void**

## Classes

### TestHandler Class

`TESTVISIBLE`

test implementation of the TriggerHandler

#### Methods

##### `beforeInsert()`

###### Signature

```apex
public override void beforeInsert()
```

###### Return Type

**void**

---

##### `beforeUpdate()`

###### Signature

```apex
public override void beforeUpdate()
```

###### Return Type

**void**

---

##### `beforeDelete()`

###### Signature

```apex
public override void beforeDelete()
```

###### Return Type

**void**

---

##### `afterInsert()`

###### Signature

```apex
public override void afterInsert()
```

###### Return Type

**void**

---

##### `afterUpdate()`

###### Signature

```apex
public override void afterUpdate()
```

###### Return Type

**void**

---

##### `afterDelete()`

###### Signature

```apex
public override void afterDelete()
```

###### Return Type

**void**

---

##### `afterUndelete()`

###### Signature

```apex
public override void afterUndelete()
```

###### Return Type

**void**
