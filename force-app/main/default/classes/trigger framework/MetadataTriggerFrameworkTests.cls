@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class MetadataTriggerFrameworkTests {
	@IsTest
	private static void testMetadataTriggerFrameworkNoOppWithoutRecordsPositive() {
		MetadataTriggerQueryService metadataTriggerQueryServiceStub = (MetadataTriggerQueryService) new StubBuilder(
				MetadataTriggerQueryService.class
			)
			.mockingMethodCall('getMetadataTriggers')
			.withParameterTypes()
			.returning(new List<Metadata_Driven_Trigger__mdt>())
			.defineStub();

		MetadataTriggerFramework mdtHandler = new MetadataTriggerFramework(metadataTriggerQueryServiceStub);

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

	@IsTest
	private static void testExecutesBeforeInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('before insert');
	}

	@IsTest
	private static void testExecutesBeforeUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('before update');
	}

	@IsTest
	private static void testExecutesBeforeDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('before delete');
	}

	@IsTest
	private static void testExecutesAfterInsertPositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('after insert');
	}

	@IsTest
	private static void testExecutesAfterUpdatePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('after update');
	}

	@IsTest
	private static void testExecutesAfterDeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('after delete');
	}

	@IsTest
	private static void testExecutesAfterUndeletePositive() {
		MetadataTriggerFrameworkTests.exerciseTriggerHandlerPositive('after undelete');
	}

	private static void exerciseTriggerHandlerPositive(String context) {
		Metadata_Driven_Trigger__mdt sampleHandler = new Metadata_Driven_Trigger__mdt();
		sampleHandler.Class__c = 'sampleHandler';
		sampleHandler.Enabled__c = true;
		sampleHandler.Execution_Order__c = 1;
		sampleHandler.Object__c = 'contact';

		MetadataTriggerQueryService metadataTriggerQueryServiceStub = (MetadataTriggerQueryService) new StubBuilder(
				MetadataTriggerQueryService.class
			)
			.mockingMethodCall('getMetadataTriggers')
			.withParameterTypes()
			.returning(new List<Metadata_Driven_Trigger__mdt>{ sampleHandler })
			.defineStub();

		MetadataTriggerFramework mdtHandler = new MetadataTriggerFramework(metadataTriggerQueryServiceStub);

		mdtHandler.triggerContext.setTriggerContext(context, true);

		Test.startTest();
		mdtHandler.run();
		Test.stopTest();

		Assert.isTrue(
			Polyfills.classNameFromInstance(mdtHandler.activeHandler).containsIgnoreCase('sampleHandler'),
			'Expected the activeHandler Property to be \'SampleHandler\'.'
		);
	}
}
