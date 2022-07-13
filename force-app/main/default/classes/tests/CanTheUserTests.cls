@IsTest
private class CanTheUserTests {
    // These tests rely on the assumption that standard FLS/CRUD have not been modified
    // by the user, and use the Account Object for verification of the Can Logic.

    private static List<Account> generateAccounts() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            accounts.add(new Account());
        }
        return accounts;
    }

    @IsTest
    static void canCrudAccountCreatePositive() {
        System.assert(
            CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.CREATEABLE),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.CREATEABLE),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @IsTest
    static void canCrudCreateAccountPositive() {
        System.assert(
            CanTheUser.create(generateAccounts()),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
        System.assert(
            CanTheUser.create(new Account()),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
        System.assert(
            CanTheUser.create('Account'),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @IsTest
    static void canCrudAccountReadPositive() {
        System.assert(
            CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.READABLE),
            'Expected to be able to read accounts'
        );
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.READABLE),
            'Expected to be able to read accounts'
        );
    }

    @IsTest
    static void canCrudReadAccountPositive() {
        System.assert(
            CanTheUser.read(generateAccounts()),
            'Expected to be able to read accounts'
        );
        System.assert(
            CanTheUser.read(new Account()),
            'Expected to be able to read accounts'
        );
        System.assert(
            CanTheUser.read('Account'),
            'Expected to be able to read accounts'
        );
    }

    @IsTest
    static void canCrudAccountUpdatePositive() {
        System.assert(
            CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.EDITABLE),
            'Expected to be able to update accounts'
        );
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.EDITABLE),
            'Expected to be able to update accounts'
        );
    }

    @IsTest
    static void canCrudEditAccountPositive() {
        System.assert(
            CanTheUser.edit(generateAccounts()),
            'Expected to be able to update accounts'
        );
        System.assert(
            CanTheUser.edit(new Account()),
            'Expected to be able to update accounts'
        );
        System.assert(
            CanTheUser.edit('Account'),
            'Expected to be able to update accounts'
        );
    }

    @IsTest
    static void canCrudUpsertAccountPositive() {
        System.assert(
            CanTheUser.ups(generateAccounts()),
            'Expected to be able to upsert accounts'
        );
        System.assert(
            CanTheUser.ups(new Account()),
            'Expected to be able to upsert accounts'
        );
        System.assert(
            CanTheUser.ups('Account'),
            'Expected to be able to upsert accounts'
        );
    }

    @IsTest
    static void canCrudAccountDeletePositive() {
        System.assert(
            CanTheUser.crud(generateAccounts(), CanTheUser.CrudType.DELETABLE),
            'Expected to be able to delete accounts'
        );
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.DELETABLE),
            'Expected to be able to delete accounts'
        );
        System.assert(
            CanTheUser.crud('Account', CanTheUser.CrudType.DELETABLE),
            'Expected to be able to delete accounts'
        );
    }

    @IsTest
    static void canCrudDestroyAccountPositive() {
        System.assert(
            CanTheUser.destroy(generateAccounts()),
            'Expected to be able to delete accounts'
        );
        System.assert(
            CanTheUser.destroy(new Account()),
            'Expected to be able to delete accounts'
        );
        System.assert(
            CanTheUser.destroy('Account'),
            'Expected to be able to delete accounts'
        );
    }

    @IsTest
    static void getFLSofAccountNamePositive() {
        System.assert(
            CanTheUser.flsAccessible('Account', 'Name'),
            'Expected the name field to be accesible on Account'
        );
    }

    @IsTest
    static void getFLSofAccountIDNegative() {
        System.assert(
            CanTheUser.flsUpdatable('Account', 'id') == false,
            'Expected that the ID of an object cannot be updated.'
        );
    }

    @IsTest
    static void getBulkFLSAccessibleWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'id' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.assert(
                bulkCheck.get(field),
                'Expected the field ' +
                field +
                ' to be accesible on Account'
            );
        }
    }

    @IsTest
    static void getBulkFLSAccessibleWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );

        System.assert(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.assert(
            !bulkCheck.get('nonExistingField__c'),
            'Expected the nonExistingField__c ' +
            'field not to be accesible on Account'
        );
    }

    @IsTest
    static void getBulkFLSUpdatableWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'ShippingStreet' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.assert(
                bulkCheck.get(field),
                'Expected the field ' +
                field +
                ' to be accesible on Account'
            );
        }
    }

    @IsTest
    static void getBulkFLSUpdatableWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );

        System.assert(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.assert(
            !bulkCheck.get('nonExistingField__c'),
            'Expected the nonExistingField__c ' +
            'field not to be accesible on Account'
        );
    }
}
