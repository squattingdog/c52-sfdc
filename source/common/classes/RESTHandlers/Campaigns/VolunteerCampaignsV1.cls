/*
* Description: Rest handler Volunteer Campaigns
*/
@RestResource(urlMapping='/v1/volunteerCampaigns/')
global with sharing class VolunteerCampaignsV1 {
	/* 
    * Returns:
    *     APIResponse: The results of the selector
    *
    * Description: allows a user to signup for a particular volunteer job shift.
    */
	@HttpPost
	global static APIResponse signupForCampaignJobShift(APIJobSignup signup) {
		return new APIResponse();
	}
}
