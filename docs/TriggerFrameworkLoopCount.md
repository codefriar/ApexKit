# TriggerFrameworkLoopCount

inner class for managing the loop count per handler

## Constructors

### `public TriggerFrameworkLoopCount()`

Loop counter method with default of 5.

### `public TriggerFrameworkLoopCount(Integer max)`

Sets loop count based on the param.

#### Parameters

| Param | Description                       |
| ----- | --------------------------------- |
| `max` | Maximum number of loops to allow. |

---

## Fields

### `public count` → `Integer`

### `public max` → `Integer`

---

## Methods

### `public Boolean increment()`

Increment the internal counter returning the results of this.exceeded().

#### Returns

| Type    | Description                                                      |
| ------- | ---------------------------------------------------------------- |
| Boolean | `Boolean` true if count will exceed max count or is less than 0. |

### `public Boolean exceeded()`

Determines if this we're about to exceed the loop count.

#### Returns

| Type    | Description                                     |
| ------- | ----------------------------------------------- |
| Boolean | `Boolean` true if less than 0 or more than max. |

### `public Integer getMax()`

Returns the max loop count.

#### Returns

| Type    | Description               |
| ------- | ------------------------- |
| Integer | `Integer` max loop count. |

### `public Integer getCount()`

Returns the current loop count.

#### Returns

| Type    | Description                   |
| ------- | ----------------------------- |
| Integer | `Integer` current loop count. |

### `public void setMax(Integer max)`

Sets the max loop size

#### Parameters

| Param | Description                |
| ----- | -------------------------- |
| `max` | The integer to set max to. |

---
