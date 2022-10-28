/**
 * @description Convenience class for checking feature flags
 */
public with sharing class FF {
    public static Boolean isEnabled(String featureName) {
        return new FeatureFlag().isEnabled(featureName);
    }
}
