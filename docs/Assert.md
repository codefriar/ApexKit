`APIVERSION: 58`

`STATUS: ACTIVE`

Assert class 'shadows' the System.Assert class allowing us to add custom assertion methods accessed
via the static Assert.\* methods. This allows us to add custom assertion methods that are more readable and provide
more flexibility and functionality than the standard System.Assert methods. Ultimately the goal is to provide
end-developers with a more readable and flexible way to write assertions.

## Methods

### `public static void isNotJanky(String msg)`

Look, this is a quasi inside joke method. If you have to ask if it's janky, it is. For more information, ask

#### Parameters

| Param | Description                                          |
| ----- | ---------------------------------------------------- |
| `msg` | String the message you want in your failure response |

**JeffKrantz** over on SFDC Discord.

### `public static void listMeetsMinimumSize(List<Object> collection, Integer minSize, String msg)`

An assertion that validates a list is at least a certain size

#### Parameters

| Param        | Description                                            |
| ------------ | ------------------------------------------------------ |
| `collection` | List<Object> - the list to validate                    |
| `minSize`    | Integer - the minimum size the list must be            |
| `msg`        | String - the message to display if the assertion fails |

### `public static void stringIsDeserializableAsUntypedJson(String jsonString, String msg)`

An assertion that validates a string is deserializable to untyped JSON

#### Parameters

| Param        | Description                                            |
| ------------ | ------------------------------------------------------ |
| `jsonString` | String - the string to validate                        |
| `msg`        | String - the message to display if the assertion fails |

### `public static void isSObject(Object obj, String msg)`

An assertion to validate that the object is an SObject

#### Parameters

| Param | Description                                            |
| ----- | ------------------------------------------------------ |
| `obj` | Object - the object to validate                        |
| `msg` | String - the message to display if the assertion fails |

### `public static void caughtExpectedException(Exception incomingException, Type expectedExceptionType, String msg)`

An assertion to validate that the exception is of the expected type

#### Parameters

| Param                   | Description                                            |
| ----------------------- | ------------------------------------------------------ |
| `incomingException`     | Exception - the exception to validate                  |
| `expectedExceptionType` | Type - the expected type of the exception              |
| `msg`                   | String - the message to display if the assertion fails |

### `public static void caughtExpectedException(Exception incomingException, Type expectedExceptionType, String expectedExceptionMessage, String msg)`

An assertion to validate that the exception is of the expected type and contains the expected message

#### Parameters

| Param                      | Description                                                          |
| -------------------------- | -------------------------------------------------------------------- |
| `incomingException`        | Exception - the exception to validate                                |
| `expectedExceptionType`    | Type - the expected type of the exception                            |
| `expectedExceptionMessage` | String - A string that must exist in the resulting exception message |
| `msg`                      | String - the message to display if the assertion fails               |

### `public static void isInRange(Integer value, Integer min, Integer max, String msg)`

An assertion that validates the given value is within a given range

#### Parameters

| Param   | Description                                            |
| ------- | ------------------------------------------------------ |
| `value` | Integer - the value to validate                        |
| `min`   | Integer - the minimum value the value must be          |
| `max`   | Integer - the maximum value the value must be          |
| `msg`   | String - the message to display if the assertion fails |

### `public static void logsWereGenerated(String msg)`

An Assertion that validates that LogEvent\_\_c records were generated. Note: this relies on the Log class that's part of ApexKit

#### Parameters

| Param | Description                                            |
| ----- | ------------------------------------------------------ |
| `msg` | String - the message to display if the assertion fails |

### `public static void logsWereGenerated()`

An assertion that validates that LogEvent\_\_c records were generated. Note this relies on the Log class that's part of ApexKit. This method override accepts no parameters but delegates to the variant above by specifying a default message.

### `public static void areEqual(Object expected, Object actual, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param      | Description                                      |
| ---------- | ------------------------------------------------ |
| `expected` | Object expected value                            |
| `actual`   | Object actual value                              |
| `msg`      | String message to display if the assertion fails |

### `public static void areEqual(Object expected, Object actual)`

Passthrough method to the default system assert class

#### Parameters

| Param      | Description           |
| ---------- | --------------------- |
| `expected` | Object expected value |
| `actual`   | Object actual value   |

### `public static void areNotEqual(Object notExpected, Object actual, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param         | Description                                      |
| ------------- | ------------------------------------------------ |
| `notExpected` | Object not expected value                        |
| `actual`      | Object actual value                              |
| `msg`         | String message to display if the assertion fails |

### `public static void areNotEqual(Object notExpected, Object actual)`

Passthrough method to the default system assert class

#### Parameters

| Param         | Description               |
| ------------- | ------------------------- |
| `notExpected` | Object not expected value |
| `actual`      | Object actual value       |

### `public static void fail(String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param | Description               |
| ----- | ------------------------- |
| `msg` | String message to display |

### `public static void fail()`

Passthrough method to the default system assert class

### `public static void isFalse(Boolean condition, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param       | Description                                      |
| ----------- | ------------------------------------------------ |
| `condition` | Boolean condition to evaluate                    |
| `msg`       | String message to display if the assertion fails |

### `public static void isFalse(Boolean condition)`

Passthrough method to the default system assert class

#### Parameters

| Param       | Description                   |
| ----------- | ----------------------------- |
| `condition` | Boolean condition to evaluate |

### `public static void isInstanceOfType(Object instance, System expectedType, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param          | Description                                      |
| -------------- | ------------------------------------------------ |
| `instance`     | Object instance to evaluate                      |
| `expectedType` | Type expected type                               |
| `msg`          | String message to display if the assertion fails |

### `public static void isInstanceOfType(Object instance, System expectedType)`

Passthrough method to the default system assert class

#### Parameters

| Param          | Description                 |
| -------------- | --------------------------- |
| `instance`     | Object instance to evaluate |
| `expectedType` | Type expected type          |

### `public static void isNotInstanceOfType(Object instance, System notExpectedType, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param             | Description                                      |
| ----------------- | ------------------------------------------------ |
| `instance`        | Object instance to evaluate                      |
| `notExpectedType` | Object not expected type                         |
| `msg`             | String message to display if the assertion fails |

### `public static void isNotInstanceOfType(Object instance, System notExpectedType)`

Passthrough method to the default system assert class

#### Parameters

| Param             | Description                 |
| ----------------- | --------------------------- |
| `instance`        | Object instance to evaluate |
| `notExpectedType` | Object not expected type    |

### `public static void isNotNull(Object value, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param   | Description                                      |
| ------- | ------------------------------------------------ |
| `value` | Object value to evaluate                         |
| `msg`   | String message to display if the assertion fails |

### `public static void isNotNull(Object value)`

Passthrough method to the default system assert class

#### Parameters

| Param   | Description              |
| ------- | ------------------------ |
| `value` | Object value to evaluate |

### `public static void isNull(Object value, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param   | Description                                      |
| ------- | ------------------------------------------------ |
| `value` | Object value to evaluate                         |
| `msg`   | String message to display if the assertion fails |

### `public static void isNull(Object value)`

Passthrough method to the default system assert class

#### Parameters

| Param   | Description              |
| ------- | ------------------------ |
| `value` | Object value to evaluate |

### `public static void isTrue(Boolean condition, String msg)`

Passthrough method to the default system assert class

#### Parameters

| Param       | Description                                      |
| ----------- | ------------------------------------------------ |
| `condition` | Boolean condition to evaluate                    |
| `msg`       | String message to display if the assertion fails |

### `public static void isTrue(Boolean condition)`

Passthrough method to the default system assert class

#### Parameters

| Param       | Description                   |
| ----------- | ----------------------------- |
| `condition` | Boolean condition to evaluate |

---
