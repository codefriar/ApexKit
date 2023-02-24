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
	 * Law of diminishing returns here.
	 * This isn't tested, per-say. It's underlying FeatureFlag
	 * implementation *is* tested, however.
	 */
	public static String value(string featureName) {
		return new FeatureFlag().value(featureName);
	}
}