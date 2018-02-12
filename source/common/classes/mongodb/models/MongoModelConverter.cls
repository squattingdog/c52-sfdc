public with sharing class MongoModelConverter {
	/*
	* Description: 
	*	convert the returned Mongo model to the concrete SObject type
	*	defined in the IMongoModel impl.
	*
	* Params:
	*	mongoModel - The IMonogModel impl
	*
	* Returns:
	*	List<SObject> - the SObjects populated from the IMongoModel
	*/
	public static List<SObject> convertMongoModel(IMongoModel mongoModel) {
		List<SObject> ret = new List<SObject>();
		Schema.SObjectType oType = mongoModel.getSObjectType();
		
		//create a new SObject for each mongo location and populate the SF ID and mongoId fields.
		for(IMongoLocation location : mongoModel.getLocations()){
			SObject obj = oType.newSObject(location.getId());
			obj.put(mongoModel.getMongoIdFieldName(), location.getMongoId());
			ret.add(obj);
		}
		
		return ret;
	}
}
