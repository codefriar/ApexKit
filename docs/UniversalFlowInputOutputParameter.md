# UniversalFlowInputOutputParameter

This class contains the object definition used by the Universal Invocable Action. It's designed
to expose variables of every type allowed by the InvocableVariable method in a single object. It uses type detection
to set the correct property on ouput.

## Constructors

### `public UniversalFlowInputOutputParameter()`

`SUPPRESSWARNINGS`

Default no parameter constructor required by the Invocable Variable/Method system for constructing an _output_ parameter.

### `public UniversalFlowInputOutputParameter(Object value)`

Wraps an Object into different property types that will be used by flows.

#### Parameters

| Param   | Description                                 |
| ------- | ------------------------------------------- |
| `value` | The value to convert into native data types |

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

### `public longValue` → `Long`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public longs` → `Long`

`AURAENABLED`
`INVOCABLEVARIABLE`

### `public parameterName` → `String`

`AURAENABLED`
`INVOCABLEVARIABLE`

This is an 'Apex Defined Type'. According to the documentation, the following types are supported: Boolean, Date, DateTime, Double, Decimal, Integer, Long, and String https://help.salesforce.com/s/articleView?id=sf.flow_considerations_apex_data_type.htm&type=5

### `public parameterType` → `String`

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
