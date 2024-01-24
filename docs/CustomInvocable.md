`STATUS: ACTIVE`

This class is an example of how to implement the Invocable Abstract Class.
It doesn't do much, but it does illustrate how BulkCallable, Invocable, UniversalInvocable, UniversalFlowInputOutput and
UniversalFlowInputOutputParameter work together to expose multiple methods to Flow.
Please understand this is an example class demonstrating the work an Apex developer would need to take to make
the following class methods available to Flow: daysTillChristmas and daysBetweenDates.

**Inheritance**

[UFInvocable](https://github.com/codefriar/ApexKit/wiki/UFInvocable)
&gt;
CustomInvocable

## Methods

### `public List<Integer> daysTillChristmas(List<Date> startingDates)`

Method exposes the Apex Date method daysBetween to Flow. It accepts a single list of parameter for the start date, then calculates the days between the start date and Christmas.

#### Parameters

| Param           | Description                               |
| --------------- | ----------------------------------------- |
| `startingDates` | List<Date> to start the calculation from. |

#### Returns

| Type            | Description                                                         |
| --------------- | ------------------------------------------------------------------- |
| `List<Integer>` | List<Integer> List of days between the starting date and Christmas. |

### `public List<Integer> daysBetweenDates(List<Date> startingDates, List<Date> endingDates)`

This method exposes the Apex date method daysBetween to flow accepting two lists of date parameters, one for startDate and one for endDate. It calculates the days between the two dates.

#### Parameters

| Param           | Description                                             |
| --------------- | ------------------------------------------------------- |
| `startingDates` | List<Date> List of dates to start the calculation from. |
| `endingDates`   | List<Date> List of dates to end the calculation at.     |

#### Returns

| Type            | Description                                                           |
| --------------- | --------------------------------------------------------------------- |
| `List<Integer>` | List<Integer> List of days between the starting date and ending date. |

### `public override List<Object> call(String methodName, List<Map<String,Object>> param2)`

This is the method required by the BulkCallable interface. This is the method you'll need to implement in any classes you wish to expose to flow.

#### Parameters

| Param        | Description                                                              |
| ------------ | ------------------------------------------------------------------------ |
| `methodName` | String name of the method to be invoked                                  |
| `param2`     | List<Map<String, Object>> List of parameters to be passed to the method. |

#### Returns

| Type           | Description                             |
| -------------- | --------------------------------------- |
| `List<Object>` | List of Objects to be returned to Flow. |

### `protected List<Object> extractParameter(String parameterName, List<Map<String,Object>> parameters, Type parameterListType)`

_Inherited_

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
