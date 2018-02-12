@isTest
/*
* Helper class to populate objects used in test methods.
*/
public class ObjectsHelper {
	/*
	* helper method to populate a Campaign object
	*/
	public static Campaign getCampaign(string name, Boolean includeWeb, Boolean processed, Campaign parentCampaign, string recordTypeName) {
		Campaign camp = new Campaign();
		camp.Name = name;
		camp.IncludeForWebMobile__c = includeWeb;
		camp.Processed__c = processed;
		camp.Parent = parentCampaign;
		camp.RecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
		
		return camp;
	}
	
	
	/*
	* helper method to populate a GW_Volunteers__Volunteer_Job__c
	*/
	public static GW_Volunteers__Volunteer_Job__c getGWVolunteersVolunteerJob(string name, ID campaignId, Boolean processed, Boolean includeWeb) {
		GW_Volunteers__Volunteer_Job__c gwvvJob = new GW_Volunteers__Volunteer_Job__c();
		gwvvJob.Name = name;
		gwvvJob.GW_Volunteers__Campaign__c = campaignId;
		gwvvJob.Processed__c = processed;
		gwvvJob.GW_Volunteers__Display_on_Website__c = includeWeb;
		
		return gwvvJob;
	}
	
	/*
	 * helper method to populate C52_MongoSettings__c (customSettings)
	*/
	public static C52_MongoSettings__c getMongoSettings(string dbName, string tokenType, string token) {
		C52_MongoSettings__c settings = new C52_MongoSettings__c(
			Token__c = token,
			TokenType__c = tokenType,
			Database__c = dbName,
			Name = Constants.MONGO_SETTINGS_NAME
		);
		
		return settings;
	} 
}