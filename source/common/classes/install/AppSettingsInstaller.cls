public with sharing class AppSettingsInstaller implements IInstallable {
	public void install(InstallContext context) {
		if(context == null || context.previousVersion() == null) {
			initialInstall(null);
		}
	}
	
	public void initialInstall(String username) {
		Savepoint savepoint;
		
		try {
			savepoint = Database.setSavepoint();
			C52_MongoSettings__c mongoSettings;
			
			if(username == null || username == '') {
				mongoSettings = new C52_MongoSettings__c(
					Name = Constants.MONGO_SETTINGS_NAME,
					Database__c = 'heroku_w830mlvd'
				);
			}
			
			insert mongoSettings;
			
		} catch(Exception ex) {
			Database.rollback(savepoint);
			throw ex;
		}
	}
}