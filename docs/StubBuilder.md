`APIVERSION: 58`

`STATUS: ACTIVE`

StubBuilder is a class that allows you to build a Stub object for a given object type. The Stub object can then be used in unit tests to mock the object type.

# Using StubBuilder

## Overview

StubBuilder is designed to be an intuitive, fluent way to generate StubProvider based Stub objects with Mocked methods.
Developers writing unit tests can then dependency inject this Stub object into tested code to ensure that the tested code behaves as the developer expects for this test.

## Terms

-   Stub - A Stub is a replacement, test only implementation of a known Object type. It is expected that the Stub will be used in place of the real object in unit tests.
-   Mock - A Mock is a fake implementation of a known method on a stubbed object. Developers use Mocks to ensure that when the tested code calls this method, a known value or object is returned.
-   Fluent interface - A fluent interface is an object-oriented API that aims to provide the most readable code possible. Fluent interfaces are often chained together to create a readable, intuitive flow of code.

## Complexities of StubBuilder

-   In general, the StubBuilder provides method overloads for the various steps required to build a stub. This can result in some perceived complexity because the sheer number of examples needed to demonstrate full functionality.

## How the StubBuilder works

The StubBuilder implements the Salesforce provided System.StubProvider interface. The stub provider has a single, required method called `handleMethodCall`. This method is called by the system when the mocked method on the stubbed object is called. That method's signature is fairly complex and was designed to be very flexible. Stub builder is designed to help you construct the implementation of `handleMethodCall` in a fluent, intuitive way.

## StubBuilder Steps

1. You'll need to create a new StubBuilder object using the constructor. There's only one constructor, and it takes a Type object as it's one parameter. This type is the type you wish to create a Stub object for. Want to create a Stub object of your `AccountService` class? Create a new StubBuilder instance calling `new StubBuilder(AccountService.class)`. Note, you'll _always_ need to cast the generated stub back to the object type you're stubbing. To do so, you'll need code like this. `AccountService stubAccountService = (AccountService) new StubBuilder(AccountService.class);`
2. You'll want to mock one or more methods. Mocking a method involves several steps:
    1. Specifying the name of the method to be mocked. This is done by calling one of the variants of `mockingMethodCall(String nameOfMethod)`
    2. Specifying the types of the parameters used by the method to be mocked. This is done by calling one of the variants of `withParamTypes()`
    3. Specifying the values of the parameters used by the method to be mocked. This is done by calling one of the variants of `withParamValues()`. It's important to understand that you're setting up an expectation here. You're telling the system that when the mocked method is called with these parameters, the system should return the value you specify in the next step.
3. Finally, you'll want to specify the return value of the mocked method. This is done by calling one of the variants of `returning()`
   So long as those 3 steps are grouped together, you can mock as many methods as you'd like.
   At this point, with your stub created and methods mocked, you'll need to convert it from a StubBuilder to a StubProvider conforming Object. This is done by calling `defineStub()` on the StubBuilder object. This will return a StubProvider object that you can use in your tests. The result of this call is an object that you can cast to the type you're stubbing. For example, if you're stubbing an AccountService class, you'll need to cast the result of `defineStub()` to an AccountService object.

## Method Reference

### Constructor

`StubBuilder(Type typeToStub)` - Creates a new StubBuilder object. You'll only need to call this once per Stub object you wish to create.

### Mocking Methods

`mockingMethodCall(String nameOfMethod)` - Creates a mockedMethodCall specifying only the name. Use this variant for a method that requires no input parameters
`mockingMethodCall(String nameOfMethod, Type[] paramTypes)` - Creates a mockedMethodCall specifying the name and the types of the parameters. Use this variant for a method that requires input parameters.
`mockingMethodCall(String nameOfMethod, Type singleParam)` - Creates a mockedMethodCall specifying the name and the type of a single parameter. Use this variant for a method that requires a single input parameter.
`mockingMethodCall(String nameOfMethod, Type param1, Type param2)` - Creates a mockedMethodCall specifying the name and the types of two parameters. Use this variant for a method that requires two input parameters.
`mockingMethodCall(String nameOfMethod, Type param1, Type param2, Type param3)` - Creates a mockedMethodCall specifying the name and the types of three parameters. Use this variant for a method that requires three input parameters.
`mockingMethodCall(String nameOfMethod, Type param1, Type param2, Type param3, Type param4)` - Creates a mockedMethodCall specifying the name and the types of four parameters. Use this variant for a method that requires four input parameters.

### Setting Parameter Values

`withParameterValues(Object parameter)` - Sets the value of a single parameter. Use this variant for a method that requires a single input parameter.
`withParameterValues(Object param1, Object param2)` - Sets the values of two parameters. Use this variant for a method that requires two input parameters.
`withParameterValues(Object param1, Object param2, Object param3)` - Sets the values of three parameters. Use this variant for a method that requires three input parameters.
`withParameterValues(Object param1, Object param2, Object param3, Object param4)` - Sets the values of four parameters. Use this variant for a method that requires four input parameters.

### Setting Return Values

`returning(Object returnValue)` - Sets the return value of the mocked method. Use this variant for a method that returns a single object/value.
`returning(List&lt;Id&gt; returningIds)` - Sets the return value of the mocked method. Use this variant when you want the mocked method to return a specific list of ids.

### Forcing the mocked method to throw an exception

`throwingException()` - Sets the mocked method to throw an exception. Use this variant when you want the mocked method to throw a generic exception.
`throwingException(Exception exception)` - Sets the mocked method to throw the specified exception. Use this variant when you want the mocked method to throw an exception that you construct.

## Examples

Given the following class:

```apex
public with sharing class AccountRepository {
    public List&lt;Account&gt; getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
    public Account getAccountById(Id accountId) {
        return [SELECT Id, Name FROM Account WHERE Id = :accountId];
    }
}
```

You can mock these methods using the StubBuilder like this:

```apex
AccountRepository stubAccountRepository = (AccountRepository) new StubBuilder(AccountRepository.class)
    .mockingMethodCall('getAccounts')
    .returning(new List&lt;Account&gt;())
    .mockingMethodCall('getAccountById', Id.class)
    .withParameterValues('001000000000000')
    .returning(new Account())
    .defineStub();
```

When injected into a test, the stubAccountRepository will act as an AccountRepository object. When the `getAccounts` method is called by the code being tested it will return an empty list. Likewise, when then the `getAccountById` method is called by the code being tested, it will return an empty Account object.

**See** [Stub](https://github.com/codefriar/ApexKit/wiki/Stub)

## Constructors

### `public StubBuilder(Type objType)`

Constructor requiring the objectType. We do that to enforce that all Stub builders have an object type.

#### Parameters

| Param     | Description               |
| --------- | ------------------------- |
| `objType` | Type class: ie. Foo.class |

---

## Fields

### `private objectType` → `Type`

holds the System.Type reference for the object that you're building a stub for.

### `private signatureBuilders` → `List<MethodSignature.Builder>`

Internally, we need to maintain a list of signature builder objects so that we can roll-up the creation of objects.

---

## Methods

### `public MethodSignature mockingMethodCall(String methodName, List<Type> paramTypes)`

This method, and it's overloaded variants below, all work to add a new MockedMethod to the stub object. Semantically the idea is that you'll invoke one of these 'mockingMethodCall' methods for every method you want your stub to react to. Because this builder class is designed around method chaining, you can invoke a number of these in a row. See the example invocation at the top of this class.

#### Parameters

| Param        | Description                                                    |
| ------------ | -------------------------------------------------------------- |
| `methodName` | Required, name of the method that will be mocked               |
| `paramTypes` | List of System.Types that the mocked method should respond to. |

#### Returns

| Type              | Description                                                          |
| ----------------- | -------------------------------------------------------------------- |
| `MethodSignature` | `MethodSignature.Builder` - returns the builder object for chaining. |

### `public MethodSignature mockingMethodCall(String methodName)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters

| Param        | Description               |
| ------------ | ------------------------- |
| `methodName` | Method name to be mocked. |

#### Returns

| Type              | Description               |
| ----------------- | ------------------------- |
| `MethodSignature` | `MethodSignature.Builder` |

### `public MockedMethod mockingMethodCall(String methodName, Type paramType)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | Type of single parameter.           |

#### Returns

| Type           | Description               |
| -------------- | ------------------------- |
| `MockedMethod` | `MethodSignature.Builder` |

### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2)`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |

#### Returns

| Type           | Description               |
| -------------- | ------------------------- |
| `MockedMethod` | `MethodSignature.Builder` |

### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3)`

`SUPPRESSWARNINGS`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |
| `paramType3` | param type 3.                       |

#### Returns

| Type           | Description               |
| -------------- | ------------------------- |
| `MockedMethod` | `MethodSignature.Builder` |

### `public MockedMethod mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3, Type paramType4)`

`SUPPRESSWARNINGS`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters

| Param        | Description                         |
| ------------ | ----------------------------------- |
| `methodName` | required. method name to be mocked. |
| `paramType`  | param type 1.                       |
| `paramType2` | param type 2.                       |
| `paramType3` | param type 3.                       |
| `paramType4` | param type 4.                       |

#### Returns

| Type           | Description               |
| -------------- | ------------------------- |
| `MockedMethod` | `MethodSignature.Builder` |

### `public Object defineStub()`

Method generates a Stub object from this builder object.

#### Returns

| Type     | Description                                     |
| -------- | ----------------------------------------------- |
| `Object` | Stub object to be used to mock the object type. |

---
