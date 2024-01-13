`APIVERSION: 58`

`STATUS: ACTIVE`

This class helps you construct and manage StubProvider conforming objects for use in Unit Tests. It,
along with it's companion classes:

-   MockedMethod
-   MethodSignature
    and their builder-pattern inner classes are designed to work together with a fluent API style like this:

**Implemented types**

[System.StubProvider](System.StubProvider)

**See** [MockedMethod](https://github.com/codefriar/ApexKit/wiki/MockedMethod)

**See** [MethodSignature](https://github.com/codefriar/ApexKit/wiki/MethodSignature)

**See** [StubBuilder](https://github.com/codefriar/ApexKit/wiki/StubBuilder)

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

| Type     | Description |
| -------- | ----------- |
| `Object` | `Object`    |

### `public void assertAllMockedMethodsWereCalled()`

Useful for asserting the methods you mocked were, in fact, called. It does this by invoking the assertMockedMethodWasCalled on each individual mocked method.

### `public Object createStub()`

returns the this constructed class with it's mocked methods as a single stub object to be used in a unit test.

#### Returns

| Type     | Description                                                |
| -------- | ---------------------------------------------------------- |
| `Object` | `Object` Needs to be cast back to the type of object used. |

---

## Classes

### StubException

Class is used by Stub, MethodSignature and MockedMethod
classes for throwing when an exception occurs that is specifically
related to building, using or asserting against the Super Stub framework

**Inheritance**

StubException

---
