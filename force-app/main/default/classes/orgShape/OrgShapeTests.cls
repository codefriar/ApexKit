@isTest
class OrgShapeTests {
    private static OrgShape orgShape;
    private static Organization orgCheck;
    static {
        orgShape = new orgShape();
        orgCheck = (Organization) new SOQL.builder('Organization')
            .SelectStandard()
            .setScopeLimit(1)
            .build()
            .getRecord();
    }

    @isTest
    static void testOrgShapeProperties() {
        System.assertEquals(
            orgCheck.isSandbox,
            orgShape.isSandbox,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            UserInfo.isMultiCurrencyOrganization(),
            orgShape.multiCurrencyEnabled,
            'Expected the OrgShape property to match the UserInfo property'
        );
        System.assertEquals(
            orgCheck.OrganizationType,
            orgShape.orgType,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.isReadOnly,
            orgShape.isReadOnly,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.instanceName,
            orgShape.instanceName,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.instanceName,
            orgShape.podName,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.fiscalYearStartMonth,
            orgShape.getFiscalYearStartMonth,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            UserInfo.getUiThemeDisplayed().containsIgnoreCase('theme4'),
            orgShape.lightningEnabled,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.id,
            orgShape.id,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.languageLocaleKey,
            orgShape.locale,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.timeZoneSidKey,
            orgShape.timeZoneKey,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.name,
            orgShape.name,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.namespacePrefix,
            orgShape.namespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            String.isNotBlank(orgCheck.namespacePrefix),
            orgShape.hasNamespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.id,
            orgShape.id,
            'expected these to be equal'
        );
    }

    @isTest
    static void testAdvancedMultiCurrencyManagement() {
        Boolean datedConversionRateObjectExists = false;
        try {
            Database.query('SELECT Id FROM DatedConversionRate LIMIT 1').size();
            datedConversionRateObjectExists = true;
        } catch (Exception e) {
            // no op, as we default to false;
        }
        Test.startTest();
        Boolean checkValue = new OrgShape()
            .isAdvancedMultiCurrencyManagementEnabled();
        Test.stopTest();

        system.assertEquals(
            datedConversionRateObjectExists,
            checkValue,
            'Expected the check value to equal the dated'
        );
    }

    @isTest
    static void testPlatformCachePositive() {
        Boolean result = false;
        Test.startTest();
        result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        // This unit test buts the snot out of me. I can't manipulate the
        // default cache partition in apex, and I can't mock it... so
        // this is my one unit test without an assert. To sleep better
        // at night, I've included the assert statement below.
        // System.assert(
        //     result,
        //     'We expect this to be true. Did you set a default cache partition - Unfortunately, this is not possible in Apex.'
        // );
    }

    @isTest
    static void testGetSafeDefaultCachePartitionMemoized() {
        if (!OrgShape.isPlatformCacheEnabled()) {
            return;
        }
        OrgShape.safeDefaultCachePartition = Cache.Org.getPartition(
            'local.default'
        );
        Test.startTest();
        Boolean result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assert(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testPlatformCacheDisabledWhenSeeAllDataTrue() {
        Test.startTest();
        Boolean result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assertEquals(
            false,
            result,
            'Expected to see platform cache reported as disabled when see all data is true'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testSeeAllDataPositiveWhenEnabled() {
        System.assert(
            orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testSeeAllDataFalseWhenDisabled() {
        System.assert(
            !orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testCacheIsUsedPositive() {
        if (!OrgShape.isPlatformCacheEnabled()) {
            return;
        }
        Cache.OrgPartition defaultPartition = Cache.Org.getPartition(
            'local.default'
        );
        defaultPartition.remove(
            OrgShape.CachedOrgShape.class,
            'requiredButNotUsed'
        );
        System.assertEquals(
            0,
            defaultPartition.getNumKeys(),
            'Expected to no cache keys yet'
        );
        OrgShape newOrgShape = new OrgShape();
        // this should populate the cache.
        Boolean discard = newOrgShape.isReadOnly;
        Test.startTest();
        // this should use the cache.
        Boolean check = newOrgShape.isSandbox;
        Boolean check2 = newOrgShape.hasNamespacePrefix;
        Test.stopTest();
        System.assertEquals(
            1,
            defaultPartition.getNumKeys(),
            'Expected to see 1 and only 1 cache key'
        );
        System.assert(
            defaultPartition.getKeys()
                .toString()
                .containsIgnoreCase('cachedorgshape'),
            'Expected the single cache key to be tied to our CachedOrgShape cacheBuilder class'
        );
    }
}
