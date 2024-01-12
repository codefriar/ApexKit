@IsTest
public class SObjectFactoryDefaults {
	// To specify defaults for objects, use the naming convention [ObjectName]Defaults.
	// For custom objects, omit the __c from the Object Name

	public class AccountDefaults implements SObjectFactory.FieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Account.Name => 'Test Account' };
		}
	}

	public class ContactDefaults implements SObjectFactory.FieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Contact.FirstName => 'First', Contact.LastName => 'Last' };
		}
	}

	public class OpportunityDefaults implements SObjectFactory.FieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
				Opportunity.Name => 'Test Opportunity',
				Opportunity.StageName => 'Closed Won',
				Opportunity.CloseDate => System.today()
			};
		}
	}

	public class CaseDefaults implements SObjectFactory.FieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{ Case.Subject => 'Test Case' };
		}
	}
}
