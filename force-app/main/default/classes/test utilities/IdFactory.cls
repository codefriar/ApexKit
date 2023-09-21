@IsTest
/**
 * @description A factory class for generating bogus Ids for testing purposes.
 */
public with sharing class IdFactory {
	/**
	 * @description Integer to be appended to the end of the Id. Incremented each time a new Id is generated.
	 */
	private static Integer idiosyncrasy = 0;
	/**
	 * @description Integer representing the length of the Id. Default is 18.
	 */
	private static final Integer defaultIdLength = 18;

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
		Integer padLength =
			defaultIdLength -
			prefix.length() -
			String.valueOf(idiosyncrasy).length();
		String bogusId =
			prefix +
			'0'.repeat(padLength) +
			String.valueOf(idiosyncrasy);
		return (Id) bogusId;
	}
}
