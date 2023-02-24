@SuppressWarnings('PMD.EmptyStatementBlock')
@isTest
/**
 * @description This class is a sample trigger handler for use while testing
 * the metadataTriggerHandler. Because custom metadata cannot be inserted, and
 * because the MetadataTriggerHandler instantiates handler classes from custom
 * metadata records, even when we stub/mock the metadata record retrieval we
 * still need an actual class that it can instantiate.
 *
 * Note, this class is annotated with @isTest to prevent its use outside of
 * tests, not because it contains tests.
 */
public without sharing class SampleHandler extends TriggerFramework {
	public override void beforeInsert() {
	}
	public override void beforeUpdate() {
	}
	public override void afterInsert() {
	}
	public override void afterUpdate() {
	}
	public override void beforeDelete() {
	}
	public override void afterDelete() {
	}
	public override void afterUndelete() {
	}
}