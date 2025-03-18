Test class for CustomMetadataUtilities

**Author** ApexKit Contributors

## Methods

### `setupTestData()`

Sets up test data used across test methods

#### Signature

```apex
private static Feature_Flag__mdt setupTestData()
```

#### Return Type

**Feature_Flag\_\_mdt**

Feature_Flag\_\_mdt A mock custom metadata record for testing

---

### `unitCustomMetadataUtilitiesConstructorPositive()`

`ISTEST`

Test the constructor initializes properties correctly

#### Signature

```apex
private static void unitCustomMetadataUtilitiesConstructorPositive()
```

#### Return Type

**void**

---

### `unitCustomMetadataUtilitiesConstructorWithEmptyListPositive()`

`ISTEST`

Test constructor with empty list

#### Signature

```apex
private static void unitCustomMetadataUtilitiesConstructorWithEmptyListPositive()
```

#### Return Type

**void**

---

### `unitUpsertCustomMetadataPositive()`

`ISTEST`

Test invokeService method with valid records

#### Signature

```apex
private static void unitUpsertCustomMetadataPositive()
```

#### Return Type

**void**

---

### `unitUpsertCustomMetadataWithInvalidDataNegative()`

`ISTEST`

Test invokeService method with invalid records
expecting CustomMetadataUtilitiesException

#### Signature

```apex
private static void unitUpsertCustomMetadataWithInvalidDataNegative()
```

#### Return Type

**void**

## Classes

### MetadataServiceMock Class

Mock class for Metadata API callouts

**Implements**

WebServiceMock

#### Methods

##### `doInvoke(stub, request, response, endpoint, soapAction, requestName, responseNS, responseName, responseType)`

###### Signature

```apex
public void doInvoke(Object stub, Object request, Map<String,Object> response, String endpoint, String soapAction, String requestName, String responseNS, String responseName, String responseType)
```

###### Parameters

| Name         | Type                     | Description |
| ------------ | ------------------------ | ----------- |
| stub         | Object                   |             |
| request      | Object                   |             |
| response     | Map&lt;String,Object&gt; |             |
| endpoint     | String                   |             |
| soapAction   | String                   |             |
| requestName  | String                   |             |
| responseNS   | String                   |             |
| responseName | String                   |             |
| responseType | String                   |             |

###### Return Type

**void**
