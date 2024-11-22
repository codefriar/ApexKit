/**
 * @description Helper class for the UserFactory class.
 * Responsible for manipulation of users and permissions
 */

@IsTest
public class UserFactoryHelper {
	/**
	 * @description Helper method to find a profile by name.
	 * @param profileName String name of the profile to find
	 *
	 * @return Id of the profile, if found.
	 */
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

	/**
	 * @description helper to find permission set Id's by their name
	 * @param permissionSetName String name of the permission set to find
	 *
	 * @return Id the id of the permission set, if found
	 */
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

	/**
	 * @description A helper method to extract DML from the UserFactory class. This inserts the user, if requested.
	 * Note, this should likely belong in a UserRepository class, but ... it'd likely be the only method in it so for
	 * now here it stays
	 * @param userToInsert User the user to insert
	 * @param forceInsert Boolean if true, does an insert.
	 */
	public static void forceInsert(User userToInsert, Boolean forceInsert) {
		if (forceInsert) {
			insert userToInsert;
		}
	}
}
