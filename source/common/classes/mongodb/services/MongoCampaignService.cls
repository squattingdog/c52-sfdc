public class MongoCampaignService extends MongoServiceBase {
	/*
	* Description:
	*	Entry point to send Campaign data from SFDC to MongoDB
	*   	This will retrieve the campaigns and send them to MongoDB
	*/
	public static void loadTopLevelVolunteerCampaigns() {
		// get the list of campaigns to sync
		List<Campaign> sfCampaigns = CampaignService.getInstance().getTopLevelVolunteerCampaignsForProcessing();
		// instantiate a campaign domain object
		Campaigns dCampaigns = new Campaigns(sfCampaigns);
		// convert the sObjects to DTOs
		CampaignService.CampaignDTOFactory campaignFactory = new CampaignService.CampaignDTOFactory();
		dCampaigns.generate(campaignFactory);
		// send to mongodb
		MongoCampaign response = insertMongoDBCampaigns(campaignFactory.campaignDTOs);
		
		if(response.status == Constants.MONGO_RESPONSE_SUCCESS_STATUS) {
			// convert the response to sObjects
			List<Campaign> updateCampaigns = (List<Campaign>)MongoModelConverter.convertMongoModel(response);
			// update campaigns mongoDB IDs
			CampaignService.getInstance().setMongoIds(updateCampaigns);
		} else {
			//log error
			system.debug(response);
		}
	}
	
	/*
	* Description:
	*	handles the connection to mongo using POST methods to sync data from sfdc to mongodb
	* Params:
	*	campDTOs - the campaign data to post
	* Returns:
	*	MongoCampaign - the mongo response model object.
	*/
	public static MongoCampaign insertMongoDBCampaigns(List<CampaignService.CampaignDTO> campDTOs) {
		// get the http client	
		ffhttp_c52Mongo mongoClient = MongoServiceBase.getC52MongoClient();
		// get the Campaigns Resource
		ffhttp_C52MongoCampaigns mongoCampaigns = mongoClient.campaigns();
		// setup the request object
		ffhttp_C52MongoCampaigns.CampaignsPostRequest request = mongoCampaigns.getCampaignsPostRequest(Blob.valueOf(JSON.serialize(campDTOs)));
		// send the request and capture the response
		MongoCampaign responseCampaigns = (MongoCampaign)request.execute();
		
		return responseCampaigns;
	}
}
