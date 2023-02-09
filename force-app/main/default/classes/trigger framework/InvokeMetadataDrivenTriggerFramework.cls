public with sharing class InvokeMetadataDrivenTriggerFramework {
	public class inputs {
		@InvocableVariable(
			label='Invocation Context'
			description='Set this to the invocation context of the current flow. ie: after update'
			required=true
		)
		public TriggerOperation context;

		@InvocableVariable(
			label='Trigger New'
			description='New version of the Record(s) to process by Metadata Trigger Framework'
			required=true
		)
		public List<SObject> triggerNew;

		@InvocableVariable(
			label='Trigger Old'
			description='Old version of the Record(s) to process by Metadata Trigger Framework'
			required=true
		)
		public List<SObject> triggerOld;
	}

	@InvocableMethod(
		label='Fire Metadata Defined Triggers'
		description='Apply existing metadata defined triggers to these records'
	)
	public static void invokeMetadataTriggerFramework(
		List<inputs> inputParams
	) {
		for (
			InvokeMetadataDrivenTriggerFramework.inputs request : inputParams
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