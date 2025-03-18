/**
 * @description Test class for CustomMetadataUtilDeploymentCallback
 * @author ApexKit Contributors
 */
@IsTest
private class CustomMetadataUtilDeployCallbackTests {
	/**
	 * @description Test successful deployment callback
	 */
	@IsTest
	static void unitHandleResultSuccessPositive() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		CustomMetadataUtilities.testCircuitBreaker = true;

		System.runAs(testUser) {
			CustomMetadataUtilDeploymentCallback callback = new CustomMetadataUtilDeploymentCallback();
			Metadata.DeployResult result = new Metadata.DeployResult();
			result.status = Metadata.DeployStatus.Succeeded;
			Metadata.DeployCallbackContext context = null; // Not used in the implementation

			// Act
			Test.startTest();
			callback.handleResult(result, context);
			Test.stopTest();

			// Assert - No exception should be thrown
			System.assert(
				true,
				'handleResult should process successful result without errors'
			);
		}
	}

	/**
	 * @description Test failed deployment callback - should throw exception
	 */
	@IsTest
	static void unitHandleResultFailureNegative() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			CustomMetadataUtilDeploymentCallback callback = new CustomMetadataUtilDeploymentCallback();
			Metadata.DeployResult result = new Metadata.DeployResult();
			result.status = Metadata.DeployStatus.Failed;
			Metadata.DeployCallbackContext context = null; // Not used in the implementation

			// Act & Assert
			Test.startTest();
			Boolean exceptionThrown = false;
			try {
				callback.handleResult(result, context);
			} catch (CustomMetadataUtilDeploymentCallback.CustomMetadataUtilDeploymentCallbackException e) {
				exceptionThrown = true;
				// Verify the exception message contains information about the result
				System.debug('E is: ' + e);
				System.assert(
					e.getMessage()
						.contains(
							'Callback received a result status that indicated failure.'
						),
					'Exception message should contain "Callback received a result status that indicated failure."'
				);
			}

			System.assert(
				exceptionThrown,
				'CustomMetadataUtilDeploymentCallbackException should be thrown for failed deployments'
			);
			Test.stopTest();
		}
	}

	/**
	 * @description Test deployment callback with InProgress status - should throw exception
	 */
	@IsTest
	static void unitHandleResultInProgressNegative() {
		CustomMetadataUtilities.testCircuitBreaker = true;
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			CustomMetadataUtilDeploymentCallback callback = new CustomMetadataUtilDeploymentCallback();
			Metadata.DeployResult result = new Metadata.DeployResult();
			result.status = Metadata.DeployStatus.InProgress;
			Metadata.DeployCallbackContext context = null; // Not used in the implementation

			// Act & Assert
			Test.startTest();
			Boolean exceptionThrown = false;
			try {
				callback.handleResult(result, context);
			} catch (CustomMetadataUtilDeploymentCallback.CustomMetadataUtilDeploymentCallbackException e) {
				exceptionThrown = true;
			}

			System.assert(
				exceptionThrown,
				'CustomMetadataUtilDeploymentCallbackException should be thrown for non-success statuses'
			);
			Test.stopTest();
		}
	}

	/**
	 * @description Test deployment callback with null result - should throw exception
	 */
	@IsTest
	static void unitHandleResultNullNegative() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			CustomMetadataUtilDeploymentCallback callback = new CustomMetadataUtilDeploymentCallback();
			Metadata.DeployResult result = null;
			Metadata.DeployCallbackContext context = null;

			// Act & Assert
			Test.startTest();
			Boolean exceptionThrown = false;
			try {
				callback.handleResult(result, context);
			} catch (Exception e) {
				// Any exception is expected here
				exceptionThrown = true;
			}

			System.assert(
				exceptionThrown,
				'An exception should be thrown for null result'
			);
			Test.stopTest();
		}
	}
}
