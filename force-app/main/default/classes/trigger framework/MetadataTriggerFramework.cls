/**
 * @description A metadata driven extension of the TriggerFramework class
 */
public with sharing class MetadataTriggerFramework extends TriggerFramework {
	@TestVisible
	private MetadataTriggerQueryService mts;

	@TestVisible
	private List<Metadata_Driven_Trigger__mdt> triggers;

	@TestVisible
	private TriggerFramework activeHandler;

	protected List<SObject> triggerNew;
	protected List<SObject> triggerOld;

	/**
	 * @description Constructor used by live triggers.
	 * Because this constructor makes live-use of a
	 * metadata query service that will query live metadata
	 * these two constructors are effectively un-testable without
	 * requiring you to insert custom metadata.
	 */
	public MetadataTriggerFramework() {
		this.mts = new MetadataTriggerQueryService(
			MetadataTriggerQueryService.getSObjectType(triggerNew, triggerOld)
		);
	}

	/**
	 * @description Constructor used by Apex Triggers
	 *
	 * @param triggerNew List<SOBject> the new version of the records
	 * @param triggerOld List<SOBject> the old version of the records
	 * @param context TriggerOperation the context of the trigger ie: after update
	 */
	public MetadataTriggerFramework(
		List<SObject> triggerNew,
		List<SObject> triggerOld,
		TriggerOperation context
	) {
		this.triggerNew = triggerNew;
		this.triggerOld = triggerOld;
		this.triggerContext.context = context;
		this.mts = new MetadataTriggerQueryService(
			MetadataTriggerQueryService.getSObjectType(triggerNew, triggerOld)
		);
	}

	/**
	 * @description Constructor used by unit tests
	 *
	 * @param mts MetadataTriggerQueryService a potentially mocked version of the query service
	 */
	@TestVisible
	private MetadataTriggerFramework(MetadataTriggerQueryService mts) {
		this.mts = mts;
	}

	/**
	 * @description Overrides the standard Run() method, which allows this
	 * metadata based trigger handler can be an incremental update / sit beside
	 * other trigger handlers classes that are directly invoked by a trigger
	 */
	@SuppressWarnings('PMD.ApexCRUDViolation')
	override public void run() {
		if (standardValidationFails()) {
			return;
		}
		this.triggers = this.mts.getMetadataTriggers();

		/**
		 * @description This loop is responsible for instantiating the trigger
		 * handler classes identified by the query above, and then calling the
		 * proper context methods.
		 */
		for (Metadata_Driven_Trigger__mdt currentTrigger : triggers) {
			try {
				activeHandler = (TriggerFramework) Type.forName(
						currentTrigger.Class__c
					)
					.newInstance();
			} catch (Exception e) {
				continue;
			}
			dispatch(activeHandler);
		}
	}

	/**
	 * @description method is responsible for calling delegated class methods on metadata specified classes.
	 *
	 * @param activeHandler An instance of a class to have the appropriate method called on it. This class must
	 * implement the TriggerFramework interface.
	 */
	private void dispatch(TriggerFramework activeHandler) {
		switch on this.triggerContext.context {
			when BEFORE_INSERT {
				activeHandler.beforeInsert();
			}
			when BEFORE_UPDATE {
				activeHandler.beforeUpdate();
			}
			when AFTER_INSERT {
				activeHandler.afterInsert();
			}
			when AFTER_UPDATE {
				activeHandler.afterUpdate();
			}
			when BEFORE_DELETE {
				activeHandler.beforeDelete();
			}
			when AFTER_DELETE {
				activeHandler.afterDelete();
			}
			when AFTER_UNDELETE {
				activeHandler.afterUndelete();
			}
		}
	}
}
