This class helps you construct and manage StubProvider
conforming objects for use in Unit Tests. It, along with it&#x27;s companion
classes:

- MockedMethod
- MethodSignature
  and their builder-pattern inner classes are designed to work together
  with a fluent API style like this:

```apex
StubObject fooStub = new StubObject.Builder('foo.class')
.mockingMethodCall('someMethodName', List<Object> Params)
.withParameterTypes()
.returning() || .throwingException() || .throwingException(ExceptionObj)
.mockingMethodCall('secondMethodName', ...)
.withParameterTypes()
.returning() || .throwingException() || .throwingException(ExceptionObj)
.createStub()

```

**Implements**

System.StubProvider

## Fields

### `objectType`

#### Signature

```apex
private final objectType
```

#### Type

Type

---

### `mockedMethods`

`TESTVISIBLE`

#### Signature

```apex
private mockedMethods
```

#### Type

List&lt;MockedMethod&gt;

## Constructors

### `Stub(objectType)`

required constructor finalizing the object type.

#### Signature

```apex
public Stub(Type objectType)
```

#### Parameters

| Name       | Type | Description               |
| ---------- | ---- | ------------------------- |
| objectType | Type | Type class: ie: Foo.class |

---

### `Stub(objectType, mockedMethods)`

convenience constructor that accepts a pre-built
list of MockedMethod objects.

#### Signature

```apex
public Stub(Type objectType, List<MockedMethod> mockedMethods)
```

#### Parameters

| Name          | Type                     | Description                  |
| ------------- | ------------------------ | ---------------------------- |
| objectType    | Type                     | type class: ie. Foo.class    |
| mockedMethods | List&lt;MockedMethod&gt; | List of MockedMethod objects |

## Methods

### `handleMethodCall(obj, methodName, returnType, paramTypes, paramNames, args)`

`SUPPRESSWARNINGS`

method required by the StubProvider interface. Handles
the mock execution of the given method call.

#### Signature

```apex
public Object handleMethodCall(Object obj, String methodName, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> args)
```

#### Parameters

| Name          | Type   | Description                                         |
| ------------- | ------ | --------------------------------------------------- |
| obj           | Object | dependency injected by Apex, object the mock method |
| was call upon |
| methodName    | String | dependency injected by Apex, string representation  |

of the name of the method used to construct a
MethodSignature object for comparison. |
| returnType | Type | dependency injected by Apex, not currently used. |
| paramTypes | List&lt;Type&gt; | dependency injected by Apex, list of parameter types
used to construct a MethodSignature object for
comparison. |
| paramNames | List&lt;String&gt; | dependency injected by Apex, not currently used. |
| args | List&lt;Object&gt; | dependency injected by Apex, not currently used. |

#### Return Type

**Object**

,[object Object]

---

### `assertAllMockedMethodsWereCalled()`

Useful for asserting the methods you mocked were, in fact,
called. It does this by invoking the assertMockedMethodWasCalled on each
individual mocked method.

#### Signature

```apex
public void assertAllMockedMethodsWereCalled()
```

#### Return Type

**void**

---

### `createStub()`

returns the this constructed class with it&#x27;s mocked methods
as a single stub object to be used in a unit test.

#### Signature

```apex
public Object createStub()
```

#### Return Type

**Object**

,[object Object], Needs to be cast back to the type of object used.

## Classes

### Builder Class

Builder pattern for creating stubs with a fluent interface.
Note, there are three &#x27;Builder&#x27; classes, each an inner class of the
object that the builder builds. In this case, this builder inner class
is responsible for building Stub objects.

While you can directly instantiate the Stub class, the idea is that you
will actually use the Builder class/interface to create Stubs

#### Fields

##### `objectType`

holds the System.Type reference for the object that
you&#x27;re building a stub for.

###### Signature

```apex
private final objectType
```

###### Type

Type

---

##### `signatureBuilders`

Internally, we need to maintain a list of signature
builder objects so that we can roll-up the creation of objects.

###### Signature

```apex
private final signatureBuilders
```

###### Type

List&lt;MethodSignature.Builder&gt;

#### Constructors

##### `Builder(objType)`

Constructor requiring the objectType. We do that to
enforce that all Stub builders have an object type.

###### Signature

```apex
public Builder(Type objType)
```

###### Parameters

| Name    | Type | Description               |
| ------- | ---- | ------------------------- |
| objType | Type | Type class: ie. Foo.class |

#### Methods

##### `mockingMethodCall(methodName, paramTypes)`

This method, and it&#x27;s overloaded variants below,
all work to add a new MockedMethod to the stub object. Semantically
the idea is that you&#x27;ll invoke one of these &#x27;mockingMethodCall&#x27;
methods for every method you want your stub to react to. Because this
builder class is designed around method chaining, you can invoke a
number of these in a row. See the example invocation at the top of
this class.

###### Signature

```apex
public MethodSignature.Builder mockingMethodCall(String methodName, List<Type> paramTypes)
```

###### Parameters

| Name        | Type             | Description                                        |
| ----------- | ---------------- | -------------------------------------------------- |
| methodName  | String           | Required, name of the method that will be mocked   |
| paramTypes  | List&lt;Type&gt; | List of System.Types that the mocked method should |
| respond to. |

###### Return Type

**MethodSignature.Builder**

,[object Object], - returns the builder,[object Object],object for chaining.

---

##### `mockingMethodCall(methodName)`

Overloaded variant of the main &#x27;mockingMethodCall&#x27;
method. See docs for the first instance of mockingMethodCall in this
class.

###### Signature

```apex
public MethodSignature.Builder mockingMethodCall(String methodName)
```

###### Parameters

| Name       | Type   | Description               |
| ---------- | ------ | ------------------------- |
| methodName | String | Method name to be mocked. |

###### Return Type

**MethodSignature.Builder**

,[object Object]

---

##### `mockingMethodCall(methodName, paramType)`

Overloaded variant of the main &#x27;mockingMethodCall&#x27;
method. See docs for the first instance of mockingMethodCall in this
class.

###### Signature

```apex
public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType)
```

###### Parameters

| Name       | Type   | Description                         |
| ---------- | ------ | ----------------------------------- |
| methodName | String | required. method name to be mocked. |
| paramType  | Type   | Type of single parameter.           |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `mockingMethodCall(methodName, paramType, paramType2)`

Overloaded variant of the main &#x27;mockingMethodCall&#x27;
method. See docs for the first instance of mockingMethodCall in this
class.

###### Signature

```apex
public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType, Type paramType2)
```

###### Parameters

| Name       | Type   | Description                         |
| ---------- | ------ | ----------------------------------- |
| methodName | String | required. method name to be mocked. |
| paramType  | Type   | param type 1.                       |
| paramType2 | Type   | param type 2.                       |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `mockingMethodCall(methodName, paramType, paramType2, paramType3)`

`SUPPRESSWARNINGS`

Overloaded variant of the main &#x27;mockingMethodCall&#x27;
method. See docs for the first instance of mockingMethodCall in this
class.

###### Signature

```apex
public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3)
```

###### Parameters

| Name       | Type   | Description                         |
| ---------- | ------ | ----------------------------------- |
| methodName | String | required. method name to be mocked. |
| paramType  | Type   | param type 1.                       |
| paramType2 | Type   | param type 2.                       |
| paramType3 | Type   | param type 3.                       |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `mockingMethodCall(methodName, paramType, paramType2, paramType3, paramType4)`

`SUPPRESSWARNINGS`

Overloaded variant of the main &#x27;mockingMethodCall&#x27;
method. See docs for the first instance of mockingMethodCall in this
class.

###### Signature

```apex
public MockedMethod.Builder mockingMethodCall(String methodName, Type paramType, Type paramType2, Type paramType3, Type paramType4)
```

###### Parameters

| Name       | Type   | Description                         |
| ---------- | ------ | ----------------------------------- |
| methodName | String | required. method name to be mocked. |
| paramType  | Type   | param type 1.                       |
| paramType2 | Type   | param type 2.                       |
| paramType3 | Type   | param type 3.                       |
| paramType4 | Type   | param type 4.                       |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `defineStub(generateInjectableStub)`

Generates a Stub object from this builder object.

###### Signature

```apex
public Object defineStub(Boolean generateInjectableStub)
```

###### Parameters

| Name                   | Type    | Description                                                        |
| ---------------------- | ------- | ------------------------------------------------------------------ |
| generateInjectableStub | Boolean | true, calls the stub objects&#x27; createStub method automatically |

###### Return Type

**Object**

,[object Object]

---

##### `defineStub()`

Method generates a Stub object from this builder object.

###### Signature

```apex
public Stub defineStub()
```

###### Return Type

**[Stub](Stub.md)**

Stub object to be used to mock the object type.

### StubException Class

Class is used by Stub, MethodSignature and MockedMethod
classes for throwing when an exception occurs that is specifically
related to building, using or asserting against the Super Stub framework
