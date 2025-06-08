/**
 * @description A factory class for generating Users during Unit Tests
 * While this class has generic user-building methods, the bulk of this
 * class is dedicated to building persona-specific users
 */
@IsTest
public class UserFactory {
	/// Persona based factory methods

	/**
	 * @description    Creates a user with the Minimum Access Profile
	 * @param forceInsert Should this code insert the user?
	 * @return        `User`
	 */
	public static User createMinAccessPersonaUser(Boolean forceInsert) {
		return createTestUser(
			UserFactoryHelper.fetchProfileIdByName('Minimum Access - Salesforce'),
			forceInsert
		);
	}

	/**
	 * @description creates a Marketing Persona user
	 * @param forceInsert Boolean should this user be inserted?
	 * @return User created marketing user
	 */
	public static User createMarketingPersonaUser(Boolean forceInsert) {
		User createdUser = createTestUser('Marketing User', forceInsert);
		return createdUser;
	}

	/// Generic user factory methods

	/**
	 * @description     creates a test user. Useful for permissions testing
	 * @param profileId Profile Id to use when creating a user.
	 * @param forceInsert  Boolean, should this code insert the user?
	 * @return          `User`
	 */
	public static User createTestUser(Id profileId, Boolean forceInsert) {
		User userToCreate = new User(
			ProfileId = profileId,
			LastName = 'last',
			Email = 'Testuser@test.example.com',
			Username = 'Testuser@test.example.com' +
				Math.abs(Crypto.getRandomInteger()),
			CompanyName = 'TEST',
			Title = 'title',
			Alias = 'alias',
			TimeZoneSidKey = 'America/Los_Angeles',
			EmailEncodingKey = 'UTF-8',
			LanguageLocaleKey = 'en_US',
			LocaleSidKey = 'en_US'
		);
		UserFactoryHelper.forceInsert(userToCreate, forceInsert);
		return userToCreate;
	}

	/**
	 * @description       Creates a test user with a given profile.
	 * @param profileName Name of the profile to create the user with.
	 * @param forceInsert    Should this code insert the created user?
	 * @return           `User`
	 */
	public static User createTestUser(String profileName, Boolean forceInsert) {
		return createTestUser(
			UserFactoryHelper.fetchProfileIdByName(profileName),
			forceInsert
		);
	}
}
