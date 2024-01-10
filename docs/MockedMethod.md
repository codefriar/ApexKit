`APIVERSION: 58`

`STATUS: ACTIVE`

Represents a method call that is mocked as part of a Stub
object. This class is marked

**IsTest** , as the object and it's methods are not useful outside of a Test context. This file contains not only the MockedMethod class, but an inner Builder class. It is expected most developers will utilize the Builder class to construct instances of MockedMethod.

## Constructors

### `public MockedMethod(MethodSignature methodSignature)`

Constructor requiring a method signature. This is used to prevent constructing MockedMethods without a signature.

#### Parameters

| Param             | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| `methodSignature` | We need this to define the shape of the method being mocked. |

---

## Fields

### `private countOfMethodInvocations` → `Integer`

### `private customException` → `Exception`

### `private exceptionMessage` → `String`

`TESTVISIBLE`

### `private expectedParameters` → `List<Object>`

### `private methodSignature` → `MethodSignature`

`TESTVISIBLE`

Every MockedMethod has a methodSignature defining it's 'signature' or combination of name, parameter names and parameter types.

### `private returnValue` → `Object`

### `private sObjectIds` → `List<Id>`

### `private throwException` → `Boolean`

---

## Methods

### `public Object handleCall()`

This method is invoked by it's parent stub object, and is responsible for returning the mocked value.

#### Returns

| Type     | Description |
| -------- | ----------- |
| `Object` | `Object`    |

### `public void assertMockedMethodWasCalled()`

`SUPPRESSWARNINGS`

If this MockedMethod has not been called cause a failing assertion.

### `public MockedMethod withParameterValues(List<Object> args)`

Allows developers to define expected input parameters at execution time. This enables developers to mock the same method call N number of times, with different input parameters.

#### Parameters

| Param  | Description                                                                                                                                                                                |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `args` | A list of Objects that you want to this MockedMethod to to respond to. These objects must exactly match what your code invokes in order for your stub to return the specified mock output. |

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

### `public MockedMethod returning(Object returnValue)`

Sets this MockedMethod's return value. This is the value that will be returned by this mocked method when the stub calls a method that has an identical name, signature and input paramter list.

#### Parameters

| Param         | Description                           |
| ------------- | ------------------------------------- |
| `returnValue` | This is the object you want returned. |

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

### `public MockedMethod returning(List<Id> incomingIds)`

Use this variant of returning when you want the mocked method to return a list of sObjects (generic) with a specific set of IDs

#### Parameters

| Param         | Description                                                                                   |
| ------------- | --------------------------------------------------------------------------------------------- |
| `incomingIds` | A list of ID's. Note, they don't have to be ids of the same sObject type. Order is preserved. |

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

### `public MockedMethod throwingException()`

Use this method when you need the mocked method to throw an exception. Incredibly useful for testing exception handling! Note: This variant results in a generic StubException being thrown.

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

### `public MockedMethod throwingException(Exception customException)`

Use this variant to have this mocked method return a developer-specified exception object. Useful for testing exception handling with specific exception types.

#### Parameters

| Param             | Description |
| ----------------- | ----------- |
| `customException` |             |

#### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

### `public Boolean doMethodSignaturesAndParametersMatch(MethodSignature methodSignature, List<Object> runtimeParameters)`

determines if the current method call matches on both a method signature level and against specified input parameters.

#### Parameters

| Param               | Description                                                                         |
| ------------------- | ----------------------------------------------------------------------------------- |
| `methodSignature`   | A method signature to match against.                                                |
| `runtimeParameters` | a List of objects representing the actual values - at runtime - of the method call. |

#### Returns

| Type      | Description |
| --------- | ----------- |
| `Boolean` | `Boolean`   |

### `private Boolean doRuntimeParametersMatch(List<Object> compareTo)`

Determines if the method, as brokered by the stub object is being called with an expected set of parameters. Note: I thought I could replace this with `return this.methodParamsAtExecutionTime.equals(compareTo);` but this doesn't work, and to be honest, I'm still investigating why.

#### Parameters

| Param       | Description |
| ----------- | ----------- |
| `compareTo` |             |

#### Returns

| Type      | Description |
| --------- | ----------- |
| `Boolean` | `Boolean`   |

---

## Classes

### Builder

**Description** class provides a 'builder' or fluent interface for constructing MockedMethod objects. While the end-developer can create MockedMethod objects directly, the point of this class is to provide an intuitive and easy-to-use/comprehend interface for building nuanced MockedMethod Objects.

#### Constructors

##### `public Builder(MethodSignature methodSignatureBuilder, List&lt;System.Type&gt; args)`

Constructor requiring a methodSignatureBuilder object and a list of runtime arguments

###### Parameters

| Param                    | Description |
| ------------------------ | ----------- |
| `methodSignatureBuilder` |             |
| `args`                   |             |

---

#### Fields

##### `private customException` → `Exception`

##### `private methodSignatureBuilder` → `MethodSignature`

##### `private returnSObjectIds` → `List&lt;Id&gt;`

##### `private returnValue` → `Object`

##### `private runtimeParameters` → `List&lt;Object&gt;`

##### `private throwException` → `Boolean`

---

#### Methods

##### `private MockedMethod setParameterValues(List&lt;Object&gt; parameters)`

internal method used to set the parameter values of this MockedMethod instance.

###### Parameters

| Param        | Description         |
| ------------ | ------------------- |
| `parameters` | list of System.Type |

###### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

##### `public MockedMethod withParameterValues(Object parameter)`

convenience methodfor setting a single parameter type

###### Parameters

| Param       | Description |
| ----------- | ----------- |
| `parameter` | System.Type |

###### Returns

| Type           | Description |
| -------------- | ----------- |
| `MockedMethod` | this        |

##### `public MockedMethod withParameterValues(Object parameter, Object parameter2)`

convenience methodfor setting two params

###### Parameters

| Param        | Description |
| ------------ | ----------- |
| `parameter`  | System.Type |
| `parameter2` | System.Type |

###### Returns

| Type           | Description |
| -------------- | ----------- |
| `MockedMethod` | this        |

##### `public MockedMethod withParameterValues(Object parameter, Object parameter2, Object parameter3)`

convenience methodfor setting three params

###### Parameters

| Param        | Description |
| ------------ | ----------- |
| `parameter`  | System.Type |
| `parameter2` | System.Type |
| `parameter3` | System.Type |

###### Returns

| Type           | Description        |
| -------------- | ------------------ |
| `MockedMethod` | return description |

##### `public MockedMethod withParameterValues(Object parameter, Object parameter2, Object parameter3, Object parameter4)`

`SUPPRESSWARNINGS`

convenience methodfor setting four parameters

###### Parameters

| Param        | Description            |
| ------------ | ---------------------- |
| `parameter`  | parameter description  |
| `parameter2` | parameter2 description |
| `parameter3` | parameter3 description |
| `parameter4` | parameter4 description |

###### Returns

| Type           | Description |
| -------------- | ----------- |
| `MockedMethod` | this        |

##### `public Stub returningObjectsWithIds(List&lt;Id&gt; ids)`

This variant allows developers to specify a list of IDs to be assigned to the returning sObject List

###### Parameters

| Param | Description                |
| ----- | -------------------------- |
| `ids` | The list of Ids to assign. |

###### Returns

| Type   | Description            |
| ------ | ---------------------- |
| `Stub` | `MockedMethod.Builder` |

##### `public Stub returning(Object returnValue)`

This variant allows developers to specify the object that will be returned when this mocked method is executed by its parent stub.

###### Parameters

| Param         | Description |
| ------------- | ----------- |
| `returnValue` |             |

###### Returns

| Type   | Description    |
| ------ | -------------- |
| `Stub` | `Stub.Builder` |

##### `public Stub returning()`

This variant allows developers to specify a void return.

###### Returns

| Type   | Description    |
| ------ | -------------- |
| `Stub` | `Stub.Builder` |

##### `public Stub throwingException()`

This variant allows developers to throw an internally generated Stub.StubException object when the method is executed.

###### Returns

| Type   | Description    |
| ------ | -------------- |
| `Stub` | `Stub.Builder` |

##### `public Stub throwingException(Exception customException)`

Use this variant to have this mocked method return a developer-specified exception object. Useful for testing exception handling with specific exception types. Note: This only works for custom exceptions. Note: Developers construct your exception like this: `&lt;CustomExceptioType&gt; customException = ` `new &lt;CustomExceptionType&gt;('message');`

###### Parameters

| Param             | Description |
| ----------------- | ----------- |
| `customException` |             |

###### Returns

| Type   | Description    |
| ------ | -------------- |
| `Stub` | `MockedMethod` |

##### `public MockedMethod createMockedMethod(MethodSignature signature)`

Responsible for returning a fully formed MockedMethod instance.

###### Parameters

| Param       | Description |
| ----------- | ----------- |
| `signature` |             |

###### Returns

| Type           | Description    |
| -------------- | -------------- |
| `MockedMethod` | `MockedMethod` |

---

---
