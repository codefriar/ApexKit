/**
 * @group Trigger Framework
 */
@isTest
private class MetadataTriggerFrameworkTests {
	@isTest
	static void testMetadataTriggerFrameworkNoOppWithoutRecordsPositive() {
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

		System.assertEquals(
			null,
			mdtHandler.activeHandler,
			'Expected the activeHandler Property to be null, as no handlers were returned.'
		);
	}

	@isTest
	static void testExecutesBeforeInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before insert'
		);
	}

	@isTest
	static void testExecutesBeforeUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before update'
		);
	}

	@isTest
	static void testExecutesBeforeDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'before delete'
		);
	}

	@isTest
	static void testExecutesAfterInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after insert'
		);
	}

	@isTest
	static void testExecutesAfterUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after update'
		);
	}

	@isTest
	static void testExecutesAfterDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive(
			'after delete'
		);
	}

	@isTest
	static void testExecutesAfterUndeletePositive() {
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

		System.assert(
			Polyfills.classNameFromInstance(mdtHandler.activeHandler)
				.containsIgnoreCase('sampleHandler'),
			'Expected the activeHandler Property to be \'SampleHandler\'.'
		);
	}
}