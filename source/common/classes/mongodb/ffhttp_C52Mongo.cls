/**
 * ffhttp_C52Mongo
 *
 * The main C52 Mongo client class.
 * This class contains the methods to access each of the C52 Mongo API calls.
 */
public with sharing class ffhttp_C52Mongo extends ffhttp_Client.AbstractClient {

	/**
	* Constructor.
	*
	* @param credentials - HTTP request credentials required for authentication.
	* @returns - The C52 Mongo API HTTP client giving access to all API calls.
	*/
	public ffhttp_C52Mongo(ffhttp_Client.Credentials creds) {
		this.setCredentials(creds);
	}
	
	/**
	 * An accessor for creating requests for the Campaigns collection
	 *
	 * @return The resources collection.
	 */
	public ffhttp_C52MongoCampaigns campaigns()
	{
		return new ffhttp_C52MongoCampaigns(this);
	}
	
	/**
	 * An accessor for creating requests for the Volunteer Jobs collection
	 *
	 * @return The resources collection.
	 */
	public ffhttp_C52MongoJobs jobs()
	{
		return new ffhttp_C52MongoJobs(this);
	}
	
	/**
	 * An accessor for creating requests for the Volunteer Job Shifts collection
	 *
	 * @return The resources collection.
	 */
	public ffhttp_C52MongoJobShifts shifts()
	{
		return new ffhttp_C52MongoJobShifts(this);
	}
}
