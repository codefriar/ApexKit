/**
 * @description Utility class for creating and updating Custom Metadata records programmatically
 * @author ApexKit Contributors
 */
public with sharing class CustomMetadataUtilities {
	@TestVisible
	private static Boolean testCircuitBreaker = false;
	/**
	 * @description Set of system fields that shouldn't be included in deployments
	 */
	private static final Set<String> DISALLOWED_FIELDS = new Set<String>{
		'Id',
		'Language',
		'Label',
		'DeveloperName',
		'MasterLabel',
		'NamespacePrefix',
		'QualifiedApiName'
	};
	/**
	 * @description List of custom metadata records to be created or updated
	 */
	private final List<SObject> customMetadataRecords { get; private set; }
	/**
	 * @description API name of the custom metadata type
	 */
	private final String metadataObjectName;
	/**
	 * @description Set of field API names available on the custom metadata type
	 */
	private final Set<String> metadataObjectFields;
	/**
	 * @description Developer name of the custom metadata record
	 */
	private final String metadataDeveloperName;
	/**
	 * @description Label of the custom metadata record
	 */
	private final String metadataLabel;
	/**
	 * @description Container for metadata records to be updated
	 */
	private final Metadata.DeployContainer updateDeploymentContainer = new Metadata.DeployContainer();
	/**
	 * @description Container for metadata records to be created
	 */
	private final Metadata.DeployContainer createDeploymentContainer = new Metadata.DeployContainer();

	private List<String> memoizedFilteredFields;
	private final List<String> filteredFields {
		get {
			if (memoizedFilteredFields == null) {
				memoizedFilteredFields = new List<String>();
				for (String field : this.metadataObjectFields) {
					if (!DISALLOWED_FIELDS.contains(field)) {
						memoizedFilteredFields.add(field);
					}
				}
			}
			return memoizedFilteredFields;
		}
	}

	/**
	 * @description Exception class for custom metadata utilities errors
	 */
	public class CustomMetadataUtilitiesException extends Exception {
	}

	/**
	 * @description Constructor
	 *
	 * @param customMetadataRecords List<SObject> The list of custom metadata records to be created or updated
	 */
	public CustomMetadataUtilities(List<SObject> customMetadataRecords) {
		this.customMetadataRecords = customMetadataRecords;
		if (customMetadataRecords.isEmpty()) {
			return;
		}
		SObject firstObject = customMetadataRecords[0];
		this.metadataObjectName = String.valueOf(firstObject.getSObjectType());
		Set<String> firstObjectsFields = firstObject.getSObjectType()
			.getDescribe()
			.fields.getMap()
			.keySet();
		this.metadataObjectFields = firstObjectsFields;

		try {
			this.metadataDeveloperName = (String) firstObject.get('DeveloperName');
		} catch (SObjectException sObjectException) {
			throw new CustomMetadataUtilitiesException(
				'Custom metadata records must have a DeveloperName field, the first object passed into this method does not. It\'s likely not a custom metadata object'
			);
		}
		this.metadataLabel = (String) firstObject.get('Label');
	}

	/**
	 * @description Processes metadata records and adds them to appropriate deployment containers
	 * @param mdRecords List of SObjects representing custom metadata records to be processed
	 */
	public void upsertCustomMetadata() {
		sanityChecks();
		for (SObject currentMdRecord : this.customMetadataRecords) {
			String currentMdRecordDeveloperName = String.valueOf(
				currentMdRecord.get('DeveloperName')
			);
			if (String.isBlank(currentMdRecordDeveloperName)) {
				this.createDeploymentContainer.addMetadata(
					buildCustomMetadata(currentMdRecord)
				);
				continue;
			}
			this.updateDeploymentContainer.addMetadata(
				buildCustomMetadata(currentMdRecord)
			);
		}
		if (this.createDeploymentContainer.getMetadata().size() > 0) {
			startDeployment(this.createDeploymentContainer);
		}
		if (this.updateDeploymentContainer.getMetadata().size() > 0) {
			startDeployment(this.updateDeploymentContainer);
		}
	}

	/**
	 * @description Validates that required metadata properties exist
	 * @throws CustomMetadataUtilitiesException if metadata object name or label is blank
	 */
	private void sanityChecks() {
		if (
			String.isBlank(this.metadataObjectName) &&
			String.isBlank(this.metadataLabel)
		) {
			throw new CustomMetadataUtilitiesException();
		}
		if (!this.metadataObjectName.endsWith('__mdt')) {
			throw new CustomMetadataUtilitiesException(
				'Invoked with a non-custom metadata object'
			);
		}
	}

	/**
	 * @description Builds a custom metadata record for deployment
	 * @param incomingMetadataRecord SObject containing the data for the custom metadata record
	 * @return Metadata.CustomMetadata The built metadata record ready for deployment
	 */
	private Metadata.CustomMetadata buildCustomMetadata(
		SObject incomingMetadataRecord
	) {
		Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
		customMetadata.fullName = buildPerRecordDeveloperName(
			incomingMetadataRecord
		);

		customMetadata.label = this.metadataLabel;
		system.debug('filteredFields: ' + this.filteredFields);
		for (String key : this.filteredFields) {
			Metadata.CustomMetadataValue customMetadataValue = new Metadata.CustomMetadataValue();
			customMetadataValue.field = key;
			customMetadataValue.value = incomingMetadataRecord.get(key);
			customMetadata.values.add(customMetadataValue);
		}
		return customMetadata;
	}

	/**
	 * @description Constructs the full API name for a custom metadata record
	 * @param incomingMetadataRecord SObject containing the DeveloperName field
	 * @return String The full API name in the format ObjectName.DeveloperName
	 */
	private String buildPerRecordDeveloperName(SObject incomingMetadataRecord) {
		String recordDeveloperName = String.valueOf(
			incomingMetadataRecord.get('DeveloperName')
		);
		String fullName = this.metadataObjectName + '.';
		fullName += String.isBlank(recordDeveloperName)
			? this.metadataDeveloperName
			: recordDeveloperName;

		return fullName;
	}

	/**
	 * @description Initiates the deployment of custom metadata records
	 * @param deployContainer Container with metadata records to be deployed
	 * @return Id The job ID of the deployment
	 */
	private void startDeployment(Metadata.DeployContainer deployContainer) {
		if (testCircuitBreaker) {
			return;
		}
		CustomMetadataUtilDeploymentCallback deploymentCallback = new CustomMetadataUtilDeploymentCallback();
		Id jobId = Metadata.Operations.enqueueDeployment(
			deployContainer,
			deploymentCallback
		);
	}
}
