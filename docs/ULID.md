`STATUS: ACTIVE`

This class implements the ULID spec in Apex.
You can find that standard here: https://github.com/ulid/spec
ULID === Universally Unique Lexicographically Sortable Identifier
Think of them as a UUIDv4, but sortable. Similar to UUIDv7.
These are, effectively a universally unique identifier
but one that is _sortable_.
This class is a port of the Javascript ULID
reference implementation.

## Fields

### `private CHARACTERSET` → `List<String>`

This character set is the complete list of allowed characters in a ULID string. It intentionally does not include characters that may be ambiguously read, such as i, l, o, and u characters.

### `private CHARACTERSETSIZE` → `Long`

### `private RANDOMLENGTH` → `Integer`

### `private TIMELENGTH` → `Long`

---

## Methods

### `public static String generate()`

Generates a ULID string according to spec. https://github.com/ulid/spec

#### Returns

| Type   | Description |
| ------ | ----------- |
| String | `String`    |

### `private static String encodeTimestamp(Long dtSeed, Long timeLength)`

Encodes a given timestamp into characters from the acceptable character set above.

#### Parameters

| Param        | Description                                    |
| ------------ | ---------------------------------------------- |
| `dtSeed`     | long form of Timestamp to encode               |
| `timeLength` | how many characters of the timestamp to encode |

#### Returns

| Type   | Description |
| ------ | ----------- |
| String | `String`    |

### `private static String generateRandomString(Integer length)`

generates a random string from the character set of a given length.

#### Parameters

| Param    | Description                              |
| -------- | ---------------------------------------- |
| `length` | Integer length of the string to generate |

#### Returns

| Type   | Description |
| ------ | ----------- |
| String | `String`    |

### `private static String fetchRandomCharacterFromCharacterSet()`

pulls a random character from the character set.

#### Returns

| Type   | Description |
| ------ | ----------- |
| String | `String`    |

---
