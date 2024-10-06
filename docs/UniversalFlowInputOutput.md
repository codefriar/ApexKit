`APIVERSION: 58`

`STATUS: ACTIVE`

This is a common object for passing data from a flow, into a class method, and back out to flow.

## Constructors

### `public UniversalFlowInputOutput()`

Flow requires a 0 argument constructor, so we provide one here.

### `public UniversalFlowInputOutput(String className, String methodName, Object returnValue, Boolean isError)`

This constructor variant is used by this class, and the the UniversalInvocable class to construct the return object.

#### Parameters

| Param         | Description                                                                                                                                                |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `className`   | String Name of the class called                                                                                                                            |
| `methodName`  | String Name of the method called                                                                                                                           |
| `returnValue` | UniversalFlowInputOutputParameter The return value of the called method is automatically cast to it's respective primitive type and stored in this object. |
| `isError`     | boolean If the method called threw an exception, this should be true. Otherwise, false.                                                                    |

---

## Fields

### `public className` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

String representing Apex recognized name of the class you're instantiating.

### `public methodName` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

String representing the method name you're calling

### `public parameters` → `List<UniversalFlowInputOutputParameter>`

`AURAENABLED`
`INVOCABLEVARIABLE`

This is a list of individual parameters you're passing to the method you're calling.

### `public result` → `UniversalFlowInputOutputParameter`

`AURAENABLED`
`INVOCABLEVARIABLE`

While the parameters list is used for passing parameters to the method you're calling, this single object is used for passing the return value of the method you're calling back to flow. As a side effect of the way this works, you can build aggregating methods that call multiple methods and return multiple values - of different types - to the flow via this object.

### `public success` → `Boolean`

`AURAENABLED`
`INVOCABLEVARIABLE`

---

## Methods

### `public Map<String,Object> toCallableParamMap()`

`SUPPRESSWARNINGS`

Method is responsible for converting the list of UniversalFlowInputOutputParameter objects delivered by the Flow action framework, to a Map&lt;String, Object&gt; needed by the Callable interface. Note, this is a hard limitation of the Flow action framework and the Apex Defined Data Types. This is not a limitation of this pattern / framework. If you want to, say pass a list of records to a method, you'll need to pass a list of strings, and query for the objects in the Apex. #sorryNothingICanDo. Note: This method is currently suppressing PMD warnings for cognitive, standard and cyclomatic complexity as as method length. Unfortunately, I don't see a good re-factor path forward to reduce these, as the sheer number of if statements is what's killing it.

#### Returns

| Type                 | Description                                                                         |
| -------------------- | ----------------------------------------------------------------------------------- |
| `Map<String,Object>` | Map<String, Object> This returns a map of parameters you're passing to your method. |

### `public override String toString()`

Used to provide a usable key for the Map that uses this method.

#### Returns

| Type     | Description                                        |
| -------- | -------------------------------------------------- |
| `String` | `String` This value maps unique class/method names |

---
