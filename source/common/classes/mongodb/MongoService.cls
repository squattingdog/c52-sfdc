public class MongoService implements Queueable, Database.AllowsCallouts {
		
	private static ffhttp_C52Mongo client = null;
	
	/*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoService.loadTopLevelVolunteerCampaigns();
	}	
	
	/*
	* Description:
	*	Entry point to send Campaign data from SFDC to MongoDB
	*/
	public static void loadTopLevelVolunteerCampaigns() {
		// get the list of campaigns to sync
		List<Campaign> sfCampaigns = CampaignService.getInstance().getTopLevelVolunteerCampaignsForProcessing();
		// instantiate a campaing domain object
		Campaigns dCampaigns = new Campaigns(sfCampaigns);
		// convert the sObjects to DTOs
		CampaignService.CampaignDTOFactory campaignFactory = new CampaignService.CampaignDTOFactory();
		dCampaigns.generate(campaignFactory);
		// send to mongodb
		C52MongoModelCampaign response = MongoService.insertMongoDBCampaigns(campaignFactory.campaignDTOs);
		
		if(response.status == 'OK') {
			// convert the response to sObjects
			List<Campaign> updateCampaigns = (List<Campaign>)MongoModelConverter.convertMongoModel(response);
			// update campaigns
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
	*	C52MongoModelCampaign - the mongo response model object.
	*/
	public static C52MongoModelCampaign insertMongoDBCampaigns(List<CampaignService.CampaignDTO> campDTOs) {
		// get the http client	
		ffhttp_c52Mongo mongoClient = MongoService.getC52MongoClient();
		// get the Campaigns Resource
		ffhttp_C52MongoCampaigns mongoCampaigns = mongoClient.campaigns();
		// setup the request object
		ffhttp_C52MongoCampaigns.CampaignsPostRequest request = mongoCampaigns.campaignsPostRequest(Blob.valueOf(JSON.serialize(campDTOs)));
		// send the request and capture the response
		C52MongoModelCampaign responseCampaigns = (C52MongoModelCampaign)request.execute();
		
		return responseCampaigns;
	}	
	
	/*
	 * Get the Mongo Client
	*/
	private static ffhttp_C52Mongo getC52MongoClient() {
		if(MongoService.client == null) {
			ffhttp_Client.Credentials creds = new ffhttp_Client.Credentials(Settings.getMongoTokenType(), Settings.getMongoToken());
			MongoService.client = new ffhttp_C52Mongo(creds);
		}
		return MongoService.client;
	}	
}
