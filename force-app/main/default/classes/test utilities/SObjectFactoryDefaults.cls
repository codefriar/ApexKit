/**
 * @description class exists as a namespace for 'org-wide' default values on common SObjects.
 * Each inner class represents one type of SObject and implements the SObjectFactory.FieldDefaults interface.
 * That interface dictates a map of SOBjectField => Object. SObjectFactory will apply these org-wide defaults
 * as it constructs your test object(s)
 */
@IsTest
public class SObjectFactoryDefaults {
	// To specify defaults for objects, use the naming convention [ObjectName]Defaults.
	// For custom objects, omit the __c from the Object Name

	/**
	 * @description org-wide account defaults.
	 */
	public class AccountDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Interface required method returning default values for fields
		 * @return Map<Schema.SObjectField, Object> map of fields and default values
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Account.Name => 'Test Account' };
		}
	}

	/**
	 * @description org-wide contact defaults
	 */
	public class ContactDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Interface required method returning default values for fields
		 * @return Map<Schema.SObjectField, Object> map of fields and default values
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Contact.FirstName => 'First', Contact.LastName => 'Last' };
		}
	}

	/**
	 * @description org-wide opportunity defaults
	 */
	public class OpportunityDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Interface required method returning default values for fields
		 * @return Map<Schema.SObjectField, Object> map of fields and default values
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
				Opportunity.Name => 'Test Opportunity',
				Opportunity.StageName => 'Closed Won',
				Opportunity.CloseDate => System.today()
			};
		}
	}

	/**
	 * @description org-wide case default values
	 */
	public class CaseDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Interface required method returning default values for fields
		 * @return Map<Schema.SObjectField, Object> map of fields and default values
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Case.Subject => 'Test Case' };
		}
	}
}
