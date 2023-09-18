/**
 * @description Convenience class for checking feature flags
 */
public with sharing class FF {
	public static Boolean isEnabled(String featureName) {
		return new FeatureFlag().isEnabled(featureName);
	}

	public static Boolean isNotEnabled(String featureName) {
		return !isEnabled(featureName);
	}

	/**
	 * @description Law of diminishing returns here.
	 * This isn't tested, per-say. It's underlying FeatureFlag
	 * implementation *is* tested, however.
	 *
	 * @param featureName String name of the feature flag
	 *
	 * @return String value of the feature flag
	 */
	public static String value(String featureName) {
		return new FeatureFlag().value(featureName);
	}
}
