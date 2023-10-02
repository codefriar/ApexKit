//@IsTest
/**
 * @description A factory class for generating bogus Ids for testing purposes.
 */
public with sharing class IdFactory {
	/**
	 * @description This property gives us an authentic ID for this org which we can use to grab the Instance ID
	 * according to the latest release notes:
	 * What constitutes a valid Salesforce Object ID is being redefined as Salesforce expands out the instance ID
	 * (also known as a pod identifier or server ID). The 4th, 5th, and 6th characters would be used for server ID.
	 * The 7th character still remains reserved. Any coded assumptions about the structure of a valid or invalid ID
	 * should be reevaluated going forward. Note: Existing Apex functionality around IDs will transition to the new
	 * format.
	 */
	private static final String SERVER_ID = UserInfo.getUserId()
		.left(7)
		.right(4);

	/**
	 * @description There are certain types of objects that do not return a prefix. This map contains string keys that
	 * map to known values for these 'unstable' types. This map is used to identify the correct prefix when a developer
	 * requests an Id for an unstable type.
	 *
	 * This is likely an incomplete list. If you find an unstable type that is not in this list, please add it, and
	 * submit a PR.
	 * Daniel Bollinger has a great blog post useful for filling in the gaps when an object doesn't return a prefix.
	 * http://www.fishofprey.com/2011/09/obscure-salesforce-object-key-prefixes.html
	 */
	private static final Map<String, String> UNSTABLE_TYPE_PREFIX_OVERRIDES = new Map<String, String>{
		'OpportunityHistory' => '008',
		'OtherHistory' => '017',
		'SharingRule' => '02c'
	};

	/**
	 * @description Integer to be appended to the end of the Id. Incremented each time a new Id is generated.
	 */
	private static Integer idiosyncrasy = 0;

	/**
	 * @description Integer representing the length of the Id. Default is 18.
	 */
	private static final Integer DEFAULT_ID_LENGTH = 18;

	/**
	 * @description this method accepts a String representation of the sObject type and defers to it's sister methods to generate a bogus Id.
	 *
	 * @param objectType String representation of the sObject type ie: Account, Contact, etc.
	 *
	 * @return id a plausible, but bogus Id
	 *
	 * @example `IdFactory.get('Account');`
	 */
	public static Id get(String objectType) {
		String prefix = getUnstableObjectPrefix(objectType);
		if (prefix != null) {
			return getWithPrefixOverride(prefix);
		}
		return get(Type.forName(objectType));
	}

	/**
	 * @description This method accepts a Type object and defers to it's sister methods to generate a bogus Id.
	 *
	 * @param incomingType Type object representing the sObject type ie: Account, Contact, etc.
	 *
	 * @return Id a plausible, but bogus Id
	 *
	 * @example `IdFactory.get(Type.forName('Account'));`
	 */
	public static Id get(Type incomingType) {
		if (incomingType == null) {
			throw new IDFactoryException(
				'The incoming data type was null. Please ensure that you are passing a valid string or Type object to IDFactory.get()'
			);
		}
		return get((SObject) incomingType.newInstance());
	}

	/**
	 * @description This method accepts a generic SObject and defers to it's sister methods to generate a bogus Id.
	 *
	 * @param incomingType SObject representing the sObject type ie: Account, Contact, etc.
	 *
	 * @return Id a plausible, but bogus Id
	 */
	public static Id get(SObject incomingType) {
		return get(incomingType.getSObjectType());
	}

	/**
	 * @description All the other methods in this class defer to this method eventually to generate a bogus Id.
	 *
	 * @param incomingType Schema.SObjectType representing the sObject type ie: Account, Contact, etc.
	 *
	 * @return Id a plausible, but bogus Id
	 */
	public static Id get(Schema.SObjectType incomingType) {
		idiosyncrasy++;
		String prefix = incomingType.getDescribe().getKeyPrefix();
		if (prefix == null) {
			throw new IDFactoryException(
				'The incoming data type did not return a prefix. Certain data types such as *__Share or *History do not return a prefix. Because of this, they\'re not supported by IDFactory'
			);
		}
		prefix += SERVER_ID;
		return getWithPrefixOverride(prefix);
	}

	/**
	 * @description A method for getting a bogus Id for an object that may not return a prefix via standard Schema
	 * methods. This method is used internally by the other methods in this class once a prefix has been identified.
	 *
	 * @param prefix String three character prefix for the object type.
	 *
	 * @return Id a plausible, but bogus Id
	 */
	private static Id getWithPrefixOverride(String prefix) {
		idiosyncrasy++;
		prefix += SERVER_ID;
		Integer padLength =
			DEFAULT_ID_LENGTH -
			prefix.length() -
			String.valueOf(idiosyncrasy).length();
		String bogusId =
			prefix +
			'0'.repeat(padLength) +
			String.valueOf(idiosyncrasy);
		return (Id) bogusId;
	}

	/**
	 * @description Certain types of objects do not return a prefix via standard Schema methods. This method is used
	 * to identify them, and override the prefix with a known value.
	 *
	 * @param objectType String representation of the sObject type ie: Account, Contact, etc.
	 *
	 * @return String three character prefix for the object type.
	 */
	private static String getUnstableObjectPrefix(String objectType) {
		String prefix;
		// we have an unstable type.
		if (objectType == 'OpportunityHistory') {
			prefix = UNSTABLE_TYPE_PREFIX_OVERRIDES.get('OpportunityHistory');
		} else if (objectType.endsWithIgnoreCase('History')) {
			prefix = UNSTABLE_TYPE_PREFIX_OVERRIDES.get('OtherHistory');
		} else if (objectType.endsWithIgnoreCase('__Share')) {
			prefix = UNSTABLE_TYPE_PREFIX_OVERRIDES.get('SharingRule');
		}
		return prefix;
	}

	/**
	 * @description internally thrown exception for when the incoming data type is null or invalid
	 */
	public class IDFactoryException extends Exception {
	}
}
