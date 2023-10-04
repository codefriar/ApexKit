# Stub

`ISTEST`

This class helps you construct and manage StubProvider
conforming objects for use in Unit Tests. It, along with it's companion
classes:

-   MockedMethod
-   MethodSignature
    and their builder-pattern inner classes are designed to work together
    with a fluent API style like this:

```apex
StubObject fooStub = new StubObject.Builder('foo.class')
.mockingMethodCall('someMethodName', List&lt;Object&gt; Params)
.withParameterTypes()
.returning() || .throwingException() || .throwingException(ExceptionObj)
.mockingMethodCall('secondMethodName', ...)
.withParameterTypes()
.returning() || .throwingException() || .throwingException(ExceptionObj)
.createStub()
```

**Implemented types**

[System.StubProvider](System.StubProvider)

## Constructors

### `public Stub(Type objectType)`

required constructor finalizing the object type.

#### Parameters

| Param        | Description               |
| ------------ | ------------------------- |
| `objectType` | Type class: ie: Foo.class |

### `public Stub(Type objectType, List<MockedMethod> mockedMethods)`

convenience constructor that accepts a pre-built list of MockedMethod objects.

#### Parameters

| Param           | Description                  |
| --------------- | ---------------------------- |
| `objectType`    | type class: ie. Foo.class    |
| `mockedMethods` | List of MockedMethod objects |

---

## Fields

### `private mockedMethods` → `List<MockedMethod>`

`TESTVISIBLE`

### `private objectType` → `Type`

---

## Methods

### `public Object handleMethodCall(Object obj, String methodName, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> args)`

`SUPPRESSWARNINGS`

method required by the StubProvider interface. Handles the mock execution of the given method call.

#### Parameters

| Param        | Description                                                                                                                             |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| `obj`        | dependency injected by Apex, object the mock method was call upon                                                                       |
| `methodName` | dependency injected by Apex, string representation of the name of the method used to construct a MethodSignature object for comparison. |
| `returnType` | dependency injected by Apex, not currently used.                                                                                        |
| `paramTypes` | dependency injected by Apex, list of parameter types used to construct a MethodSignature object for comparison.                         |
| `paramNames` | dependency injected by Apex, not currently used.                                                                                        |
| `args`       | dependency injected by Apex, not currently used.                                                                                        |

#### Returns

| Type   | Description |
| ------ | ----------- |
| Object | `Object`    |

### `public void assertAllMockedMethodsWereCalled()`

Useful for asserting the methods you mocked were, in fact, called. It does this by invoking the assertMockedMethodWasCalled on each individual mocked method.

### `public Object createStub()`

returns the this constructed class with it's mocked methods as a single stub object to be used in a unit test.

#### Returns

| Type   | Description                                                |
| ------ | ---------------------------------------------------------- |
| Object | `Object` Needs to be cast back to the type of object used. |

---

## Classes

### Builder

Builder pattern for creating stubs with a fluent interface.
Note, there are three 'Builder' classes, each an inner class of the
object that the builder builds. In this case, this builder inner class
is responsible for building Stub objects.
While you can directly instantiate the Stub class, the idea is that you
will actually use the Builder class/interface to create Stubs

#### Constructors

##### `public Builder(Type objType)`

Constructor requiring the objectType. We do that to enforce that all Stub builders have an object type.

###### Parameters

| Param     | Description               |
| --------- | ------------------------- |
| `objType` | Type class: ie. Foo.class |

---

#### Fields

##### `private objectType` → `Type`

holds the System.Type reference for the object that you're building a stub for.

##### `private signatureBuilders` → `List&lt;MethodSignature.Builder&gt;`

Internally, we need to maintain a list of signature builder objects so that we can roll-up the creation of objects.

---

#### Methods

##### `public MethodSignature mockingMethodCall(String methodName, List&lt;Type&gt; paramTypes)`

This method, and it's overloaded variants below, all work to add a new MockedMethod to the stub object. Semantically the idea is that you'll invoke one of these 'mockingMethodCall' methods for every method you want your stub to react to. Because this builder class is designed around method chaining, you can invoke a number of these in a row. See the example invocation at the top of this class.

###### Parameters

| Param        | Description                                                    |
| ------------ | -------------------------------------------------------------- |
| `methodName` | Required, name of the method that will be mocked               |
| `paramTypes` | List of System.Types that the mocked method should respond to. |

###### Returns

| Type            | Description                                                          |
| --------------- | -------------------------------------------------------------------- |
| MethodSignature | `MethodSignature.Builder` - returns the builder object for chaining. |

##### `public MethodSignature mockingMethodCall(String methodName)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

###### Parameters

| Param        | Description               |
| ------------ | ------------------------- |
| `methodName` | Method name to be mocked. |

###### Returns

| Type            | Description               |
| --------------- | ------------------------- |
| MethodSignature | `MethodSignature.Builder` |

##### `public MockedMethod mockingMethodCall(String methodName, Type paramType)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

###### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | Type of single parameter.           |

###### Returns

| Type         | Description               |
| ------------ | ------------------------- |
| MockedMethod | `MethodSignature.Builder` |

##### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

###### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |

###### Returns

| Type         | Description               |
| ------------ | ------------------------- |
| MockedMethod | `MethodSignature.Builder` |

##### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3)`

`SUPPRESSWARNINGS`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

###### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |
| `paramType3` | param type 3.                       |

###### Returns

| Type         | Description               |
| ------------ | ------------------------- |
| MockedMethod | `MethodSignature.Builder` |

##### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3, Type paramType4)`

`SUPPRESSWARNINGS`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

###### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |
| `paramType3` | param type 3.                       |
| `paramType4` | param type 4.                       |

###### Returns

| Type         | Description               |
| ------------ | ------------------------- |
| MockedMethod | `MethodSignature.Builder` |

##### `public Object defineStub(Boolean generateInjectableStub)`

Generates a Stub object from this builder object.

###### Parameters

| Param                    | Description                                                   |
| ------------------------ | ------------------------------------------------------------- |
| `generateInjectableStub` | true, calls the stub objects' createStub method automatically |

###### Returns

| Type   | Description |
| ------ | ----------- |
| Object | `Stub`      |

##### `public Stub defineStub()`

Method generates a Stub object from this builder object.

###### Returns

| Type | Description                                     |
| ---- | ----------------------------------------------- |
| Stub | Stub object to be used to mock the object type. |

---

### StubException

Class is used by Stub, MethodSignature and MockedMethod
classes for throwing when an exception occurs that is specifically
related to building, using or asserting against the Super Stub framework

**Inheritance**

StubException

---
