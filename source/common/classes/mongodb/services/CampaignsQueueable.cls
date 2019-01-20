public with sharing class CampaignsQueueable implements Queueable, Database.AllowsCallouts {
	/*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoCampaignService.loadTopLevelVolunteerCampaigns();

		if(CampaignsSelector.newInstance().selectTopLevelVolunteerCampaignsForProcessing().size() > 0) {
			System.enqueueJob(new CampaignsQueueable());
		} else {
			System.enqueueJob(new JobsQueueable());
		}
	}
}
