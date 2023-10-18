`STATUS: ACTIVE`

Tuple represents a key-value pair. Kinda. Don't come at me math nerds.
You may be asking why this exists, given the existence of Map. Unfortuately Map isn't available everywhere.
Notably, it's not available in Apex-defined Data Types used by Flow/Invocable actions.
Additionally, `Object` is not a valid data type in Apex-defined Data Types, so we can't use a list of objects
that have a string key, and Object value. This is the next best thing. A kind of polyfill for Map&lt;String,Object&gt;
for use in Apex-defined Data Types.
See also: https://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5
Available primitive datatypes available for use in tuple:
Boolean, Integer, Long, Decimal, Double, Date, DateTime, and String. Single values and lists are supported for each data type.

## Constructors

### `public Tuple()`

`SUPPRESSWARNINGS`

In order to create a Tuple instance from within a flow, you need a no-arg constructor.

### `public Tuple(String key, Object value)`

standard constructor accepting a key and value

#### Parameters

| Param   | Description                         |
| ------- | ----------------------------------- |
| `key`   | String the name of the Tuple's Key. |
| `value` | Object the Tuple's Value.           |

---

## Fields

### `public booleanValue` → `Boolean`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public booleans` → `Boolean`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public dateTimeValue` → `Datetime`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public dateValue` → `Date`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public dates` → `Date`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public datetimes` → `Datetime`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public decimalValue` → `Decimal`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public decimals` → `Decimal`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public doubleValue` → `Double`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public doubles` → `Double`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public integerValue` → `Integer`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public integers` → `Integer`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public key` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public longValue` → `Long`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public longs` → `Long`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public sobjectValue` → `SObject`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public sobjects` → `SObject`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public stringValue` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public strings` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

---

## Methods

### `private void determineTypeAndSetCastedValue(Object value)`

Method is responsible for determining the type of the value and setting the appropriate field.

#### Parameters

| Param   | Description               |
| ------- | ------------------------- |
| `value` | Object the Tuple's Value. |

---

## Classes

### TupleException

A custom Exception type thrown when the incoming Object is not a recognized Apex-defined-type safe
type.

**Inheritance**

TupleException

---
