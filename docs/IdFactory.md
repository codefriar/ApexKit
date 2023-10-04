# IdFactory

A factory class for generating bogus Ids for testing purposes.

## Fields

### `private DEFAULT_ID_LENGTH` → `Integer`

Integer representing the length of the Id. Default is 18.

### `private SERVER_ID` → `String`

This property gives us an authentic ID for this org which we can use to grab the Instance ID according to the latest release notes: What constitutes a valid Salesforce Object ID is being redefined as Salesforce expands out the instance ID (also known as a pod identifier or server ID). The 4th, 5th, and 6th characters would be used for server ID. The 7th character still remains reserved. Any coded assumptions about the structure of a valid or invalid ID should be reevaluated going forward. Note: Existing Apex functionality around IDs will transition to the new format.

### `private UNSTABLE_TYPE_PREFIX_OVERRIDES` → `Map<String,String>`

There are certain types of objects that do not return a prefix. This map contains string keys that map to known values for these 'unstable' types. This map is used to identify the correct prefix when a developer requests an Id for an unstable type. This is likely an incomplete list. If you find an unstable type that is not in this list, please add it, and submit a PR. Daniel Bollinger has a great blog post useful for filling in the gaps when an object doesn't return a prefix. http://www.fishofprey.com/2011/09/obscure-salesforce-object-key-prefixes.html

### `private idiosyncrasy` → `Integer`

Integer to be appended to the end of the Id. Incremented each time a new Id is generated.

---

## Methods

### `public static Id get(String objectType)`

this method accepts a String representation of the sObject type and defers to it's sister methods to generate a bogus Id.

#### Parameters

| Param        | Description                                                          |
| ------------ | -------------------------------------------------------------------- |
| `objectType` | String representation of the sObject type ie: Account, Contact, etc. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | id a plausible, but bogus Id |

#### Example

```apex
`IdFactory.get('Account');`
```

### `public static Id get(Type incomingType)`

This method accepts a Type object and defers to it's sister methods to generate a bogus Id.

#### Parameters

| Param          | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `incomingType` | Type object representing the sObject type ie: Account, Contact, etc. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id a plausible, but bogus Id |

#### Example

```apex
`IdFactory.get(Type.forName('Account'));`
```

### `public static Id get(SObject incomingType)`

This method accepts a generic SObject and defers to it's sister methods to generate a bogus Id.

#### Parameters

| Param          | Description                                                      |
| -------------- | ---------------------------------------------------------------- |
| `incomingType` | SObject representing the sObject type ie: Account, Contact, etc. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id a plausible, but bogus Id |

### `public static Id get(Schema incomingType)`

All the other methods in this class defer to this method eventually to generate a bogus Id.

#### Parameters

| Param          | Description                                                                 |
| -------------- | --------------------------------------------------------------------------- |
| `incomingType` | Schema.SObjectType representing the sObject type ie: Account, Contact, etc. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id a plausible, but bogus Id |

### `private static Id getWithPrefixOverride(String prefix)`

A method for getting a bogus Id for an object that may not return a prefix via standard Schema methods. This method is used internally by the other methods in this class once a prefix has been identified.

#### Parameters

| Param    | Description                                        |
| -------- | -------------------------------------------------- |
| `prefix` | String three character prefix for the object type. |

#### Returns

| Type | Description                  |
| ---- | ---------------------------- |
| Id   | Id a plausible, but bogus Id |

### `private static String getUnstableObjectPrefix(String objectType)`

Certain types of objects do not return a prefix via standard Schema methods. This method is used to identify them, and override the prefix with a known value.

#### Parameters

| Param        | Description                                                          |
| ------------ | -------------------------------------------------------------------- |
| `objectType` | String representation of the sObject type ie: Account, Contact, etc. |

#### Returns

| Type   | Description                                        |
| ------ | -------------------------------------------------- |
| String | String three character prefix for the object type. |

---

## Classes

### IDFactoryException

internally thrown exception for when the incoming data type is null or invalid

**Inheritance**

IDFactoryException

---
