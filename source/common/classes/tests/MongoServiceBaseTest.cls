@isTest
public class MongoServiceBaseTest {
	static testMethod void testGetC52MongoClients() {

		Test.startTest();
		// Given
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		Settings mockSettings = (Settings)mocks.mock(Settings.class);
		Settings mockSettings = Settings.getInstance();
		mockSettings.setMock(mockSettings);
		mocks.startStubbing();
		mocks.
		
		// When
		ffHttp_C52Mongo client = MongoServiceBase.getC52MongoClient();
		
		// Then
		System.assert(client != null);

		Test.stopTest();
	}
}
