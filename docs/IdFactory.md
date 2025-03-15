## Fields

### `SERVER_ID`

This property gives us an authentic ID for this org which we can use to grab the Instance ID
according to the latest release notes:
What constitutes a valid Salesforce Object ID is being redefined as Salesforce expands out the instance ID
(also known as a pod identifier or server ID). The 4th, 5th, and 6th characters would be used for server ID.
The 7th character still remains reserved. Any coded assumptions about the structure of a valid or invalid ID
should be reevaluated going forward. Note: Existing Apex functionality around IDs will transition to the new
format.

#### Signature

```apex
private static final SERVER_ID
```

#### Type

String

---

### `UNSTABLE_TYPE_PREFIX_OVERRIDES`

There are certain types of objects that do not return a prefix. This map contains string keys that
map to known values for these &#x27;unstable&#x27; types. This map is used to identify the correct prefix when a developer
requests an Id for an unstable type.

This is likely an incomplete list. If you find an unstable type that is not in this list, please add it, and
submit a PR.
Daniel Bollinger has a great blog post useful for filling in the gaps when an object doesn&#x27;t return a prefix.
http://www.fishofprey.com/2011/09/obscure-salesforce-object-key-prefixes.html

#### Signature

```apex
private static final UNSTABLE_TYPE_PREFIX_OVERRIDES
```

#### Type

Map&lt;String,String&gt;

---

### `idiosyncrasy`

Integer to be appended to the end of the Id. Incremented each time a new Id is generated.

#### Signature

```apex
private static idiosyncrasy
```

#### Type

Integer

---

### `DEFAULT_ID_LENGTH`

Integer representing the length of the Id. Default is 18.

#### Signature

```apex
private static final DEFAULT_ID_LENGTH
```

#### Type

Integer

## Methods

### `get(objectType)`

this method accepts a String representation of the sObject type and defers to it&#x27;s sister methods to generate a bogus Id.

#### Signature

```apex
public static Id get(String objectType)
```

#### Parameters

| Name       | Type   | Description                                                          |
| ---------- | ------ | -------------------------------------------------------------------- |
| objectType | String | String representation of the sObject type ie: Account, Contact, etc. |

#### Return Type

**Id**

id a plausible, but bogus Id

#### Example

`IdFactory.get('Account');`

---

### `get(incomingType)`

This method accepts a Type object and defers to it&#x27;s sister methods to generate a bogus Id.

#### Signature

```apex
public static Id get(Type incomingType)
```

#### Parameters

| Name         | Type | Description                                                          |
| ------------ | ---- | -------------------------------------------------------------------- |
| incomingType | Type | Type object representing the sObject type ie: Account, Contact, etc. |

#### Return Type

**Id**

Id a plausible, but bogus Id

#### Example

`IdFactory.get(Type.forName('Account'));`

---

### `get(incomingType)`

This method accepts a generic SObject and defers to it&#x27;s sister methods to generate a bogus Id.

#### Signature

```apex
public static Id get(SObject incomingType)
```

#### Parameters

| Name         | Type    | Description                                                      |
| ------------ | ------- | ---------------------------------------------------------------- |
| incomingType | SObject | SObject representing the sObject type ie: Account, Contact, etc. |

#### Return Type

**Id**

Id a plausible, but bogus Id

---

### `get(incomingType)`

All the other methods in this class defer to this method eventually to generate a bogus Id.

#### Signature

```apex
public static Id get(Schema.SObjectType incomingType)
```

#### Parameters

| Name         | Type               | Description                                                                 |
| ------------ | ------------------ | --------------------------------------------------------------------------- |
| incomingType | Schema.SObjectType | Schema.SObjectType representing the sObject type ie: Account, Contact, etc. |

#### Return Type

**Id**

Id a plausible, but bogus Id

---

### `getWithPrefixOverride(prefix)`

A method for getting a bogus Id for an object that may not return a prefix via standard Schema
methods. This method is used internally by the other methods in this class once a prefix has been identified.

#### Signature

```apex
private static Id getWithPrefixOverride(String prefix)
```

#### Parameters

| Name   | Type   | Description                                        |
| ------ | ------ | -------------------------------------------------- |
| prefix | String | String three character prefix for the object type. |

#### Return Type

**Id**

Id a plausible, but bogus Id

---

### `getUnstableObjectPrefix(objectType)`

Certain types of objects do not return a prefix via standard Schema methods. This method is used
to identify them, and override the prefix with a known value.

#### Signature

```apex
private static String getUnstableObjectPrefix(String objectType)
```

#### Parameters

| Name       | Type   | Description                                                          |
| ---------- | ------ | -------------------------------------------------------------------- |
| objectType | String | String representation of the sObject type ie: Account, Contact, etc. |

#### Return Type

**String**

String three character prefix for the object type.

## Classes

### IDFactoryException Class

internally thrown exception for when the incoming data type is null or invalid
