/**
 * @description Class serves to DRY code for various testing methods that
 * require it.
 */
@isTest
public class FeatureFlagCommonTests {
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
                id = 'm021h000000lDU8',
                isEnabled__c = enabled,
                flag_value__c = 'test value'
            )
        );
        return testFlag;
    }

    public static Id getExistingPermSetId() {
        return new SOQL.Builder('PermissionSet')
            .selectField('Id')
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
                Feature_Flag__c = 'm021h000000lDU8',
                isEnabled__c = enabled,
                Permission_Set_Id__c = permSetId
            )
        );
        return overriddenPerPermSet;
    }
}
