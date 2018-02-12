@isTest
public class SettingsTest {
	
	/*
	 * Description
	 *	test to validate getMongoDBName
	*/
	static testMethod void testGetMongoDBName() {
		Test.startTest();
		// Given
		C52_MongoSettings__c mongoSettings = ObjectsHelper.getMongoSettings('mongo', 'bigToken', 'myToken');
		insert mongoSettings;
		
		// When
		string dbName = Settings.getInstance().getMongoDBName();
		
		// Then
		System.assertEquals(dbName, 'mongo', 'SettingsTest::testGetMongoDBName, invalid db name');
		
		Test.stopTest();
	}
	
	/*
	 * Description
	 *	test to validate getMongoTokenType
	*/
	static testMethod void testGetMongoTokenType() {
		Test.startTest();
		// Given
		C52_MongoSettings__c mongoSettings = ObjectsHelper.getMongoSettings('mongo', 'bigToken', 'myToken');
		insert mongoSettings;
		
		// When
		string tokenType = Settings.getInstance().getMongoTokenType();
		
		// Then
		System.assertEquals(tokenType, 'bigToken', 'SettingsTest::testGetMongoDBName, invalid tokenType');
		
		Test.stopTest();
	}
	
	/*
	 * Description
	 *	test to validate getMongoToken
	*/
	static testMethod void testgetMongoToken() {
		Test.startTest();
		// Given
		C52_MongoSettings__c mongoSettings = ObjectsHelper.getMongoSettings('mongo', 'bigToken', 'myToken');
		insert mongoSettings;
		
		// When
		string token = Settings.getInstance().getMongoToken();
		
		// Then
		System.assertEquals(token, 'myToken', 'SettingsTest::testGetMongoDBName, invalid token');
		
		Test.stopTest();
	}
	
	/*
	 * Description
	 *	test to validate instantiating the settings object
	*/
	static testMethod void testSettingsConstructor() {
		Test.startTest();
		
		try{
			Settings testSettings = new Settings();		
		} catch(SingletonException sex) {
			System.assertEquals(Settings.class.toString() + ' :: Singleton pattern exception.  Instances of a singleton class ' +
            'must be accessed through the static getInstance() method', sex.getMessage());
		}
		
		Test.stopTest();
	}
}
