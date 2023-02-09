/**
 * @description Class serves to DRY code for various testing methods that
 * require it. It is not intended to be used directly.
 */
@isTest
public class FeatureFlagCommonTests {
	static id exampleFeatureFlagId = [SELECT Id FROM Feature_Flag__mdt LIMIT 1]
	.Id;

	public static Map<String, Feature_Flag__mdt> getTestFlag(
		String flagName,
		Boolean enabled
	) {
		Map<String, Feature_Flag__mdt> testFlag = new Map<String, Feature_Flag__mdt>();
		testFlag.put(
			'TestFlag',
			new Feature_Flag__mdt(
				Label = flagName,
				DeveloperName = flagName,
				id = exampleFeatureFlagId,
				isEnabled__c = enabled,
				flag_value__c = 'test value'
			)
		);
		return testFlag;
	}

	public static Id getExistingPermSetId() {
		return new SOQL.Builder('PermissionSet')
			.selectField('Id')
			.whereCondition(
				new Query.Condition().equals('Name', 'Async_Log_Access')
			)
			.build()
			.getRecord()
			.Id;
	}

	public static Map<String, Feature_Flag_Enabled_For__mdt> getOverriddenPerPermSet(
		String flagName,
		Id permSetId,
		Boolean enabled
	) {
		Map<String, Feature_Flag_Enabled_For__mdt> overriddenPerPermSet = new Map<String, Feature_Flag_Enabled_For__mdt>();
		overriddenPerPermSet.put(
			flagName,
			new Feature_Flag_Enabled_For__mdt(
				Label = 'TestFlag',
				DeveloperName = 'TestFlag',
				Feature_Flag__c = exampleFeatureFlagId,
				isEnabled__c = enabled,
				Permission_Set_Id__c = permSetId
			)
		);
		return overriddenPerPermSet;
	}
}