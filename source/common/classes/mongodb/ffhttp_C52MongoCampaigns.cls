/**
 * ffhttp_C52MongoCampaigns
 *
 * This class contains the methods to access each of the C52 Mongo Campaigns API calls.
 */
public with sharing class ffhttp_C52MongoCampaigns extends ffhttp_C52MongoResource {
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
	 public CampaignsPostRequest campaignsPostRequest(Blob campaignsJsonContent){
	 	//if(campaignsJsonContent == null) throw new ffhttp_SystemException(System.Label.ffhttp_c52Mongo_NullContent);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(campaignsJsonContent, 'application/json');
	 	return new CampaignsPostRequest(this, content);
	 }
	 
	 /**
	 * /Campaigns_put
	 *
	 * Update a Campaign using put semantics. 
	 *
	 */
	 public CampaignsPutRequest campaignsPutRequest(string path, Blob campaignsJsonContent){
	 	//if(path == null) throw new ffhttp_SystemException(System.Label.ffhttp_c52Mongo_NullPath);
	 	//if(campaignsJsonContent == null) throw new ffhttp_SystemException(System.Label.ffhttp_c52Mongo_NullContent);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(campaignsJsonContent, 'application/json');
	 	return new CampaignsPutRequest(this, path, content);
	 }
	 
	 /*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	 
	 public class CampaignsPostRequest extends C52MongoRequest {
	 	CampaignsPostRequest(ffhttp_C52MongoCampaigns campaigns, ffhttp_IHttpContent content) {
	 		super(campaigns
	 			,C52MONGO_URL + C52MONGO_DB + '/campaign/'
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(C52MongoModelCampaign.class));	 	
	 	}
	 }
	 
	 public class CampaignsPutRequest extends C52MongoRequest {
	 	CampaignsPutRequest(ffhttp_C52MongoCampaigns campaigns, string path, ffhttp_IHttpContent content) {
	 		super(campaigns
	 			,C52MONGO_URL + C52MONGO_DB + '/campaign/' + path
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(C52MongoModelCampaign.class)); 	
	 	}
	 }
}
