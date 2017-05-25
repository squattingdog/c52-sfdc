/*
* This class contains the implementation of the service method in CampaignsRouterService
*/
public class CampaignsServiceImpl implements ICampaignsService {
	public List<CampaignService.CampaignDTO> getTopLevelVolunteerCampaigns(){
		List<Campaign> campaignList = CampaignsSelector.newInstance().selectTopLevelVolunteerCampaigns();
		CampaignService.CampaignDTOFactory factory = new CampaignService.CampaignDTOFactory();
		for(Campaign c : campaignList){
			factory.add(c);
		}
		return factory.CampaignDTOs;
	}	
}