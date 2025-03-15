Represents a method call that is mocked as part of a Stub
object. This class is marked

**IsTest**

, as the object and it&#x27;s methods are
not useful outside of a Test context.

This file contains not only the MockedMethod class, but an inner Builder
class. It is expected most developers will utilize the Builder class to
construct instances of MockedMethod.

## Fields

### `methodSignature`

`TESTVISIBLE`

Every MockedMethod has a methodSignature defining it&#x27;s
&#x27;signature&#x27; or combination of name, parameter names and parameter types.

#### Signature

```apex
private methodSignature
```

#### Type

[MethodSignature](MethodSignature.md)

---

### `expectedParameters`

#### Signature

```apex
private expectedParameters
```

#### Type

List&lt;Object&gt;

---

### `returnValue`

#### Signature

```apex
private returnValue
```

#### Type

Object

---

### `throwException`

#### Signature

```apex
private throwException
```

#### Type

Boolean

---

### `sObjectIds`

#### Signature

```apex
private sObjectIds
```

#### Type

List&lt;Id&gt;

---

### `customException`

#### Signature

```apex
private customException
```

#### Type

Exception

---

### `countOfMethodInvocations`

#### Signature

```apex
private countOfMethodInvocations
```

#### Type

Integer

---

### `exceptionMessage`

`TESTVISIBLE`

#### Signature

```apex
private static exceptionMessage
```

#### Type

String

## Constructors

### `MockedMethod(methodSignature)`

Constructor requiring a method signature. This is
used to prevent constructing MockedMethods without a signature.

#### Signature

```apex
public MockedMethod(MethodSignature methodSignature)
```

#### Parameters

| Name            | Type                                  | Description                                                                  |
| --------------- | ------------------------------------- | ---------------------------------------------------------------------------- |
| methodSignature | [MethodSignature](MethodSignature.md) | We need this to define the shape of the method,[object Object],being mocked. |

## Methods

### `handleCall()`

This method is invoked by it&#x27;s parent stub object, and is
responsible for returning the mocked value.

#### Signature

```apex
public Object handleCall()
```

#### Return Type

**Object**

,[object Object]

---

### `assertMockedMethodWasCalled()`

`SUPPRESSWARNINGS`

If this MockedMethod has not been called cause a failing
assertion.

#### Signature

```apex
public void assertMockedMethodWasCalled()
```

#### Return Type

**void**

---

### `withParameterValues(args)`

Allows developers to define expected input parameters at
execution time. This enables developers to mock the same method call N
number of times, with different input parameters.

#### Signature

```apex
public MockedMethod withParameterValues(List<Object> args)
```

#### Parameters

| Name | Type               | Description                                             |
| ---- | ------------------ | ------------------------------------------------------- |
| args | List&lt;Object&gt; | A list of Objects that you want to this MockedMethod to |

to respond to. These objects must exactly match what your code invokes
in order for your stub to return the specified mock output. |

#### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]

---

### `returning(returnValue)`

Sets this MockedMethod&#x27;s return value. This is the
value that will be returned by this mocked method when the stub calls
a method that has an identical name, signature and input paramter list.

#### Signature

```apex
public MockedMethod returning(Object returnValue)
```

#### Parameters

| Name        | Type   | Description                           |
| ----------- | ------ | ------------------------------------- |
| returnValue | Object | This is the object you want returned. |

#### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]

---

### `returning(incomingIds)`

Use this variant of returning when you want the
mocked method to return a list of sObjects (generic) with a specific set
of IDs

#### Signature

```apex
public MockedMethod returning(List<Id> incomingIds)
```

#### Parameters

| Name                                   | Type           | Description                                                      |
| -------------------------------------- | -------------- | ---------------------------------------------------------------- |
| incomingIds                            | List&lt;Id&gt; | A list of ID&#x27;s. Note, they don&#x27;t have to be ids of the |
| same sObject type. Order is preserved. |

#### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]

---

### `throwingException()`

Use this method when you need the mocked method to throw an
exception. Incredibly useful for testing exception handling!

Note: This variant results in a generic StubException being thrown.

#### Signature

```apex
public MockedMethod throwingException()
```

#### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]

---

### `throwingException(customException)`

Use this variant to have this mocked method return
a developer-specified exception object. Useful for testing exception
handling with specific exception types.

#### Signature

```apex
public MockedMethod throwingException(Exception customException)
```

#### Parameters

| Name            | Type      | Description |
| --------------- | --------- | ----------- |
| customException | Exception |             |

#### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]

---

### `doMethodSignaturesAndParametersMatch(methodSignature, runtimeParameters)`

determines if the current method call matches
on both a method signature level and against specified input parameters.

#### Signature

```apex
public Boolean doMethodSignaturesAndParametersMatch(MethodSignature methodSignature, List<Object> runtimeParameters)
```

#### Parameters

| Name                                      | Type                                  | Description                               |
| ----------------------------------------- | ------------------------------------- | ----------------------------------------- |
| methodSignature                           | [MethodSignature](MethodSignature.md) | A method signature to match against.      |
| runtimeParameters                         | List&lt;Object&gt;                    | a List of objects representing the actual |
| values - at runtime - of the method call. |

#### Return Type

**Boolean**

,[object Object]

---

### `doRuntimeParametersMatch(compareTo)`

Determines if the method, as brokered by the stub object
is being called with an expected set of parameters.

Note: I thought I could replace this with
`return this.methodParamsAtExecutionTime.equals(compareTo);`
but this doesn&#x27;t work, and to be honest, I&#x27;m still investigating why.

#### Signature

```apex
private Boolean doRuntimeParametersMatch(List<Object> compareTo)
```

#### Parameters

| Name      | Type               | Description |
| --------- | ------------------ | ----------- |
| compareTo | List&lt;Object&gt; |             |

#### Return Type

**Boolean**

,[object Object]

## Classes

### Builder Class

#### Fields

##### `methodSignatureBuilder`

###### Signature

```apex
private methodSignatureBuilder
```

###### Type

MethodSignature.Builder

---

##### `runtimeParameters`

###### Signature

```apex
private runtimeParameters
```

###### Type

List&lt;Object&gt;

---

##### `returnSObjectIds`

###### Signature

```apex
private returnSObjectIds
```

###### Type

List&lt;Id&gt;

---

##### `customException`

###### Signature

```apex
private customException
```

###### Type

Exception

---

##### `throwException`

###### Signature

```apex
private throwException
```

###### Type

Boolean

---

##### `returnValue`

###### Signature

```apex
private returnValue
```

###### Type

Object

#### Constructors

##### `Builder(methodSignatureBuilder, args)`

Constructor requiring a methodSignatureBuilder object
and a list of runtime arguments

###### Signature

```apex
public Builder(MethodSignature.Builder methodSignatureBuilder, List<System.Type> args)
```

###### Parameters

| Name                   | Type                    | Description |
| ---------------------- | ----------------------- | ----------- |
| methodSignatureBuilder | MethodSignature.Builder |             |
| args                   | List&lt;System.Type&gt; |             |

#### Methods

##### `setParameterValues(parameters)`

internal method used to set the parameter values of this
MockedMethod instance.

###### Signature

```apex
private MockedMethod.Builder setParameterValues(List<Object> parameters)
```

###### Parameters

| Name       | Type               | Description         |
| ---------- | ------------------ | ------------------- |
| parameters | List&lt;Object&gt; | list of System.Type |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterValues(parameter)`

convenience methodfor setting a single parameter type

###### Signature

```apex
public MockedMethod.Builder withParameterValues(Object parameter)
```

###### Parameters

| Name      | Type   | Description |
| --------- | ------ | ----------- |
| parameter | Object | System.Type |

###### Return Type

**MockedMethod.Builder**

this

---

##### `withParameterValues(parameter, parameter2)`

convenience methodfor setting two params

###### Signature

```apex
public MockedMethod.Builder withParameterValues(Object parameter, Object parameter2)
```

###### Parameters

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| parameter  | Object | System.Type |
| parameter2 | Object | System.Type |

###### Return Type

**MockedMethod.Builder**

this

---

##### `withParameterValues(parameter, parameter2, parameter3)`

convenience methodfor setting three params

###### Signature

```apex
public MockedMethod.Builder withParameterValues(Object parameter, Object parameter2, Object parameter3)
```

###### Parameters

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| parameter  | Object | System.Type |
| parameter2 | Object | System.Type |
| parameter3 | Object | System.Type |

###### Return Type

**MockedMethod.Builder**

return description

---

##### `withParameterValues(parameter, parameter2, parameter3, parameter4)`

`SUPPRESSWARNINGS`

convenience methodfor setting four parameters

###### Signature

```apex
public MockedMethod.Builder withParameterValues(Object parameter, Object parameter2, Object parameter3, Object parameter4)
```

###### Parameters

| Name       | Type   | Description            |
| ---------- | ------ | ---------------------- |
| parameter  | Object | parameter description  |
| parameter2 | Object | parameter2 description |
| parameter3 | Object | parameter3 description |
| parameter4 | Object | parameter4 description |

###### Return Type

**MockedMethod.Builder**

this

---

##### `returningObjectsWithIds(ids)`

This variant allows developers to specify a list of
IDs to be assigned to the returning sObject List

###### Signature

```apex
public Stub.Builder returningObjectsWithIds(List<Id> ids)
```

###### Parameters

| Name | Type           | Description                |
| ---- | -------------- | -------------------------- |
| ids  | List&lt;Id&gt; | The list of Ids to assign. |

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `returning(returnValue)`

This variant allows developers to specify the
object that will be returned when this mocked method is executed by
its parent stub.

###### Signature

```apex
public Stub.Builder returning(Object returnValue)
```

###### Parameters

| Name        | Type   | Description |
| ----------- | ------ | ----------- |
| returnValue | Object |             |

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `returning()`

This variant allows developers to specify a void return.

###### Signature

```apex
public Stub.Builder returning()
```

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `throwingException()`

This variant allows developers to throw an internally
generated Stub.StubException object when the method is executed.

###### Signature

```apex
public Stub.Builder throwingException()
```

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `throwingException(customException)`

Use this variant to have this mocked method
return a developer-specified exception object. Useful for testing
exception handling with specific exception types.

Note: This only works for custom exceptions.
Note: Developers construct your exception like this:
`<CustomExceptioType> customException = `
`new <CustomExceptionType>('message');`

###### Signature

```apex
public Stub.Builder throwingException(Exception customException)
```

###### Parameters

| Name            | Type      | Description |
| --------------- | --------- | ----------- |
| customException | Exception |             |

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `createMockedMethod(signature)`

Responsible for returning a fully formed
MockedMethod instance.

###### Signature

```apex
public MockedMethod createMockedMethod(MethodSignature signature)
```

###### Parameters

| Name      | Type                                  | Description |
| --------- | ------------------------------------- | ----------- |
| signature | [MethodSignature](MethodSignature.md) |             |

###### Return Type

**[MockedMethod](MockedMethod.md)**

,[object Object]
