**Author** ApexKit Contributors

**Implements**

Metadata.DeployCallback

## Methods

### `handleResult(result, context)`

Handles the result of a metadata deployment.
NOTE: This is a stub. This is functional, but bare-minimum implementation.
You should 100% re-write this method to work with your needs.

#### Signature

```apex
public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context)
```

#### Parameters

| Name    | Type                           | Description                                                                                        |
| ------- | ------------------------------ | -------------------------------------------------------------------------------------------------- |
| result  | Metadata.DeployResult          | The DeployResult object containing deployment status and details - this is DI&#x27;d by Salesforce |
| context | Metadata.DeployCallbackContext | The DeployCallbackContext for the deployment - this is DI&#x27;d by Salesforce                     |

#### Return Type

**void**

#### Throws

CustomMetadataUtilDeploymentCallbackException: When deployment fails

## Classes

### CustomMetadataUtilDeploymentCallbackException Class

Exception class for deployment callback errors
