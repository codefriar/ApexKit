`STATUS: ACTIVE`

contains methods and static lists for rapid acceptance of a particular set of quiddities.
Note: I am not responsible for the name 'Quiddity'. Rumor has it the word comes from Sanskrit and means 'essence'.

## Fields

### `private testQuiddityOverride` → `Quiddity`

`TESTVISIBLE`

a private testvisible variable allowing developers to inject a custom quiddity value during test execution.

### `public trustedQuiddities` → `List<Quiddity>`

a non-exhaustive list of Quiddities that do not include user situations where users could be injecting malicious data.

### `public trustedTestQuiddities` → `List<Quiddity>`

An exaustive list of quiddities that are valid for a test execution

### `public untrustedQuiddities` → `List<Quiddity>`

A list of quiddities that may include user-defined data and therefore should not be trusted without manual FLS/CRUD checks

---

## Methods

### `public static Boolean isAcceptableQuiddity(List<Quiddity> acceptableQuiddites)`

A method to determine if the current Quiddity context is within a caller-supplied list of acceptable quiddity values.

#### Parameters

| Param                 | Description                           |
| --------------------- | ------------------------------------- |
| `acceptableQuiddites` | A list of quiddities to check against |

#### Returns

| Type    | Description |
| ------- | ----------- |
| Boolean | `boolean`   |

### `public static Boolean isNotAcceptableQuiddity(List<Quiddity> acceptableQuiddites)`

Method to determine if the current Quiddity context is not acceptable

#### Parameters

| Param                 | Description                                   |
| --------------------- | --------------------------------------------- |
| `acceptableQuiddites` | List<Quiddity> A list of quiddities to allow. |

#### Returns

| Type    | Description                                                                       |
| ------- | --------------------------------------------------------------------------------- |
| Boolean | Boolean true if the current quiddity is not in the list of acceptable quiddities. |

### `public static Quiddity quiddity()`

method grabs the current quiddity from the request object

#### Returns

| Type     | Description                    |
| -------- | ------------------------------ |
| Quiddity | Quiddity The current quiddity. |

### `public static Boolean quiddityIsATestContext()`

Syntactic sugar method for determining if the current request quiddity is a known test quiddity.

#### Returns

| Type    | Description                                                                     |
| ------- | ------------------------------------------------------------------------------- |
| Boolean | Boolean true if the current quiddity is in the list of trusted test quiddities. |

---
