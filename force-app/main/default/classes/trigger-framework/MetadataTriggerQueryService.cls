/**
 * @group Trigger Framework
 */
public with sharing class MetadataTriggerQueryService {
	private String objType = '';

	public MetadataTriggerQueryService(String objectTypeName) {
		this.objType = objectTypeName;
	}

	/**
	 * @description This query finds an ordered list trigger handler classes
	 * to execute. It ignores any classes that are marked as disabled.
	 *
	 * <br>Note: It will exclude any triggerHandler metadata records for which
	 * the user's email address is found in a related disabled_for__mdt
	 * record.
	 *
	 * <br>Admins and Developers can selectively disable trigger handlers
	 * for all or selected individuals *without* deploying.
	 * @return      `List<Metadata_Driven_Trigger__mdt>`
	 */
	@suppressWarnings('PMD.ApexCRUDViolation')
	public List<Metadata_Driven_Trigger__mdt> getMetadataTriggers() {
		return [
			SELECT Class__c
			FROM Metadata_Driven_Trigger__mdt
			WHERE
				Object__r.QualifiedApiName = :this.objType
				AND Enabled__c = TRUE
				AND Id NOT IN (
					SELECT Metadata_Driven_Trigger__c
					FROM Disabled_for__mdt
					WHERE User_Email__c = :UserInfo.getUsername()
				)
			ORDER BY Execution_Order__c
		];
	}

	/**
	 * @description This determines the active sObject type by describing the first
	 * record in the trigger New / Old list
	 * @param  triggerNew Trigger.new description
	 * @param  triggerOld Trigger.old description
	 * @return            `String` SObjectType (name?)
	 */
	public static String getSObjectType(
		List<sObject> triggerNew,
		List<sObject> triggerOld
	) {
		if (triggerNew != null) {
			return Polyfills.getSObjectTypeFromList(triggerNew);
		} else if (triggerOld != null) {
			return Polyfills.getSObjectTypeFromList(triggerOld);
		} else {
			throw new MetadataTriggerFramework.MetadataTriggerFrameworkException(
				'Passed values for triggerNew and triggerOld are both null. Are you exercising this method outside of a trigger context?'
			);
		}
	}
}