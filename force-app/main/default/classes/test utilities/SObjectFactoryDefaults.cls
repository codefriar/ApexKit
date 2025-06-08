@IsTest
public class SObjectFactoryDefaults {
	// To specify defaults for objects, use the naming convention [ObjectName]Defaults.
	// For custom objects, omit the __c from the Object Name

	/**
	 * @description Default values for Account object
	 */
	public class AccountDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Returns a map of field defaults for the Account object.
		 *
		 * @return A map containing the default values for specific Account fields.
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
				Account.Name => 'Test Account'
			};
		}
	}

	/**
	 * @description This class provides default field values for Contact objects.
	 */
	public class ContactDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Returns a map of field defaults for the Contact object.
		 *
		 * @return A map where keys are Schema.SObjectField representing Contact fields and values are the default values for those fields.
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
				Contact.FirstName => 'First',
				Contact.LastName => 'Last'
			};
		}
	}

	/**
	 * @description This class provides default field values for Opportunity objects.
	 */
	public class OpportunityDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Returns a map of default field values for Opportunity.
		 *
		 * @return Map<Schema.SObjectField, Object> A map containing default field values.
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
	 * @description Defaults for Case SObjectFactory
	 */
	public class CaseDefaults implements SObjectFactory.FieldDefaults {
		/**
		 * @description Returns a map of field defaults for the Case object.
		 *
		 * @return A map where the key is the Schema.SObjectField and the value is the default value.
		 */
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
				Case.Subject => 'Test Case'
			};
		}
	}
}
