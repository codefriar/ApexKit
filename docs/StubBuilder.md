`APIVERSION: 58`

`STATUS: ACTIVE`

Builder pattern for creating stubs with a fluent interface.
Note, there are three 'Builder' classes, each an inner class of the object that the builder builds. In this case,
this builder inner class is responsible for building Stub objects.
While you can directly instantiate the Stub class, the idea is that you will actually use the Builder
class/interface to create Stubs

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

### `public Object defineStub(Boolean generateInjectableStub)`

Generates a Stub object from this builder object.

#### Parameters

| Param                    | Description                                                   |
| ------------------------ | ------------------------------------------------------------- |
| `generateInjectableStub` | true, calls the stub objects' createStub method automatically |

#### Returns

| Type     | Description |
| -------- | ----------- |
| `Object` | `Stub`      |

### `public Stub defineStub()`

Method generates a Stub object from this builder object.

#### Returns

| Type   | Description                                     |
| ------ | ----------------------------------------------- |
| `Stub` | Stub object to be used to mock the object type. |

---
