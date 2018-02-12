public abstract class MongoModelBase implements IMongoModel {
    public String status {get; set;}
	public String message {get; set;}	
	public List<Location> locations {get; set;}
    
	public List<IMongoLocation> getLocations(){
		return this.locations;
	}
	
	public String getStatus() {
		return this.status;
	}
	
	public String getMessage() {
		return this.message;
	}
	
	/*  override these in concrete class */		
	public abstract Schema.SObjectType getSObjectType();	
	public abstract String getMongoIdFieldName();
    
    public class Location implements IMongoLocation {
		public String sfId {get; set;}
        public String docId {get; set;}
        
        /******************************
        * IMongoLocation implementation
        ******************************/		
        public String getId() {
            return this.sfId;
        }
        public String getMongoId() {
            return this.docId;
        }
    }
}
