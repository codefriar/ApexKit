**Author** ApexKit Contributors

## Fields

### `testCircuitBreaker`

`TESTVISIBLE`

#### Signature

```apex
private static testCircuitBreaker
```

#### Type

Boolean

---

### `DISALLOWED_FIELDS`

Set of system fields that shouldn&#x27;t be included in deployments

#### Signature

```apex
private static final DISALLOWED_FIELDS
```

#### Type

Set&lt;String&gt;

---

### `metadataObjectName`

API name of the custom metadata type

#### Signature

```apex
private final metadataObjectName
```

#### Type

String

---

### `metadataObjectFields`

Set of field API names available on the custom metadata type

#### Signature

```apex
private final metadataObjectFields
```

#### Type

Set&lt;String&gt;

---

### `metadataDeveloperName`

Developer name of the custom metadata record

#### Signature

```apex
private final metadataDeveloperName
```

#### Type

String

---

### `metadataLabel`

Label of the custom metadata record

#### Signature

```apex
private final metadataLabel
```

#### Type

String

---

### `updateDeploymentContainer`

Container for metadata records to be updated

#### Signature

```apex
private final updateDeploymentContainer
```

#### Type

Metadata.DeployContainer

---

### `createDeploymentContainer`

Container for metadata records to be created

#### Signature

```apex
private final createDeploymentContainer
```

#### Type

Metadata.DeployContainer

---

### `memoizedFilteredFields`

#### Signature

```apex
private memoizedFilteredFields
```

#### Type

List&lt;String&gt;

## Properties

### `customMetadataRecords`

List of custom metadata records to be created or updated

#### Signature

```apex
private final customMetadataRecords
```

#### Type

List&lt;SObject&gt;

---

### `filteredFields`

#### Signature

```apex
private final filteredFields
```

#### Type

List&lt;String&gt;

## Constructors

### `CustomMetadataUtilities(customMetadataRecords)`

Constructor

#### Signature

```apex
public CustomMetadataUtilities(List<SObject> customMetadataRecords)
```

#### Parameters

| Name                  | Type                | Description                                                                      |
| --------------------- | ------------------- | -------------------------------------------------------------------------------- |
| customMetadataRecords | List&lt;SObject&gt; | List&lt;SObject&gt; The list of custom metadata records to be created or updated |

## Methods

### `upsertCustomMetadata()`

Processes metadata records and adds them to appropriate deployment containers

#### Signature

```apex
public void upsertCustomMetadata()
```

#### Return Type

**void**

---

### `sanityChecks()`

Validates that required metadata properties exist

#### Signature

```apex
private void sanityChecks()
```

#### Return Type

**void**

#### Throws

CustomMetadataUtilitiesException: if metadata object name or label is blank

---

### `buildCustomMetadata(incomingMetadataRecord)`

Builds a custom metadata record for deployment

#### Signature

```apex
private Metadata.CustomMetadata buildCustomMetadata(SObject incomingMetadataRecord)
```

#### Parameters

| Name                   | Type    | Description                                                |
| ---------------------- | ------- | ---------------------------------------------------------- |
| incomingMetadataRecord | SObject | SObject containing the data for the custom metadata record |

#### Return Type

**Metadata.CustomMetadata**

Metadata.CustomMetadata The built metadata record ready for deployment

---

### `buildPerRecordDeveloperName(incomingMetadataRecord)`

Constructs the full API name for a custom metadata record

#### Signature

```apex
private String buildPerRecordDeveloperName(SObject incomingMetadataRecord)
```

#### Parameters

| Name                   | Type    | Description                                |
| ---------------------- | ------- | ------------------------------------------ |
| incomingMetadataRecord | SObject | SObject containing the DeveloperName field |

#### Return Type

**String**

String The full API name in the format ObjectName.DeveloperName

---

### `startDeployment(deployContainer)`

Initiates the deployment of custom metadata records

#### Signature

```apex
private void startDeployment(Metadata.DeployContainer deployContainer)
```

#### Parameters

| Name            | Type                     | Description                                    |
| --------------- | ------------------------ | ---------------------------------------------- |
| deployContainer | Metadata.DeployContainer | Container with metadata records to be deployed |

#### Return Type

**void**

Id The job ID of the deployment

## Classes

### CustomMetadataUtilitiesException Class

Exception class for custom metadata utilities errors
