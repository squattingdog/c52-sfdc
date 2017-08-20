/**
 * ffhttp_C52MongoCampaigns
 *
 * This class contains the methods to access each of the C52 Mongo Campaigns API calls.
 */
public class ffhttp_C52MongoCampaigns extends ffhttp_C52MongoResource {
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_C52Mongo service.
	 * @return Access to the Campaigns API calls.
	 */
	public ffhttp_C52MongoCampaigns(ffhttp_C52Mongo service) 
	{
		super(service);
	}
	
	/**
	 * /Campaigns_post
	 *
	 * Insert Campaigns using post semantics. 
	 *
	 */
	 public CampaignsPostRequest getCampaignsPostRequest(Blob campaignsJsonContent){
	 	if(campaignsJsonContent == null) throw new ffhttp_SystemException(Constants.CALLOUT_CONTENT_NULL);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(campaignsJsonContent, Constants.CONTENT_TYPE_JSON);
	 	return new CampaignsPostRequest(this, content);
	 }
	 
	 /**
	 * /Campaigns_put
	 *
	 * Update a Campaign using put semantics. 
	 *
	 */
	 public CampaignsPutRequest getCampaignsPutRequest(string path, Blob campaignsJsonContent){
	 	if(String.isBlank(path)) throw new ffhttp_SystemException(Constants.CALLOUT_PATH_NULL);
	 	if(campaignsJsonContent == null) throw new ffhttp_SystemException(Constants.CALLOUT_CONTENT_NULL);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(campaignsJsonContent, Constants.CONTENT_TYPE_JSON);
	 	return new CampaignsPutRequest(this, path, content);
	 }
	 
	 /*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	 
	 public class CampaignsPostRequest extends C52MongoRequest {
	 	CampaignsPostRequest(ffhttp_C52MongoCampaigns campaigns, ffhttp_IHttpContent content) {
	 		super(campaigns
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_CAMPAIGNS
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoCampaign.class));	 	
	 	}
	 }
	 
	 public class CampaignsPutRequest extends C52MongoRequest {
	 	CampaignsPutRequest(ffhttp_C52MongoCampaigns campaigns, string path, ffhttp_IHttpContent content) {
	 		super(campaigns
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_CAMPAIGNS + path
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoCampaign.class)); 	
	 	}
	 }
}
