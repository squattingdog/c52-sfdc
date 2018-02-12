public abstract class MongoServiceBase {
	private static ffhttp_C52Mongo client = null;
		
	/*
	 * Description:
	 *	Get the Mongo Client to connect to MongoDB
	 * Returns:
	 * 	ffhttp_C52Mongo - the mongo client connector
	*/
	public static ffhttp_C52Mongo getC52MongoClient() {			
		if(MongoServiceBase.client == null) {
			ffhttp_Client.Credentials creds = new ffhttp_Client.Credentials(
				Settings.getInstance().getMongoTokenType(), 
				Settings.getInstance().getMongoToken()
			);
			MongoServiceBase.client = new ffhttp_C52Mongo(creds);
		}
		return MongoServiceBase.client;
	}
}
