/**
 * @description Class serves to DRY code for various testing methods that
 * require it. It is not intended to be used directly.
 */
@IsTest
public class FeatureFlagCommonTests {
	/**
	 * @description This is the id of the feature flag that's included with ApexKit. CMDT can be hard to test with
	 * because you can't necessarily know the object prefix until a cmdt record is saved. :(
	 */
	static final Id EXAMPLE_FEATURE_FLAG_ID = [
		SELECT Id
		FROM Feature_Flag__mdt
		LIMIT 1
	]
	.Id;

	/**
	 * @description DRY method to create a test flag with valid-ish id.
	 *
	 * @param flagName String name of the Flag
	 * @param enabled Boolean whether the flag is enabled universally or not
	 *
	 * @return Map<String, Feature_Flag__mdt> test flag
	 */
	public static Map<String, Feature_Flag__mdt> getTestFlag(String flagName, Boolean enabled) {
		Map<String, Feature_Flag__mdt> testFlag = new Map<String, Feature_Flag__mdt>();
		testFlag.put(
			'TestFlag',
			new Feature_Flag__mdt(
				Label = flagName,
				DeveloperName = flagName,
				Id = EXAMPLE_FEATURE_FLAG_ID,
				isEnabled__c = enabled,
				Flag_Value__c = 'test value'
			)
		);
		return testFlag;
	}

	/**
	 * @description fetches a valid permission set id
	 *
	 * @return Id the id of the permissionset that's included with ApexKit
	 */
	public static Id getExistingPermSetId() {
		return new SOQL.Builder('PermissionSet')
			.selectField('Id')
			.whereCondition(new Query.Condition().equals('Name', 'Async_Log_Access'))
			.build()
			.getRecord()
			.Id;
	}

	/**
	 * @description returns a map of feature flags that are enabled just for a specified permission set
	 *
	 * @param flagName String name of the flag
	 * @param permSetId Id the id of the permission set that enables this flag
	 * @param enabled Boolean whether the flag is enabled or not
	 *
	 * @return Map<String, Feature_Flag_Enabled_For__mdt> the map of feature flags
	 */
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
				Feature_Flag__c = EXAMPLE_FEATURE_FLAG_ID,
				isEnabled__c = enabled,
				Permission_Set_Id__c = permSetId
			)
		);
		return overriddenPerPermSet;
	}
}
