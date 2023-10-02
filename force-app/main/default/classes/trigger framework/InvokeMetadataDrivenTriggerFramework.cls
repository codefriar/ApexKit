/**
 * @description class exists to allow the Metadata Trigger Framework to be invoked from a Flow
 */
public with sharing class InvokeMetadataDrivenTriggerFramework {
	/**
	 * @description An internal class representing the inputs to the Metadata Trigger Framework
	 */
	public class Inputs {
		@InvocableVariable(
			Label='Invocation Context'
			Description='Set this to the invocation context of the current flow. ie: after update'
			Required=true
		)
		public TriggerOperation context;

		@InvocableVariable(
			Label='Trigger New'
			Description='New version of the Record(s) to process by Metadata Trigger Framework'
			Required=true
		)
		public List<SObject> triggerNew;

		@InvocableVariable(
			Label='Trigger Old'
			Description='Old version of the Record(s) to process by Metadata Trigger Framework'
			Required=true
		)
		public List<SObject> triggerOld;
	}

	/**
	 * @description Invokes the Metadata Trigger Framework
	 *
	 * @param inputParams List<Inputs> - List of inputs to pass to the Metadata Trigger Framework
	 */
	@InvocableMethod(
		Label='Fire Metadata Defined Triggers'
		Description='Apply existing metadata defined triggers to these records'
	)
	public static void invokeMetadataTriggerFramework(
		List<Inputs> inputParams
	) {
		for (
			InvokeMetadataDrivenTriggerFramework.Inputs request : inputParams
		) {
			new MetadataTriggerFramework(
					request.triggerNew,
					request.triggerOld,
					request.context
				)
				.run();
		}
	}
}
