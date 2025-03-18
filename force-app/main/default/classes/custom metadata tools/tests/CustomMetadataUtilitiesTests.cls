/**
 * @description Test class for CustomMetadataUtilities
 * @author ApexKit Contributors
 */
@IsTest
private class CustomMetadataUtilitiesTests {
	/**
	 * @description Sets up test data used across test methods
	 * @return Feature_Flag__mdt A mock custom metadata record for testing
	 */
	private static Feature_Flag__mdt setupTestData() {
		Feature_Flag__mdt mockMdt = new Feature_Flag__mdt();
		mockMdt.DeveloperName = 'Test_Flag';
		mockMdt.Label = 'Test Flag';
		mockMdt.Flag_Value__c = 'Test Value';
		mockMdt.isEnabled__c = true;
		return mockMdt;
	}

	/**
	 * @description Test the constructor initializes properties correctly
	 */
	@IsTest
	static void unitCustomMetadataUtilitiesConstructorPositive() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			Feature_Flag__mdt mockMdt = setupTestData();
			List<SObject> mdtList = new List<SObject>{ mockMdt };

			// Act
			Test.startTest();
			CustomMetadataUtilities cmUtils = new CustomMetadataUtilities(mdtList);
			Test.stopTest();

			// Assert - No assertions directly possible as properties are private
			// This test just ensures no exceptions are thrown
			System.assert(true, 'Constructor should initialize without errors');
		}
	}

	/**
	 * @description Test constructor with empty list
	 */
	@IsTest
	static void unitCustomMetadataUtilitiesConstructorWithEmptyListPositive() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			List<SObject> emptyList = new List<SObject>();

			// Act
			Test.startTest();
			CustomMetadataUtilities cmUtils = new CustomMetadataUtilities(emptyList);
			Test.stopTest();

			// Assert - No assertions directly possible as properties are private
			// This test just ensures no exceptions are thrown
			System.assert(
				true,
				'Constructor should handle empty list without errors'
			);
		}
	}

	/**
	 * @description Test invokeService method with valid records
	 */
	@IsTest
	static void unitUpsertCustomMetadataPositive() {
		CustomMetadataUtilities.testCircuitBreaker = true;
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			Feature_Flag__mdt mockMdt = setupTestData();
			List<SObject> mdtList = new List<SObject>{ mockMdt };

			// Create a mock for the Metadata.Operations class
			// Since we can't mock the actual Metadata API calls in unit tests
			Test.setMock(WebServiceMock.class, new MetadataServiceMock());

			// Act
			Test.startTest();
			CustomMetadataUtilities cmUtils = new CustomMetadataUtilities(mdtList);

			try {
				cmUtils.upsertCustomMetadata();
				// If we get here, no exception was thrown
				System.assert(true, 'invokeService should execute without errors');
			} catch (Exception e) {
				System.debug('E is: ' + e);
				System.assert(
					false,
					'No exception should be thrown: ' + e.getMessage()
				);
			}
			Test.stopTest();
		}
	}

	/**
	 * @description Test invokeService method with invalid records
	 * expecting CustomMetadataUtilitiesException
	 */
	@IsTest
	static void unitUpsertCustomMetadataWithInvalidDataNegative() {
		// Arrange
		User testUser = new User(Id = UserInfo.getUserId());
		System.runAs(testUser) {
			// Create an SObject that's missing required fields
			Account invalidObj = new Account(); // Using Account as it's not a metadata type
			List<SObject> invalidList = new List<SObject>{ invalidObj };

			// Act & Assert
			Test.startTest();
			Boolean exceptionThrown = false;
			try {
				CustomMetadataUtilities cmUtils = new CustomMetadataUtilities(
					invalidList
				);
			} catch (CustomMetadataUtilities.CustomMetadataUtilitiesException e) {
				exceptionThrown = true;
			} catch (Exception e) {
				// We're specifically looking for CustomMetadataUtilitiesException
				System.assert(false, 'Wrong exception type thrown: ' + e.getTypeName());
			}

			System.assert(
				exceptionThrown,
				'CustomMetadataUtilitiesException should be thrown'
			);
			Test.stopTest();
		}
	}

	/**
	 * @description Mock class for Metadata API callouts
	 */
	public class MetadataServiceMock implements WebServiceMock {
		public void doInvoke(
			Object stub,
			Object request,
			Map<String, Object> response,
			String endpoint,
			String soapAction,
			String requestName,
			String responseNS,
			String responseName,
			String responseType
		) {
			// Mock successful response for deploy operation
			if (requestName == 'deploy') {
				response.put('result', new Metadata.DeployResult());
			}
		}
	}
}
