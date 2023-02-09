public with sharing class MetadataTriggerFramework extends TriggerFramework {
	@testVisible
	private MetadataTriggerQueryService mts;

	@testVisible
	private List<Metadata_Driven_Trigger__mdt> triggers;

	@testVisible
	private TriggerFramework activeHandler;

	protected List<sObject> triggerNew;
	protected List<sObject> triggerOld;

	/**
	 * @description Constructor used by live triggers.
	 * Because this constructor makes live-use of a
	 * metadata query service that will query live metatdata
	 * these two constructors are effectively un-testable without
	 * requiring you to insert custom metadata.
	 */
	public MetadataTriggerFramework() {
		this.mts = new MetadataTriggerQueryService(
			MetadataTriggerQueryService.getSobjectType(triggerNew, triggerOld)
		);
	}

	public MetadataTriggerFramework(
		List<sObject> triggerNew,
		List<sObject> triggerOld,
		TriggerOperation context
	) {
		this.triggerNew = triggerNew;
		this.triggerOld = triggerOld;
		this.triggerContext.context = context;
		this.mts = new MetadataTriggerQueryService(
			MetadataTriggerQueryService.getSobjectType(triggerNew, triggerOld)
		);
	}

	public MetadataTriggerFramework(MetadataTriggerQueryService mts) {
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
						currentTrigger.class__c
					)
					.newInstance();
			} catch (Exception e) {
				continue;
			}
			dispatch(activeHandler);
		}
	}

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