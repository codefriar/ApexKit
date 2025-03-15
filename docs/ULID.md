You can find that standard here: https://github.com/ulid/spec
ULID &#x3D;&#x3D;&#x3D; Universally Unique Lexicographically Sortable Identifier
Think of them as a UUIDv4, but sortable. Similar to UUIDv7.
These are, effectively a universally unique identifier
but one that is _sortable_.

This class is a port of the Javascript ULID
reference implementation.

## Fields

### `CHARACTERSET`

This character set is the complete list of allowed characters in
a ULID string. It intentionally does not include characters that
may be ambiguously read, such as i, l, o, and u characters.

#### Signature

```apex
private static final CHARACTERSET
```

#### Type

List&lt;String&gt;

---

### `CHARACTERSETSIZE`

#### Signature

```apex
private static final CHARACTERSETSIZE
```

#### Type

Long

---

### `TIMELENGTH`

#### Signature

```apex
private static final TIMELENGTH
```

#### Type

Long

---

### `RANDOMLENGTH`

#### Signature

```apex
private static final RANDOMLENGTH
```

#### Type

Integer

## Methods

### `generate()`

Generates a ULID string according to spec.
https://github.com/ulid/spec

#### Signature

```apex
public static String generate()
```

#### Return Type

**String**

,[object Object]

---

### `encodeTimestamp(dtSeed, timeLength)`

Encodes a given timestamp into characters from
the acceptable character set above.

#### Signature

```apex
private static String encodeTimestamp(Long dtSeed, Long timeLength)
```

#### Parameters

| Name       | Type | Description                                    |
| ---------- | ---- | ---------------------------------------------- |
| dtSeed     | Long | long form of Timestamp to encode               |
| timeLength | Long | how many characters of the timestamp to encode |

#### Return Type

**String**

,[object Object]

---

### `generateRandomString(length)`

generates a random string from the character set
of a given length.

#### Signature

```apex
private static String generateRandomString(Integer length)
```

#### Parameters

| Name   | Type    | Description                              |
| ------ | ------- | ---------------------------------------- |
| length | Integer | Integer length of the string to generate |

#### Return Type

**String**

,[object Object]

---

### `fetchRandomCharacterFromCharacterSet()`

pulls a random character from the character set.

#### Signature

```apex
private static String fetchRandomCharacterFromCharacterSet()
```

#### Return Type

**String**

,[object Object]
