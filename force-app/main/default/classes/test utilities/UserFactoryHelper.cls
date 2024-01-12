/**
 * @description Helper class for the UserFactory class.
 * Responsible for manipulation of users and permissions
 */

@IsTest
public class UserFactoryHelper {
	public static Id fetchProfileIdByName(String profileName) {
		Profile requestedProfile = [
			SELECT Id
			FROM Profile
			WHERE Name = :profileName
			WITH SYSTEM_MODE
			LIMIT 1
		];
		return requestedProfile.Id;
	}

	public static Id fetchPermissionSetIdByName(String permissionSetName) {
		Id permSetId = [
			SELECT Id
			FROM PermissionSet
			WHERE Name = :permissionSetName
			WITH SYSTEM_MODE
			LIMIT 1
		]
		.Id;
		return permSetId;
	}

	public static void forceInsert(User userToInsert, Boolean forceInsert) {
		if (forceInsert) {
			insert userToInsert;
		}
	}
}
