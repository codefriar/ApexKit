## Fields

### `max`

#### Signature

```apex
public max
```

#### Type

Integer

---

### `count`

#### Signature

```apex
public count
```

#### Type

Integer

## Constructors

### `TriggerFrameworkLoopCount()`

Loop counter method with default of 5.

#### Signature

```apex
public TriggerFrameworkLoopCount()
```

---

### `TriggerFrameworkLoopCount(max)`

Sets loop count based on the param.

#### Signature

```apex
public TriggerFrameworkLoopCount(Integer max)
```

#### Parameters

| Name | Type    | Description                       |
| ---- | ------- | --------------------------------- |
| max  | Integer | Maximum number of loops to allow. |

## Methods

### `increment()`

Increment the internal counter returning the results of
this.exceeded().

#### Signature

```apex
public Boolean increment()
```

#### Return Type

**Boolean**

,[object Object], true if count will exceed max count or is less,[object Object],than 0.

---

### `exceeded()`

Determines if this we&#x27;re about to exceed the loop count.

#### Signature

```apex
public Boolean exceeded()
```

#### Return Type

**Boolean**

,[object Object], true if less than 0 or more than max.

---

### `getMax()`

Returns the max loop count.

#### Signature

```apex
public Integer getMax()
```

#### Return Type

**Integer**

,[object Object], max loop count.

---

### `getCount()`

Returns the current loop count.

#### Signature

```apex
public Integer getCount()
```

#### Return Type

**Integer**

,[object Object], current loop count.

---

### `setMax(max)`

Sets the max loop size

#### Signature

```apex
public void setMax(Integer max)
```

#### Parameters

| Name | Type    | Description                |
| ---- | ------- | -------------------------- |
| max  | Integer | The integer to set max to. |

#### Return Type

**void**
