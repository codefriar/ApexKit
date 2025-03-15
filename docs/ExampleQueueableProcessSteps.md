This class contains two inner classes used for testing the QueueableProcess framework.

## Fields

### `handleExceptionCalled`

`TESTVISIBLE`

A &#x27;circuit breaker&#x27; to be tripped when the handle exception method is called. This is only
used for testing.

#### Signature

```apex
private static handleExceptionCalled
```

#### Type

Boolean

## Methods

### `fetchAccountByIdForDemoPurposes(accountId)`

A de-duplication effort to fetch the account by ID. Used only by this class&#x27; examples.

#### Signature

```apex
public static Account fetchAccountByIdForDemoPurposes(Id accountId)
```

#### Parameters

| Name      | Type | Description             |
| --------- | ---- | ----------------------- |
| accountId | Id   | Id account id to fetch. |

#### Return Type

**Account**

Account returns the account object referenced by id.

## Classes

### Step1 Class

Step1 is an inner class that conforms to QueueableProcess. It represents an example step in a
process that updates an account&#x27;s shipping street. It also increments the data passthrough by 1.

#### Fields

##### `accountId`

The Account Id to work with

###### Signature

```apex
private final accountId
```

###### Type

Id

#### Constructors

##### `Step1()`

`SUPPRESSWARNINGS`

This is a required no-arg/no-opp constructor. When/if the class is instantiated by the
error handler, this constructor is used.

###### Signature

```apex
public Step1()
```

---

##### `Step1(accountId)`

The normal constructor. Accepts a accountId.

###### Signature

```apex
public Step1(Id accountId)
```

###### Parameters

| Name      | Type | Description                   |
| --------- | ---- | ----------------------------- |
| accountId | Id   | Id the account id to process. |

#### Methods

##### `execute()`

This is the main execute method required by the QueueableProcess abstract class. This is where
developers will place the code to execute asynchronously in this step. In this case, all it does is fetch
an account and increment the shipping street by 1. #riviting.

###### Signature

```apex
public override void execute()
```

###### Return Type

**void**

---

##### `handleException(e)`

This is an optionally overridable method from the QueueableProcess abstract class. If this
method is defined on your class, should the execute method above fail at runtime, the QueueableProcess
finalizer will instantiate this class, and call this method. This allows developers to write per-step
customized error handling. In this case, we&#x27;re just setting a static boolean to true so we can test the
functionality.

###### Signature

```apex
public override void handleException(Exception e)
```

###### Parameters

| Name | Type      | Description                     |
| ---- | --------- | ------------------------------- |
| e    | Exception | Exception any exception object. |

###### Return Type

**void**

### Step2 Class

This is a second example of a QueueableProcess step. It&#x27;s very similar to the first, but it
manipulates the account phone field.

#### Fields

##### `accountId`

The Account Id to work with

###### Signature

```apex
private final accountId
```

###### Type

Id

#### Constructors

##### `Step2()`

`SUPPRESSWARNINGS`

a no-arg/no-opp constructor. This is required for the QueueableProcess framework to be
instantiated dynamically should an error condition occur during the execution of the process.

###### Signature

```apex
public Step2()
```

---

##### `Step2(accountId)`

Standard constructor accepting an account id.

###### Signature

```apex
public Step2(Id accountId)
```

###### Parameters

| Name      | Type | Description                   |
| --------- | ---- | ----------------------------- |
| accountId | Id   | Id the account id to process. |

#### Methods

##### `execute()`

This is the main execute method required by the QueueableProcess abstract class. This is where
developers will place the code they want to execute asynchronously in this step. In this case, all it does
update the account phone field when the data Passthrough isn&#x27;t null.

###### Signature

```apex
public override void execute()
```

###### Return Type

**void**
