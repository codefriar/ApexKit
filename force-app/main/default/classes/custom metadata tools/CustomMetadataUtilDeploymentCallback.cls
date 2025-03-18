/**
 * @description Callback implementation for Custom Metadata deployment operations
 * @author ApexKit Contributors
 */
public with sharing class CustomMetadataUtilDeploymentCallback implements Metadata.DeployCallback {
	/**
	 * @description Exception class for deployment callback errors
	 */
	public class CustomMetadataUtilDeploymentCallbackException extends Exception {
	}

	/**
	 * @description Handles the result of a metadata deployment.
	 *  NOTE: This is a stub. This is functional, but bare-minimum implementation.
	 *  You should 100% re-write this method to work with your needs.
	 *
	 * @param result The DeployResult object containing deployment status and details - this is DI'd by Salesforce
	 * @param context The DeployCallbackContext for the deployment - this is DI'd by Salesforce
	 * @throws CustomMetadataUtilDeploymentCallbackException When deployment fails
	 */
	public void handleResult(
		Metadata.DeployResult result,
		Metadata.DeployCallbackContext context
	) {
		if (result.status == Metadata.DeployStatus.Succeeded) {
			System.debug(
				'Callback received a result status that indicated success. Results: ' +
				result
			);
		} else if (result.status == Metadata.DeployStatus.Failed) {
			System.debug(
				'Callback received a result status that indicated failure. Results: ' +
				result
			);
			throw new CustomMetadataUtilDeploymentCallbackException(
				'Callback received a result status that indicated failure. Results: ' +
				result
			);
		} else {
			throw new CustomMetadataUtilDeploymentCallbackException(
				'Custom Metadata deployment failed. Results: ' + String.valueOf(result)
			);
		}
	}
}
