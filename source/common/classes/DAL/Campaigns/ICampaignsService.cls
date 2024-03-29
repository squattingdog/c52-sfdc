/*
* This class Is an interface implemented in CampaignsServiceImpl.  Every method 
* must be implemented in CampaignsServiceImpl
*/
public interface ICampaignsService {
	List<CampaignService.CampaignDTO> getTopLevelVolunteerCampaigns();
	List<Campaign> getTopLevelVolunteerCampaignsForProcessing();
	void setMongoIds(List<Campaign> updtCampaigns);
}