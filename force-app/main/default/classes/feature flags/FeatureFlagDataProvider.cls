public with sharing class FeatureFlagDataProvider {
    /**
     * Fetch the feature flags from custom metadata.
     */
    public Map<String, Feature_Flag__mdt> flags;
    public Map<String, Feature_Flag_Enabled_For__mdt> perPermSetOverrides;

    public FeatureFlagDataProvider() {
        this.flags = Feature_Flag__mdt.getAll();
        this.perPermSetOverrides = Feature_Flag_Enabled_For__mdt.getAll();
    }

    @testVisible
    private void overrideFlags(Map<String, Feature_flag__mdt> flags) {
        this.flags = flags;
    }

    @testVisible
    private void overridePerPermSetOverrides(
        Map<String, Feature_Flag_Enabled_For__mdt> perPermSetOverrides
    ) {
        this.perPermSetOverrides = perPermSetOverrides;
    }
}
