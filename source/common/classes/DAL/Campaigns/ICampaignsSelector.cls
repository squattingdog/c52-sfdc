/*
* This class Is an interface implemented in CampaignsSelector.  Every method in this class
* must be implemented in CampaignsSelector
*/
Public Interface ICampaignsSelector extends fflib_ISObjectSelector {

	List<Campaign> selectTopLevelVolunteerCampaigns();

}