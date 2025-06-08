/**
 * @description Helper class for the UserFactory class.
 * Responsible for manipulation of users and permissions
 *
 * Note: This class does *no* error handling. Because it's used in the setup and preparation of test data,
 * it's on the developer to ensure the methods are called with existing, valid data like profile names.
 * If, for instance, a developer fat-fingers a profile name, the query on ~ line 20 will fail, and throw
 * an exception.
 */

@IsTest
public class UserFactoryHelper {
	/**
	 * @description Fetches the Profile Id by its name.
	 * @param profileName The name of the profile to fetch.
	 *
	 * @return The Id of the requested profile.
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
	 * @description Fetches the Permission Set ID by its name.
	 * @param permissionSetName The name of the Permission Set to fetch.
	 *
	 * @return The ID of the Permission Set.
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
	 * @description Inserts a User record if forceInsert is true.
	 * @param userToInsert The User record to insert.
	 * @param forceInsert Boolean flag to determine if the insert should proceed.
	 */
	public static void forceInsert(User userToInsert, Boolean forceInsert) {
		if (forceInsert) {
			insert userToInsert;
		}
	}
}
