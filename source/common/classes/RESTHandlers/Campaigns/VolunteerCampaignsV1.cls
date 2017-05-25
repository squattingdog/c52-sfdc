/*
* Description: Rest handler Volunteer Campaigns
*/
@RestResource(urlMapping='/v1/volunteerCampaigns/')
global with sharing class VolunteerCampaignsV1 {
	/*
    * 
    * Returns:
    *     List<CampaignDTO>: The results of the selector
    *
    * Description: gets the top level Volunteer Campaigns
    */
	@HttpGet
    global static List<CampaignService.CampaignDTO> getVolunteerCampaigns() {
		return CampaignService.getInstance().getTopLevelVolunteerCampaigns();
	}
}
