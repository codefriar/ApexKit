## Methods

### `invokeMetadataTriggerFramework(inputParams)`

`INVOCABLEMETHOD`

Invokes the Metadata Trigger Framework

#### Signature

```apex
public static void invokeMetadataTriggerFramework(List<Inputs> inputParams)
```

#### Parameters

| Name        | Type               | Description                                                                   |
| ----------- | ------------------ | ----------------------------------------------------------------------------- |
| inputParams | List&lt;Inputs&gt; | List&lt;Inputs&gt; - List of inputs to pass to the Metadata Trigger Framework |

#### Return Type

**void**

## Classes

### Inputs Class

An internal class representing the inputs to the Metadata Trigger Framework

#### Fields

##### `context`

`INVOCABLEVARIABLE`

###### Signature

```apex
public context
```

###### Type

TriggerOperation

---

##### `triggerNew`

`OTHER`

###### Signature

```apex
public triggerNew
```

###### Type

List&lt;SObject&gt;

---

##### `triggerOld`

`OTHER`

###### Signature

```apex
public triggerOld
```

###### Type

List&lt;SObject&gt;
