`STATUS: ACTIVE`

Provides a similar interface to Callable, but bulkified to handle multiple sets of parameters.

**Author** Brian Fear

## Methods

### `public List call(String methodName, List<Map<String,Object>> parameters)`

Implementing classes must implement this method signature.

#### Parameters

| Param        | Description                                                                  |
| ------------ | ---------------------------------------------------------------------------- |
| `methodName` | String the name of the method to call                                        |
| `parameters` | List<Map<String, Object>> a list of maps of parameters to pass to the method |

#### Returns

| Type         | Description                                         |
| ------------ | --------------------------------------------------- |
| List<Object> | List<Object> The results of the called Apex methods |

---
