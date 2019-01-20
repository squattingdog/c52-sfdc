public with sharing class MongoJobShift extends MongoModelBase {
    /************************************
	* C52MongoModelBase overrides
	************************************/
	public override Schema.SObjectType getSObjectType(){
		return GW_Volunteers__Volunteer_Shift__c.SObjectType;
	}
	public override String getMongoIdFieldName() {
		return Constants.MONGO_ID_FIELD_NAME;
	}
}
