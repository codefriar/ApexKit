public with sharing class QueueableProcessDataProvider {
	@SuppressWarnings('PMD.EmptyStatementBlock')
	public QueueableProcessDataProvider() {
	}
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
