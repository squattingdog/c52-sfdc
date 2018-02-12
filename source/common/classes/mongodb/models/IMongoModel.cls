public interface IMongoModel {
	String getStatus();
	String getMessage();
	SObjectType getSObjectType();
	String getMongoIdFieldName();
	List<IMongoLocation> getLocations();
}