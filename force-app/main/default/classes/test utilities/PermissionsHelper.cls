/**
 * @description A test-only helper for manipulating users' permissions, permission sets and permission set groups
 */

@IsTest
public class PermissionsHelper {
	/**
	 * @description creates and inserts a permission set assignment record
	 * @param userToAssignTo User the user whom the permission set will be applied to
	 * @param permSetId Id The Id of the permission set to assign to the user.
	 */
	public static void assignPermissionSetToUser(User userToAssignTo, Id permSetId) {
		PermissionSetAssignment permissionSetAssignment = new PermissionSetAssignment(
			AssigneeId = userToAssignTo.Id,
			PermissionSetId = permSetId
		);
		insert permissionSetAssignment;
	}

	/**
	 * @description Assigns a permission set to a given user.
	 * @param userToAssignTo User to assign the permission set to.
	 * @param permSetName String name of the permission set.
	 */
	public static void assignPermSetToUser(User userToAssignTo, String permSetName) {
		assignPermissionSetToUser(userToAssignTo, UserFactoryHelper.fetchPermissionSetIdByName(permSetName));
	}

	/**
	 * @description Generates a test permission set record - no permissions are added to it
	 * @param permSetName String what to call your perm set
	 * @param doInsert Boolean true if you want this to insert your perm set record.
	 * @return PermissionSet the created permission set.
	 */
	public static PermissionSet createPermissionSet(String permSetName, Boolean doInsert) {
		PermissionSet newPermSet = new PermissionSet(Name = permSetName, Label = 'Test Permission Set');
		if (doInsert) {
			insert newPermSet;
		}
		return newPermSet;
	}

	/**
	 * @description Enables a custom permission using a permission set
	 * @param permissionName String name of the custom permission you want created
	 * @param forUserId Id user to assign the custom permission to.
	 */
	public static void enableCustomPermission(String permissionName, Id forUserId) {
		PermissionSet permSet = createPermissionSet('TestPermSet', true);

		Id customPermissionId = [
			SELECT Id
			FROM CustomPermission
			WHERE DeveloperName = :permissionName
			WITH SYSTEM_MODE
			LIMIT 1
		]
		.Id;

		SetupEntityAccess permSetPermission = new SetupEntityAccess(
			ParentId = permSet.Id,
			SetupEntityId = customPermissionId
		);

		PermissionSetAssignment permSetAssignment = new PermissionSetAssignment(
			AssigneeId = forUserId,
			PermissionSetId = permSet.Id
		);

		insert new List<SObject>{ permSetPermission, permSetAssignment };
	}
}
