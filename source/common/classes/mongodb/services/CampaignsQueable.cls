public with sharing class CampaignsQueable implements Queueable, Database.AllowsCallouts {
	/*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoCampaignService.loadTopLevelVolunteerCampaigns();
	}
}
