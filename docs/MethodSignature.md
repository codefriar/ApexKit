Class models a callable apex method&#x27;s &#x27;signature&#x27; or combination
of Name, Parameter types and Parameter values. This is separate from a
MockedMethod, because it can be constructed at runtime for comparison against
established MockedMethods.

## Fields

### `methodName`

`TESTVISIBLE`

#### Signature

```apex
private methodName
```

#### Type

String

---

### `methodParameterTypes`

`TESTVISIBLE`

#### Signature

```apex
private methodParameterTypes
```

#### Type

List&lt;Type&gt;

## Constructors

### `MethodSignature(methodName, paramTypes)`

Constructor requiring a method name and list of parameters. This method cannot be constructed
without these.

#### Signature

```apex
public MethodSignature(String methodName, List<Type> paramTypes)
```

#### Parameters

| Name       | Type             | Description                                              |
| ---------- | ---------------- | -------------------------------------------------------- |
| methodName | String           | String Name of the method to be mocked                   |
| paramTypes | List&lt;Type&gt; | List&lt;System.Type&gt; of the parameters for the method |

## Methods

### `verifySignatureMatch(otherSignature)`

This is used to compare the signature of a
MockedMethod, against another instance. Used at runtime to compare
an actually requested method call against pre-defined mocks.

#### Signature

```apex
public Boolean verifySignatureMatch(MethodSignature otherSignature)
```

#### Parameters

| Name           | Type                                  | Description                                             |
| -------------- | ------------------------------------- | ------------------------------------------------------- |
| otherSignature | [MethodSignature](MethodSignature.md) | the secondary MethodSignature object to compare against |

#### Return Type

**Boolean**

,[object Object], true if the signatures match, false if they do not

---

### `verifyMethodNamesMatch(originalMethodName, comparatorMethodName)`

Returns true if the current MethodSignature&#x27;s
methodName is a case insensitive match to the comparison&#x27;s methodName

#### Signature

```apex
private static Boolean verifyMethodNamesMatch(String originalMethodName, String comparatorMethodName)
```

#### Parameters

| Name                 | Type   | Description                               |
| -------------------- | ------ | ----------------------------------------- |
| originalMethodName   | String | String name of the method name called     |
| comparatorMethodName | String | String name of the method name to compare |

#### Return Type

**Boolean**

,[object Object], true if the method names match,

---

### `getMethodName()`

returns the method name for this signature

#### Signature

```apex
public String getMethodName()
```

#### Return Type

**String**

String method name

## Classes

### Builder Class

While a MethodSignature object can be created directly the
more common use case is to use this Builder class to construct the
MethodSignature object in a Fluent api style.

#### Fields

##### `stubBuilder`

###### Signature

```apex
private final stubBuilder
```

###### Type

Stub.Builder

---

##### `methodName`

`TESTVISIBLE`

###### Signature

```apex
private methodName
```

###### Type

String

---

##### `parameterTypes`

###### Signature

```apex
public parameterTypes
```

###### Type

List&lt;Type&gt;

---

##### `methodBuilders`

###### Signature

```apex
private final methodBuilders
```

###### Type

List&lt;MockedMethod.Builder&gt;

#### Constructors

##### `Builder(builder, methodName, paramTypes)`

Constructor.

###### Signature

```apex
public Builder(Stub.Builder builder, String methodName, List<System.Type> paramTypes)
```

###### Parameters

| Name       | Type                    | Description                                                                                         |
| ---------- | ----------------------- | --------------------------------------------------------------------------------------------------- |
| builder    | Stub.Builder            | A Stub.Builder object                                                                               |
| methodName | String                  | String referencing the name of the method minus,[object Object],things like ()                      |
| paramTypes | List&lt;System.Type&gt; | A list of System.Types that define the order and,[object Object],type of parameters for the method. |

#### Methods

##### `withParameterTypes()`

This variant handles the situation where a mocked method
was called without parameters.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes()
```

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterTypes(parameters)`

Omnibus variant that handles a list(N) of
parameters.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes(List<System.Type> parameters)
```

###### Parameters

| Name       | Type                    | Description                           |
| ---------- | ----------------------- | ------------------------------------- |
| parameters | List&lt;System.Type&gt; | List&lt;System.Type&gt; of parameters |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterTypes(parameter)`

This variant handles a single parameter, brokers to omnibus method.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes(System.Type parameter)
```

###### Parameters

| Name      | Type        | Description           |
| --------- | ----------- | --------------------- |
| parameter | System.Type | Type of the parameter |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterTypes(parameter, parameter2)`

Two parameter variant. Brokers to omnibus method.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes(System.Type parameter, System.Type parameter2)
```

###### Parameters

| Name       | Type        | Description                  |
| ---------- | ----------- | ---------------------------- |
| parameter  | System.Type | Type of the parameter        |
| parameter2 | System.Type | Type of the second parameter |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterTypes(parameter, parameter2, parameter3)`

Three parameter variant. Brokers to omnibus method.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes(System.Type parameter, System.Type parameter2, System.Type parameter3)
```

###### Parameters

| Name       | Type        | Description                  |
| ---------- | ----------- | ---------------------------- |
| parameter  | System.Type | Type of the parameter        |
| parameter2 | System.Type | Type of the second parameter |
| parameter3 | System.Type | Type of the third parameter  |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `withParameterTypes(parameter, parameter2, parameter3, parameter4)`

`SUPPRESSWARNINGS`

Four parameter variant. Brokers to omnibus method.

###### Signature

```apex
public MockedMethod.Builder withParameterTypes(System.Type parameter, System.Type parameter2, System.Type parameter3, System.Type parameter4)
```

###### Parameters

| Name       | Type        | Description                  |
| ---------- | ----------- | ---------------------------- |
| parameter  | System.Type | Type of the parameter        |
| parameter2 | System.Type | Type of the second parameter |
| parameter3 | System.Type | Type of the third parameter  |
| parameter4 | System.Type | Type of the fourth parameter |

###### Return Type

**MockedMethod.Builder**

,[object Object]

---

##### `finalizeSignature()`

Called at the end of building a method signature.

###### Signature

```apex
public Stub.Builder finalizeSignature()
```

###### Return Type

**Stub.Builder**

,[object Object]

---

##### `buildMockedMethod()`

Creates the MockedMethod matching this method signature.

###### Signature

```apex
public List<MockedMethod> buildMockedMethod()
```

###### Return Type

**List&lt;MockedMethod&gt;**

,[object Object]
