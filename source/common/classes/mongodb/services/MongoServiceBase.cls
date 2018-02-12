public abstract class MongoServiceBase {
	private static ffhttp_C52Mongo client = null;
	
	/*
	 * Get the Mongo Client
	*/
	public static ffhttp_C52Mongo getC52MongoClient() {
		if(MongoServiceBase.client == null) {
			ffhttp_Client.Credentials creds = new ffhttp_Client.Credentials(Settings.getMongoTokenType(), Settings.getMongoToken());
			MongoServiceBase.client = new ffhttp_C52Mongo(creds);
		}
		return MongoServiceBase.client;
	}
}
