`APIVERSION: 58`

`STATUS: ACTIVE`

## Properties

### `private counter` → `Integer`

a static incrementing counter tied to transaction a new comment

---

## Methods

### `public static List generateSObjectIds(String sObjectTypeString, Integer size)`

Used when you want a MockedMethod to return a set of IDs of a given sObject Type

#### Parameters

| Param               | Description                   |
| ------------------- | ----------------------------- |
| `sObjectTypeString` | Name of type: ie: `Account`   |
| `size`              | Number of valid Ids to return |

#### Returns

| Type     | Description |
| -------- | ----------- |
| List<Id> | `List<Id>`  |

---
