`SUPPRESSWARNINGS`

**Implements**

System.StubProvider

## Fields

### `returnString`

#### Signature

```apex
private final returnString
```

#### Type

String

## Constructors

### `QueueableProcessMockDataProvider(returnString)`

#### Signature

```apex
public QueueableProcessMockDataProvider(String returnString)
```

#### Parameters

| Name         | Type   | Description |
| ------------ | ------ | ----------- |
| returnString | String |             |

## Methods

### `handleMethodCall(stubbedObject, stubbedMethodName, returnType, paramTypes, paramNames, args)`

`SUPPRESSWARNINGS`

#### Signature

```apex
public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> args)
```

#### Parameters

| Name              | Type               | Description |
| ----------------- | ------------------ | ----------- |
| stubbedObject     | Object             |             |
| stubbedMethodName | String             |             |
| returnType        | Type               |             |
| paramTypes        | List&lt;Type&gt;   |             |
| paramNames        | List&lt;String&gt; |             |
| args              | List&lt;Object&gt; |             |

#### Return Type

**Object**
