public with sharing class MongoJob extends MongoModelBase {
	public override string getMongoIdFieldName() {
    	return Constants.MONGO_ID_FIELD_NAME;
    }
    
    public override Schema.SObjectType getSObjectType() {
    	return GW_Volunteers__Volunteer_Job__c.SObjectType;
    }
}
