public with sharing abstract class ffhttp_C52MongoResource {
	//Statics
	
	//URLs
	//C52 Mongo URLs
	public static final String C52MONGO_URL = 'https://c52-sfdc-dev.herokuapp.com/';
	public static final String C52MONGO_DB = Settings.getMongoDBName();
	
	//Mongo Routes / Collections
	public static final String MONGO_CAMPAIGNS = '/campaign/';
	public static final String MONGO_JOBS = '/job/';
	

	//Instance variables
	private ffhttp_C52Mongo m_service;
	
	/**
	 * Constructor
	 */
	public ffhttp_C52MongoResource(ffhttp_C52Mongo service)
	{
		m_service = service;
	}
	
	/**
	 * Gets/Sets
	 */
	public ffhttp_C52Mongo getService()
	{
		return m_service;
	}
	
	public ffhttp_C52MongoResource setService(ffhttp_C52Mongo service)
	{
		m_service = service;
		return this;
	}
	
	
	/**
	 * C52MongoRequest
	 * 
	 * Abtract class created for all C52 Mongo requests
	 */
	public abstract class C52MongoRequest extends ffhttp_Client.AbstractClientRequest
	{ 
	 	protected C52MongoRequest(ffhttp_C52MongoResource resource, String endpoint, String method, 
	 								 ffhttp_IHttpContent content, ffhttp_IDeserialize responseDeserializer) 
	 	{
			super(resource.getService(),  endpoint, method, content, responseDeserializer);
		}
	}	
}
