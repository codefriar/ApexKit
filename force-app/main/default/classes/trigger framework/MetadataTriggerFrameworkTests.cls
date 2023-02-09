@isTest
private class MetadataTriggerFrameworkTests {
	@isTest
	private static void testMetadataTriggerFrameworkNoOppWithoutRecordsPositive() {
		MetadataTriggerQueryService metadataTriggerQueryServiceStub = (MetadataTriggerQueryService) new Stub.Builder(
				MetadataTriggerQueryService.class
			)
			.mockingMethodCall('getMetadataTriggers')
			.withParameterTypes()
			.returning(new List<Metadata_Driven_Trigger__mdt>())
			.defineStub(true);

		MetadataTriggerFramework mdtHandler = new MetadataTriggerFramework(
			metadataTriggerQueryServiceStub
		);

		mdtHandler.triggerContext.setTriggerContext('after update', true);

		Test.startTest();
		mdtHandler.run();
		Test.stopTest();

		Assert.areEqual(
			null,
			mdtHandler.activeHandler,
			'Expected the activeHandler Property to be null, as no handlers were returned.'
		);
	}

	@isTest
	private static void testExecutesBeforeInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before insert'
		);
	}

	@isTest
	private static void testExecutesBeforeUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before update'
		);
	}

	@isTest
	private static void testExecutesBeforeDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before delete'
		);
	}

	@isTest
	private static void testExecutesAfterInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after insert'
		);
	}

	@isTest
	private static void testExecutesAfterUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after update'
		);
	}

	@isTest
	private static void testExecutesAfterDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after delete'
		);
	}

	@isTest
	private static void testExecutesAfterUndeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after undelete'
		);
	}

	private static void exerciseTriggerHandlerPositive(String context) {
		Metadata_Driven_Trigger__mdt sampleHandler = new Metadata_Driven_Trigger__mdt();
		sampleHandler.class__c = 'sampleHandler';
		sampleHandler.enabled__c = true;
		sampleHandler.execution_Order__c = 1;
		sampleHandler.object__c = 'contact';

		MetadataTriggerQueryService metadataTriggerQueryServiceStub = (MetadataTriggerQueryService) new Stub.Builder(
				MetadataTriggerQueryService.class
			)
			.mockingMethodCall('getMetadataTriggers')
			.withParameterTypes()
			.returning(new List<Metadata_Driven_Trigger__mdt>{ sampleHandler })
			.defineStub(true);

		MetadataTriggerFramework mdtHandler = new MetadataTriggerFramework(
			metadataTriggerQueryServiceStub
		);

		mdtHandler.triggerContext.setTriggerContext(context, true);

		Test.startTest();
		mdtHandler.run();
		Test.stopTest();

		Assert.isTrue(
			Polyfills.classNameFromInstance(mdtHandler.activeHandler)
				.containsIgnoreCase('sampleHandler'),
			'Expected the activeHandler Property to be \'SampleHandler\'.'
		);
	}
}