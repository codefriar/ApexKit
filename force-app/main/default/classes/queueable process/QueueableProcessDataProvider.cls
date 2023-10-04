/**
 * @description A class that separates concerns between the QueueableProcessManager and doing data lookup/access.
 * This helps us mock the data access in our unit tests.
 */
public with sharing class QueueableProcessDataProvider {
	@SuppressWarnings('PMD.EmptyStatementBlock')
	/**
	 * @description default constructor. Necessary for dynamic instantiation.
	 */
	public QueueableProcessDataProvider() {
	}

	/**
	 * @description This is the main method that will be called by the QueueableProcessManager. By extracting this
	 * method into a separate class, we can easily mock it in our unit tests.
	 *
	 * @param jobId Id The Id of the AsyncApexJob record that is being processed.
	 *
	 * @return String The name of the Apex class that just failed.
	 */
	public String getClassName(Id jobId) {
		return [
			SELECT ApexClass.Name
			FROM AsyncApexJob
			WHERE Id = :jobId
			WITH SYSTEM_MODE
		]
		.ApexClass.Name;
	}
}
