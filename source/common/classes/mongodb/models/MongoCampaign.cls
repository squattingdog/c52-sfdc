public with sharing class MongoCampaign extends MongoModelBase {	
	/************************************
	* C52MongoModelBase overrides
	************************************/
	public override Schema.SObjectType getSObjectType(){
		return Campaign.SObjectType;
	}
	public override String getMongoIdFieldName() {
		return Constants.MONGO_ID_FIELD_NAME;
	}
}
