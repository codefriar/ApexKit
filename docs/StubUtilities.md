## Properties

### `counter`

a static incrementing counter tied to transaction
a new comment

#### Signature

```apex
private static counter
```

#### Type

Integer

## Methods

### `generateSObjectIds(sObjectTypeString, size)`

Used when you want a MockedMethod to return a
set of IDs of a given sObject Type

#### Signature

```apex
public static List<Id> generateSObjectIds(String sObjectTypeString, Integer size)
```

#### Parameters

| Name              | Type    | Description                   |
| ----------------- | ------- | ----------------------------- |
| sObjectTypeString | String  | Name of type: ie: `Account`   |
| size              | Integer | Number of valid Ids to return |

#### Return Type

**List&lt;Id&gt;**

,[object Object]
