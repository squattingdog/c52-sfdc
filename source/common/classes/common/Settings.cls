public with sharing class Settings {
	/*
	 * Description:
	 *	Gets the monogo Database name
	 * Returns:
	 *	String - the database name
	*/
	public static String getMongoDBName() {
		C52_MongoSettings__c mongoSettings = Settings.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.Database__c;
	}
	
	public static String getMongoTokenType() {
		C52_MongoSettings__c mongoSettings = Settings.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.TokenType__c;
	}
	
	public static String getMongoToken() {
		C52_MongoSettings__c mongoSettings = Settings.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.Token__c;
	}
	
	/*
	 * Description:
	 *	gets the MongoSettings by name
	 * Returns:
	 *	C52_MongoSettings__c - the settings record.
	*/
	private static C52_MongoSettings__c getMongoSettingsValues() {
		return C52_MongoSettings__c.GetValues(Constants.MONGO_SETTINGS_NAME);
	}
}
