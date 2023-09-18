/**
 * @description This class is used to demonstrate the usage of ApexKit's Feature Flags library.
 *
 * @overview Feature flags allow developers and operations teams to gate functionality and logic behind
 * a Custom Metadata type that can be toggled at runtime without deploying new code. Because they're custom metadata
 * type records, you can also pre-configure them in your sandboxes and scratch orgs to enable/disable features then
 * deploy those records to production when you're ready to go live.
 *
 * There are 4 basic ways to use feature flags:
 * - Check if a feature is enabled universally.
 * - Check if a feature is enabled for a specific user.
 *  - This library additionally allows you to determine if a feature is enabled for the running user via
 *  - a permission set, or a custom permission.
 * - Check if a feature is enabled on or after Date.today().
 * - Get the value of a given feature flag. Ie, not just on/off but you can set the value to '33' or 'blue'.
 *
 * These examples are somewhat contrived, in an effort to vision-cast what's possible.
 *
 * @see FF, FeatureFlag, FeatureFlagDataProvider
 *
 * Note: FeatureFlags are written as instance methods, but with a companion static class named FF. Thus
 * new FeatureFlag().isEnabled('some name') is equivalent to FF.isEnabled('some name').
 */

public with sharing class FeatureFlagUsageExamples {
	/**
	 * @description This method demonstrates how to check if a feature is enabled universally.
	 * it's implemented as a portion of a larger AccountService method that returns a list of accounts.
	 * If the feature flag is enabled, the method will return a list of accounts that have a billing address.
	 * If not enabled, the method will return a list of accounts that have a shipping address.
	 *
	 * @return List<Account> - A list of accounts.
	 *
	 * Note: FeatureFlags are written with a minimalist api. The .isEnabled() method automatically determines if the
	 * feature is enabled universally, on or after today, or for the running user via a permission set or custom permission.
	 */
	public static List<Account> getAccounts() {
		List<Account> accounts = new List<Account>();
		// Check if the feature flag is enabled.
		if (FF.isEnabled('EnableBillingAddress')) {
			accounts = [SELECT Id, Name, BillingAddress FROM Account];
		} else {
			accounts = [SELECT Id, Name, ShippingAddress FROM Account];
		}
		return accounts;
	}

	/**
	 * @description This method demonstrates how to check if a feature is disabled
	 *
	 * @return List<Account> - A list of accounts.
	 */
	public static List<Account> getAccountsIfDisabled() {
		List<Account> accounts = new List<Account>();
		// Check if the feature flag is enabled.
		if (FF.isNotEnabled('EnableBillingAddress')) {
			accounts = [SELECT Id, Name, BillingAddress FROM Account];
		} else {
			accounts = [SELECT Id, Name, ShippingAddress FROM Account];
		}
		return accounts;
	}

	/**
	 * @description this method demonstrates how to use the .value() method of the FeatureFlag library.
	 * In this particular example, it's used to set a custom scope value from metadata before executing a query.
	 *
	 * @return List<Account> - A list of accounts.
	 */
	public static List<Account> getAccountsMatchingFeatureFlagValue() {
		List<Account> accounts = [
			SELECT Id, Name, BillingAddress
			FROM Account
			WHERE BillingState = :FF.value('BillingState')
		];
		return accounts;
	}
}
