platform features are enabled. For example, do we have platform cache
enabled. You could also write similar methods for experiences.

Shared Code

## Fields

### `safeDefaultCachePartition`

`TESTVISIBLE`

#### Signature

```apex
private safeDefaultCachePartition
```

#### Type

Cache.OrgPartition

---

### `orgShape`

`TESTVISIBLE`

#### Signature

```apex
private orgShape
```

#### Type

Organization

---

### `DEFAULT_PARTITION`

Defines the default cache partition for use in this class.

#### Signature

```apex
private static final DEFAULT_PARTITION
```

#### Type

String

## Properties

### `isSandbox`

property reports whether this transaction took place
in a sandbox.

#### Signature

```apex
public isSandbox
```

#### Type

Boolean

---

### `multiCurrencyEnabled`

reports whether or not this transaction took place in an
org with multiCurrency enabled.
Note: I have no idea why the underlying method is on UserInfo.

#### Signature

```apex
public multiCurrencyEnabled
```

#### Type

Boolean

---

### `hasNamespacePrefix`

reports whether this transaction took place in an org with
a namespace prefix

#### Signature

```apex
public hasNamespacePrefix
```

#### Type

Boolean

---

### `namespacePrefix`

reports the namespace prefix of this org. May return null;

#### Signature

```apex
public namespacePrefix
```

#### Type

String

---

### `orgType`

reports this org&#x27;s type. ie: &#x27;Developer Edition&#x27;

#### Signature

```apex
public orgType
```

#### Type

String

---

### `isReadOnly`

reports the read-only status.
this is a proxy for &#x27;is this org active&#x27;

#### Signature

```apex
public isReadOnly
```

#### Type

Boolean

---

### `instanceName`

returns the instance name.
In practice not null.

#### Signature

```apex
public instanceName
```

#### Type

String

---

### `podName`

convenience method. Alias for instanceName

#### Signature

```apex
public podName
```

#### Type

String

---

### `getFiscalYearStartMonth`

returns this org&#x27;s fiscal year starting month

#### Signature

```apex
public getFiscalYearStartMonth
```

#### Type

Integer

---

### `lightningEnabled`

reports the users&#x27; displayed theme.

#### Signature

```apex
public lightningEnabled
```

#### Type

Boolean

---

### `id`

reports the org&#x27;s ID.
in practice, this is a constant

#### Signature

```apex
public id
```

#### Type

Id

---

### `locale`

reports the org&#x27;s locale

#### Signature

```apex
public locale
```

#### Type

String

---

### `name`

reports the org&#x27;s name

#### Signature

```apex
public name
```

#### Type

String

---

### `timeZoneKey`

reports the timeZoneSidKey

#### Signature

```apex
public timeZoneKey
```

#### Type

String

## Methods

### `getDefaultPartition(type)`

returns a Cache.Partition for a given name, and type

#### Signature

```apex
public Cache.Partition getDefaultPartition(CachePartitionType type)
```

#### Parameters

| Name | Type                                        | Description              |
| ---- | ------------------------------------------- | ------------------------ |
| type | [CachePartitionType](CachePartitionType.md) | Enum of .SESSION or .ORG |

#### Return Type

**Cache.Partition**

,[object Object]

---

### `isPlatformCacheEnabled()`

Method determines if platform cache is enabled for this org
Note: fail-safes to false.
Note: Allows override by setting OrgShape.disablePlatformCache
equal to true. Use this in test contexts where cache is not available like
when you have to use seeAllData&#x3D;true

#### Signature

```apex
public Boolean isPlatformCacheEnabled()
```

#### Return Type

**Boolean**

,[object Object]

---

### `isSeeAllDataTrue()`

Certain features of the platform are incompatible with
data-siloed tests. These features require testing with the annotation

**Test**

(seeAllData&#x3D;true). Other platform features are incompatible with
seeAllData&#x3D;true. When used in a test context, this method determines if
the currently running test is executing with, or without seeAllData&#x3D;true.

This method is therefore used to automatically disable platform features
that require are incompatible with seeAllData&#x3D;true. For example: platform
cache is incompatible with seeAllData&#x3D;true. However, our security
library, CanTheUser utilizes platform cache to accelerate Crud and FLS
checks. CanTheUser uses this method, in part, to determine, transparently
if it should utilize platformCache during test execution

Note: It is not a good idea, and against best practices to use
seeAllData&#x3D;true when not absolutely necessary.

#### Signature

```apex
public Boolean isSeeAllDataTrue()
```

#### Return Type

**Boolean**

,[object Object]

---

### `getAvailableOrgCachePartition()`

`SUPPRESSWARNINGS`

This method is responsible for discovering a cache partition
that can be used for determining if platformCache is enabled and
configured.

Note: This method memoizes the result of the query, ensuring that the
underlying soql query is only ever run once per transaction.

#### Signature

```apex
private Cache.OrgPartition getAvailableOrgCachePartition()
```

#### Return Type

**Cache.OrgPartition**

,[object Object]

---

### `isAdvancedMultiCurrencyManagementEnabled()`

Uses a dynamic soql query to determine if Advanced
MultiCurrency Management is enabled. Note, this must be a dynamic soql
query because referencing DatedConversionRate will not compile in orgs
without Advanced MultiCurrency Management enabled.

Note: This was originally written by the NPSP team and can be found here:
https://github.com/SalesforceFoundation/NPSP/blob/aad20ffb747ecda9a037c4bce9cd19617b6a727b/src/classes/UTIL_Currency.cls#L79

#### Signature

```apex
public Boolean isAdvancedMultiCurrencyManagementEnabled()
```

#### Return Type

**Boolean**

,[object Object]

---

### `getOrgShape()`

`SUPPRESSWARNINGS`
`TESTVISIBLE`

Private method that memoizes the query result
Suppressing the PMD warning to validate crud permissions before
DML, because the Organization Object is always available.

#### Signature

```apex
private Organization getOrgShape()
```

#### Return Type

**Organization**

,[object Object]

---

### `getOrgRecord()`

`SUPPRESSWARNINGS`

Private method for pulling the Organization record
Note: We&#x27;re suppressing PMD warning on Crud Checking because we want
everyone to be able to pull this read-only record.

#### Signature

```apex
private static Organization getOrgRecord()
```

#### Return Type

**Organization**

,[object Object], Organization Record

## Classes

### CachedOrgShape Class

this class is used to marshall / return the cached org shape data, if available

**Implements**

Cache.CacheBuilder

#### Methods

##### `doLoad(requiredButNotUsed)`

`SUPPRESSWARNINGS`

We&#x27;re suppressing PMD warning on Crud Checking because we want
everyone to be able to pull this read-only record. Note this is a cachebuilder implementing class.

###### Signature

```apex
public Organization doLoad(String requiredButNotUsed)
```

###### Parameters

| Name                                                                                        | Type   | Description                                                                  |
| ------------------------------------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------- |
| requiredButNotUsed                                                                          | String | String required by the interface, but not used in the method. It acts as the |
| cache key, and since that&#x27;s passed at runtime, it&#x27;s used, but not by this method. |

###### Return Type

**Organization**

,[object Object], Organization Record - hopefully from cache.
