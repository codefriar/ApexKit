public with sharing class UniversalBulkInvocable {
	/**
	 * @description This method is what will be displayed in the flow builder. This method can correctly handle bulk
	 * invocations, even across multiple classes and methods, returning all outputs in the same order as the inputs.
	 * @param inputs List<UniversalFlowInputOutput> input objects. The first object in the list will be used.
	 *
	 * @return List<UniversalFlowInputOutput> output objects. Every input receives one output, even if
	 * non-fatal exceptions are encountered.
	 */
	@InvocableMethod(Label='Bulk Universal Invocable' Description='Bulk Universal Invocable')
	public static List<List<UniversalFlowInputOutput>> invoke(List<List<UniversalFlowInputOutput>> inputs) {
		return new Invocable.Processor(inputs).executeBulk();
	}
}
