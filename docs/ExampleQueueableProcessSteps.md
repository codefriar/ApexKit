`APIVERSION: 58`

`STATUS: ACTIVE`

This class contains two inner classes used for testing the QueueableProcess framework.

## Fields

### `private handleExceptionCalled` → `Boolean`

`TESTVISIBLE`

A 'circuit breaker' to be tripped when the handle exception method is called. This is only used for testing.

---

## Methods

### `public static Account fetchAccountByIdForDemoPurposes(Id accountId)`

A de-duplication effort to fetch the account by ID. Used only by this class' examples.

#### Parameters

| Param       | Description             |
| ----------- | ----------------------- |
| `accountId` | Id account id to fetch. |

#### Returns

| Type      | Description                                          |
| --------- | ---------------------------------------------------- |
| `Account` | Account returns the account object referenced by id. |

---

## Classes

### Step1

Step1 is an inner class that conforms to QueueableProcess. It represents an example step in a
process that updates an account's shipping street. It also increments the data passthrough by 1.

**Inheritance**

[QueueableProcess](https://github.com/codefriar/ApexKit/wiki/QueueableProcess)
&gt;
Step1

#### Constructors

##### `public Step1()`

`SUPPRESSWARNINGS`

This is a required no-arg/no-opp constructor. When/if the class is instantiated by the error handler, this constructor is used.

##### `public Step1(Id accountId)`

The normal constructor. Accepts a accountId.

###### Parameters

| Param       | Description                   |
| ----------- | ----------------------------- |
| `accountId` | Id the account id to process. |

---

#### Fields

##### `private accountId` → `Id`

The Account Id to work with

---

#### Methods

##### `public override void execute()`

This is the main execute method required by the QueueableProcess abstract class. This is where developers will place the code to execute asynchronously in this step. In this case, all it does is fetch an account and increment the shipping street by 1. #riviting.

##### `public override void handleException(Exception e)`

This is an optionally overridable method from the QueueableProcess abstract class. If this method is defined on your class, should the execute method above fail at runtime, the QueueableProcess finalizer will instantiate this class, and call this method. This allows developers to write per-step customized error handling. In this case, we're just setting a static boolean to true so we can test the functionality.

###### Parameters

| Param | Description                     |
| ----- | ------------------------------- |
| `e`   | Exception any exception object. |

---

### Step2

This is a second example of a QueueableProcess step. It's very similar to the first, but it
manipulates the account phone field.

**Inheritance**

[QueueableProcess](https://github.com/codefriar/ApexKit/wiki/QueueableProcess)
&gt;
Step2

#### Constructors

##### `public Step2()`

`SUPPRESSWARNINGS`

a no-arg/no-opp constructor. This is required for the QueueableProcess framework to be instantiated dynamically should an error condition occur during the execution of the process.

##### `public Step2(Id accountId)`

Standard constructor accepting an account id.

###### Parameters

| Param       | Description                   |
| ----------- | ----------------------------- |
| `accountId` | Id the account id to process. |

---

#### Fields

##### `private accountId` → `Id`

The Account Id to work with

---

#### Methods

##### `public override void execute()`

This is the main execute method required by the QueueableProcess abstract class. This is where developers will place the code they want to execute asynchronously in this step. In this case, all it does update the account phone field when the data Passthrough isn't null.

---

---
