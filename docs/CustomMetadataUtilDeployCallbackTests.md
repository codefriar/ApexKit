Test class for CustomMetadataUtilDeploymentCallback

**Author** ApexKit Contributors

## Methods

### `unitHandleResultSuccessPositive()`

`ISTEST`

Test successful deployment callback

#### Signature

```apex
private static void unitHandleResultSuccessPositive()
```

#### Return Type

**void**

---

### `unitHandleResultFailureNegative()`

`ISTEST`

Test failed deployment callback - should throw exception

#### Signature

```apex
private static void unitHandleResultFailureNegative()
```

#### Return Type

**void**

---

### `unitHandleResultInProgressNegative()`

`ISTEST`

Test deployment callback with InProgress status - should throw exception

#### Signature

```apex
private static void unitHandleResultInProgressNegative()
```

#### Return Type

**void**

---

### `unitHandleResultNullNegative()`

`ISTEST`

Test deployment callback with null result - should throw exception

#### Signature

```apex
private static void unitHandleResultNullNegative()
```

#### Return Type

**void**
