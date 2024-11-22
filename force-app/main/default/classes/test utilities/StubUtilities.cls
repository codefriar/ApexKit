@IsTest
public with sharing class StubUtilities {
	/**
	 * @description             Used when you want a MockedMethod to return a set of IDs of a given sObject Type
	 * @param sObjectTypeString Name of type: ie: `Account`
	 * @param size              Number of valid Ids to return
	 * @return                  `List<Id>`
	 */
	public static List<Id> generateSObjectIds(String sObjectTypeString, Integer size) {
		List<Id> ids = new List<Id>();
		for (Integer iterationCounter = 0; iterationCounter < size; iterationCounter++) {
			ids.add(IdFactory.get(sObjectTypeString));
		}

		return ids;
	}
}
