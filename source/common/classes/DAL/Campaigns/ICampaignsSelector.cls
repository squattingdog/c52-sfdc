/*
* This class Is an interface implemented in CampaignsSelector.  Every method in this class
* must be implemented in CampaignsSelector
*/
public interface ICampaignsSelector extends fflib_ISObjectSelector {

	List<Campaign> selectById(Set<Id> idSet);
	
	List<Campaign> selectTopLevelVolunteerCampaigns();
	
	List<Campaign> selectTopLevelVolunteerCampaignsForProcessing();

}