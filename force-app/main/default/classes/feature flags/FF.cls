/**
 * @description Convenience class for checking feature flags. This is purely Syntactic sugar.
 */
public with sharing class FF {
	/**
	 * @description Convenience method for checking if a feature is enabled.
	 *
	 * @param featureName String feature name to check
	 *
	 * @return True if the feature is enabled by any of the following: Universally enabled, or enabled for the current
	 * user based on permission set, custom permission or time.
	 */
	public static Boolean isEnabled(String featureName) {
		return new FeatureFlag().isEnabled(featureName);
	}

	/**
	 * @description logical inverse of the isEnabled method.
	 *
	 * @param featureName String feature name to check
	 *
	 * @return Boolean, returns inverse of isEnabled.
	 */
	public static Boolean isNotEnabled(String featureName) {
		return !isEnabled(featureName);
	}

	/**
	 * @description Law of diminishing returns here. This isn't tested, per-say. It's underlying FeatureFlag
	 * implementation *is* tested, however.
	 *
	 * @param featureName String the feature name to check
	 *
	 * @return String the value stored in custom metadata for this feature flag.
	 */
	public static String value(String featureName) {
		return new FeatureFlag().value(featureName);
	}
}
