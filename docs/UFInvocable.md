`STATUS: ACTIVE`

This provides a common interface for classes & methods developers want to expose to flow.
Intrepid developers will note you could just implement the Callable interface in all of your classes.
However, this class provides a few benefits:

-   It provides a common interface for all of your classes, which makes it easier to understand what is exposed to flow.
-   It provides a common exception type, which makes it easier to handle exceptions in flow.
-   It provides a common wrapper for returning custom objects, which makes it easier to return custom objects in flow.
    This is an abstract class. This means the classes you want to expose to flow must extend this class.
    Extending this class will require you to implement the call() method. This is used by the Callable interface
    and is how developers can expose multiple class methods to flow without writing 1 class with 1 invocable method per
    method exposed.
    It should be noted that you should consider this a pattern. Modifying this pattern on a per-class basis would offer
    more flexibility, additional focus on input types and output types, and more control over the flow experience.

**Implemented types**

[BulkCallable](https://github.com/codefriar/ApexKit/wiki/BulkCallable)

## Methods

### `public List<Object> call(String methodName, List<Map<String,Object>> passedParameters)`

This is a required method of the callable interface that this class implements. You'll need to extend the class you intend to expose to flow with this one, and implement this method.

#### Parameters

| Param              | Description                                                            |
| ------------------ | ---------------------------------------------------------------------- |
| `methodName`       | This is a string representing the name of the method you want to call. |
| `passedParameters` | This is a map of parameters you're passing to your method.             |

#### Returns

| Type           | Description                                                                                  |
| -------------- | -------------------------------------------------------------------------------------------- |
| `List<Object>` | Object This returns a generic Object. This is the return value of the method you're calling. |

### `protected List<Object> extractParameter(String parameterName, List<Map<String,Object>> parameters, Type parameterListType)`

Extracts values from a list of parameters. Used by implementations of the Invocable framework.

#### Parameters

| Param               | Description                                   |
| ------------------- | --------------------------------------------- |
| `parameterName`     | the parameter name to extract into the list   |
| `parameters`        | the parameters provided by the flow framework |
| `parameterListType` | the Type of the new list to create            |

#### Returns

| Type           | Description                                                                     |
| -------------- | ------------------------------------------------------------------------------- |
| `List<Object>` | `List<Object>` The list of extracted values, in the same data type as requested |

---

## Classes

### MalformedCallableException

This is a common exception object shared by all classes that extend this class. Used primarily
by this class to throw exceptions when the call() method is not implemented, or when the call() method doesn't
handle the method name or parameters passed to it.

**Inheritance**

MalformedCallableException

### Point

a 2D point.

**Implemented types**

[Comparable](Comparable)

#### Constructors

##### `private Point(Integer x, Integer y)`

Constructor

###### Parameters

| Param | Description      |
| ----- | ---------------- |
| `x`   | the x coordinate |
| `y`   | the y coordinate |

---

#### Fields

##### `private hashCode` → `Integer`

##### `private x` → `Integer`

##### `private y` → `Integer`

---

#### Methods

##### `public Integer hashCode()`

Used by Map/Set to identify unique values quickly

###### Returns

| Type      | Description                                                |
| --------- | ---------------------------------------------------------- |
| `Integer` | `Integer` returns a unique value based on x, y coordinates |

##### `public Boolean equals(Object other)`

checks if the current instance is equal to another

###### Parameters

| Param   | Description                      |
| ------- | -------------------------------- |
| `other` | The object to check for equality |

###### Returns

| Type      | Description                                                          |
| --------- | -------------------------------------------------------------------- |
| `Boolean` | `Boolean` returns `true` if the objects are equal, `false` otherwise |

##### `public Integer compareTo(Object other)`

###### Parameters

| Param   | Description                              |
| ------- | ---------------------------------------- |
| `other` | the other object to determine sort order |

###### Returns

| Type      | Description                                                                    |
| --------- | ------------------------------------------------------------------------------ |
| `Integer` | `Integer` negative when `this` is smaller, positive when greater, 0 when equal |

---

### Processor

Processes flow input values and returns flow output values

#### Constructors

##### `private Processor()`

Default constructor for shared initialization

##### `public Processor(List&lt;List&lt;UniversalFlowInputOutput&gt;&gt; inputs)`

Constructor used for bulk flow processing

###### Parameters

| Param    | Description                                           |
| -------- | ----------------------------------------------------- |
| `inputs` | the flow inputs from a collection of bulk flow inputs |

##### `public Processor(List&lt;UniversalFlowInputOutput&gt; inputs)`

Constructor used for single bulkified flow processing

###### Parameters

| Param    | Description                                      |
| -------- | ------------------------------------------------ |
| `inputs` | the flow inputs from a collection of flow inputs |

---

#### Fields

##### `private controllers` → `Map&lt;String,BulkCallable&gt;`

##### `private inputs` → `List&lt;List&lt;UniversalFlowInputOutput&gt;&gt;`

##### `private inputsByClassMethodByIndex` → `Map&lt;String,Map&lt;Point,UniversalFlowInputOutput&gt;&gt;`

##### `private outputs` → `List&lt;List&lt;UniversalFlowInputOutput&gt;&gt;`

##### `private typeErrors` → `Map&lt;String,String&gt;`

---

#### Methods

##### `public List&lt;UniversalFlowInputOutput&gt; execute()`

processes a single bulkified flow

###### Returns

| Type                                   | Description                                                                              |
| -------------------------------------- | ---------------------------------------------------------------------------------------- |
| `List&lt;UniversalFlowInputOutput&gt;` | `List&lt;UniversalFlowInputOutput&gt;` the flow inputs from a bulkified flow transaction |

##### `public List&lt;List&lt;UniversalFlowInputOutput&gt;&gt; executeBulk()`

###### Returns

| Type                                               | Description                                                                                         |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `List&lt;List&lt;UniversalFlowInputOutput&gt;&gt;` | `List&lt;List&lt;UniversalFlowInputOutput&gt;&gt;` the flow inputs from a collection of flow inputs |

##### `private void prepare()`

prepares the data structures we need to process

##### `private void loadClasses()`

Attempts to instantiate controllers and records errors

##### `private void processInputs()`

runs each of the requested methods with the related inputs

---

---
