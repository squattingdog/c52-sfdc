public with sharing class Settings {
	private static Settings instance;
	private static Boolean allowConstruct = false;
	
	/*
	 * Constructor
	*/
	public Settings(){
		if(!allowConstruct)
			throw new SingletonException(Settings.class);
	}
	
	/*
	 * Description:
	 *	static accessor of the settings
	 * Returns:
	 *	Settings instance
	*/
	public static Settings getInstance() {
		if(instance == null) {
			allowConstruct = true;
			instance = new Settings();
			allowConstruct = false;
		}
		
		return instance;
	}
	
	/*
	* Description:
	*	Allows a mock instance to be set by unit tests.
	*/
	@TestVisible
	private static void setMock(Settings i){
		instance = i;
	}

	/*
	* Descriptoin:
	*	Gets the mongo service URL
	* Returns:
	*	String - the base url.
	*/
	public String getMongoUrl() {
		C52_MongoSettings__c mongoSettings = this.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.BaseUrl__c;
	}
	
	/*
	 * Description:
	 *	Gets the monogo Database name
	 * Returns:
	 *	String - the database name
	*/
	public String getMongoDBName() {
		C52_MongoSettings__c mongoSettings = this.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.Database__c;
	}
	
	/*
	 * Description:
	 *	Gets the mongo token type
	 * Returns:
	 *	String - the token type
	*/
	public String getMongoTokenType() {
		C52_MongoSettings__c mongoSettings = this.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.TokenType__c;
	}
	
	/*
	 * Description:
	 *	Gets the mongo token
	 * Returns:
	 *	String - the mongo token
	*/
	public String getMongoToken() {
		C52_MongoSettings__c mongoSettings = this.getMongoSettingsValues();
		return mongoSettings == null ? null : mongoSettings.Token__c;
	}
	
	/*
	 * Description:
	 *	gets the MongoSettings by name
	 * Returns:
	 *	C52_MongoSettings__c - the settings record.
	*/
	private C52_MongoSettings__c getMongoSettingsValues() {
		return C52_MongoSettings__c.GetValues(Constants.MONGO_SETTINGS_NAME);
	}
}
