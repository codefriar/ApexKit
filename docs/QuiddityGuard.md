Note: I am not responsible for the name &#x27;Quiddity&#x27;. Rumor has it the word comes from Sanskrit and means &#x27;essence&#x27;.

## Fields

### `testQuiddityOverride`

`TESTVISIBLE`

a private testvisible variable allowing developers to
inject a custom quiddity value during test execution.

#### Signature

```apex
private static testQuiddityOverride
```

#### Type

Quiddity

---

### `trustedQuiddities`

a non-exhaustive list of Quiddities that do not include user
situations where users could be injecting malicious data.

#### Signature

```apex
public static trustedQuiddities
```

#### Type

List&lt;Quiddity&gt;

---

### `trustedTestQuiddities`

An exaustive list of quiddities that are valid for a test
execution

#### Signature

```apex
public static trustedTestQuiddities
```

#### Type

List&lt;Quiddity&gt;

---

### `untrustedQuiddities`

A list of quiddities that may include user-defined data and
therefore should not be trusted without manual FLS/CRUD checks

#### Signature

```apex
public static untrustedQuiddities
```

#### Type

List&lt;Quiddity&gt;

## Methods

### `isAcceptableQuiddity(acceptableQuiddites)`

A method to determine if the current Quiddity context is
within a caller-supplied list of acceptable quiddity values.

#### Signature

```apex
public static Boolean isAcceptableQuiddity(List<Quiddity> acceptableQuiddites)
```

#### Parameters

| Name                | Type                 | Description                           |
| ------------------- | -------------------- | ------------------------------------- |
| acceptableQuiddites | List&lt;Quiddity&gt; | A list of quiddities to check against |

#### Return Type

**Boolean**

,[object Object]

---

### `isNotAcceptableQuiddity(acceptableQuiddites)`

Method to determine if the current Quiddity context is not acceptable

#### Signature

```apex
public static Boolean isNotAcceptableQuiddity(List<Quiddity> acceptableQuiddites)
```

#### Parameters

| Name                | Type                 | Description                                         |
| ------------------- | -------------------- | --------------------------------------------------- |
| acceptableQuiddites | List&lt;Quiddity&gt; | List&lt;Quiddity&gt; A list of quiddities to allow. |

#### Return Type

**Boolean**

Boolean true if the current quiddity is not in the list of acceptable quiddities.

---

### `quiddity()`

method grabs the current quiddity from the request object

#### Signature

```apex
public static Quiddity quiddity()
```

#### Return Type

**Quiddity**

Quiddity The current quiddity.

---

### `quiddityIsATestContext()`

Syntactic sugar method for determining if the current request quiddity is a known test quiddity.

#### Signature

```apex
public static Boolean quiddityIsATestContext()
```

#### Return Type

**Boolean**

Boolean true if the current quiddity is in the list of trusted test quiddities.
