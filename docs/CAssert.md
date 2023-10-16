`APIVERSION: 58`

`STATUS: ACTIVE`

## Methods

### `public static void areEqual(Datetime expectedDatetime, Datetime actualDatetime, Integer timeVarianceSeconds, String assertionMessage)`

`SUPPRESSWARNINGS`

Assertion method to validate that two Datetime objects are equal within a given leeway

#### Parameters

| Param                 | Description                                            |
| --------------------- | ------------------------------------------------------ |
| `expectedDatetime`    | Datetime - the expected Datetime                       |
| `actualDatetime`      | Datetime - the actual Datetime                         |
| `timeVarianceSeconds` | Integer - the number of seconds of leeway to allow     |
| `assertionMessage`    | String - the message to display if the assertion fails |

### `public static void startsWith(String str, String prefix, String msg)`

Assertion method to validate that a string starts with the given string

#### Parameters

| Param    | Description                                            |
| -------- | ------------------------------------------------------ |
| `str`    | String - the string to validate                        |
| `prefix` | String - the prefix the string must start with         |
| `msg`    | String - the message to display if the assertion fails |

### `public static void endsWith(String str, String suffix, String msg)`

Assertion method to validate that a string ends with the given string

#### Parameters

| Param    | Description                                            |
| -------- | ------------------------------------------------------ |
| `str`    | String - the string to validate                        |
| `suffix` | String - the suffix the string must end with           |
| `msg`    | String - the message to display if the assertion fails |

### `public static void contains(List<Object> listToCheck, List<Object> listToCheckAgainst, String message)`

An assertion that validates a list contains at least one of the items in the other list passed in

#### Parameters

| Param                | Description                                          |
| -------------------- | ---------------------------------------------------- |
| `listToCheck`        | List<Object> the list to check                       |
| `listToCheckAgainst` | List<Object> the list to check against               |
| `message`            | String the message to display if the assertion fails |

### `public static void contains(List<Object> listToCheck, Set<Object> itemsToCheckFor, String message)`

An assertion that validates the passed in list contains at least one of the items in the set. Ultimately defers to the contains assertion below comparing two sets.

#### Parameters

| Param             | Description                                                         |
| ----------------- | ------------------------------------------------------------------- |
| `listToCheck`     | List<Object> to check for containing at least one item from the set |
| `itemsToCheckFor` | Set<Object> the set of items to check for in the list               |
| `message`         | String the message to display if the assertion fails                |

### `public static void contains(Set<Object> setToCheck, Set<Object> setToCheckAgainst, String message)`

Checks to see if a set contains any of the items in another set.

#### Parameters

| Param               | Description                                          |
| ------------------- | ---------------------------------------------------- |
| `setToCheck`        | Set<Object> the set to check                         |
| `setToCheckAgainst` | Set<Object> the set to check against                 |
| `message`           | String the message to display if the assertion fails |

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

---
