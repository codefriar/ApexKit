`STATUS: ACTIVE`

This class exposes methods from any class that extends Invocable to flows.
By adding 'extends Invocable' to your class and adding the call method, any class' methods can be
invoked by this single invocable method.

## Methods

### `public static List invoke(List<UniversalFlowInputOutput> inputs)`

`INVOCABLEMETHOD`

This method is what will be displayed in the flow builder. This method can correctly handle bulk invocations, even across multiple classes and methods, returning all outputs in the same order as the inputs.

#### Parameters

| Param    | Description                                                                              |
| -------- | ---------------------------------------------------------------------------------------- |
| `inputs` | List<UniversalFlowInputOutput> input objects. The first object in the list will be used. |

#### Returns

| Type                           | Description                                                                                                                   |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| List<UniversalFlowInputOutput> | List<UniversalFlowInputOutput> output objects. Every input receives one output, even if non-fatal exceptions are encountered. |

---
