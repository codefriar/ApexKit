# MethodSignature

`ISTEST`

Class models a callable apex method's 'signature' or combination
of Name, Parameter types and Parameter values. This is separate from a
MockedMethod, because it can be constructed at runtime for comparison against
established MockedMethods.

## Constructors

### `public MethodSignature(String methodName, List<Type> paramTypes)`

Constructor requiring a method name and list of parameters. This method cannot be constructed without these.

#### Parameters

| Param        | Description                                        |
| ------------ | -------------------------------------------------- |
| `methodName` | String Name of the method to be mocked             |
| `paramTypes` | List<System.Type> of the parameters for the method |

---

## Fields

### `private methodName` → `String`

`TESTVISIBLE`

### `private methodParameterTypes` → `List<Type>`

`TESTVISIBLE`

---

## Methods

### `public Boolean verifySignatureMatch(MethodSignature otherSignature)`

This is used to compare the signature of a MockedMethod, against another instance. Used at runtime to compare an actually requested method call against pre-defined mocks.

#### Parameters

| Param            | Description                                             |
| ---------------- | ------------------------------------------------------- |
| `otherSignature` | the secondary MethodSignature object to compare against |

#### Returns

| Type    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| Boolean | `Boolean` true if the signatures match, false if they do not |

### `private static Boolean verifyMethodNamesMatch(String originalMethodName, String comparatorMethodName)`

Returns true if the current MethodSignature's methodName is a case insensitive match to the comparison's methodName

#### Parameters

| Param                  | Description                               |
| ---------------------- | ----------------------------------------- |
| `originalMethodName`   | String name of the method name called     |
| `comparatorMethodName` | String name of the method name to compare |

#### Returns

| Type    | Description                               |
| ------- | ----------------------------------------- |
| Boolean | `Boolean` true if the method names match, |

### `public String getMethodName()`

returns the method name for this signature

#### Returns

| Type   | Description        |
| ------ | ------------------ |
| String | String method name |

---

## Classes

### Builder

While a MethodSignature object can be created directly the
more common use case is to use this Builder class to construct the
MethodSignature object in a Fluent api style.

#### Constructors

##### `public Builder(Stub builder, String methodName, List&lt;System.Type&gt; paramTypes)`

Constructor.

###### Parameters

| Param        | Description                                                                         |
| ------------ | ----------------------------------------------------------------------------------- |
| `builder`    | A Stub.Builder object                                                               |
| `methodName` | String referencing the name of the method minus things like ()                      |
| `paramTypes` | A list of System.Types that define the order and type of parameters for the method. |

---

#### Fields

##### `private methodBuilders` → `List&lt;MockedMethod.Builder&gt;`

##### `private methodName` → `String`

`TESTVISIBLE`

##### `public parameterTypes` → `List&lt;Type&gt;`

##### `private stubBuilder` → `Stub`

---

#### Methods

##### `public MockedMethod withParameterTypes()`

This variant handles the situation where a mocked method was called without parameters.

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public MockedMethod withParameterTypes(List&lt;System.Type&gt; parameters)`

Omnibus variant that handles a list(N) of parameters.

###### Parameters

| Param        | Description                           |
| ------------ | ------------------------------------- |
| `parameters` | List&lt;System.Type&gt; of parameters |

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public MockedMethod withParameterTypes(System parameter)`

This variant handles a single parameter, brokers to omnibus method.

###### Parameters

| Param       | Description           |
| ----------- | --------------------- |
| `parameter` | Type of the parameter |

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public MockedMethod withParameterTypes(System parameter, System parameter2)`

Two parameter variant. Brokers to omnibus method.

###### Parameters

| Param        | Description                  |
| ------------ | ---------------------------- |
| `parameter`  | Type of the parameter        |
| `parameter2` | Type of the second parameter |

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public MockedMethod withParameterTypes(System parameter, System parameter2, System parameter3)`

Three parameter variant. Brokers to omnibus method.

###### Parameters

| Param        | Description                  |
| ------------ | ---------------------------- |
| `parameter`  | Type of the parameter        |
| `parameter2` | Type of the second parameter |
| `parameter3` | Type of the third parameter  |

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public MockedMethod withParameterTypes(System parameter, System parameter2, System parameter3, System parameter4)`

`SUPPRESSWARNINGS`

Four parameter variant. Brokers to omnibus method.

###### Parameters

| Param        | Description                  |
| ------------ | ---------------------------- |
| `parameter`  | Type of the parameter        |
| `parameter2` | Type of the second parameter |
| `parameter3` | Type of the third parameter  |
| `parameter4` | Type of the fourth parameter |

###### Returns

| Type         | Description            |
| ------------ | ---------------------- |
| MockedMethod | `MockedMethod.Builder` |

##### `public Stub finalizeSignature()`

Called at the end of building a method signature.

###### Returns

| Type | Description    |
| ---- | -------------- |
| Stub | `Stub.Builder` |

##### `public List buildMockedMethod()`

Creates the MockedMethod matching this method signature.

###### Returns

| Type                     | Description                |
| ------------------------ | -------------------------- |
| List&lt;MockedMethod&gt; | `List&lt;MockedMethod&gt;` |

---

---
