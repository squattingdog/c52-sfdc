public class C52MongoModelCampaign implements IMongoModel {
	public String status {get; set;}
	public String message {get; set;}	
	public List<Location> locations {get; set;}
	
	/************************************
	* IMongoModel implementation
	************************************/
	public List<IMongoLocation> getLocations(){
		return this.locations;
	}	
	public Schema.SObjectType getSObjectType(){
		return Campaign.SObjectType;
	}
	public String getMongoIdFieldName() {
		return Constants.MONGO_ID_FIELD_NAME;
	}
	public String getStatus() {
		return this.status;
	}
	
	public String getMessage() {
		return this.message;
	}
	
	/*
	* Inner class Mongo Location object
	*/
	public class Location implements IMongoLocation {
		public String campaignId {get; set;}
		public String docId {get; set;}
		
		/******************************
		* IMongoLocation implementation
		******************************/
		
		public String getId() {
			return this.campaignId;
		}
		public String getMongoId() {
			return this.docId;
		}
	}
}