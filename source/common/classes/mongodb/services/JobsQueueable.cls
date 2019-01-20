public with sharing class JobsQueueable implements Queueable, Database.AllowsCallouts {
	/*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoJobService.syncVolunteerJobs();

		if(VolunteerJobsSelector.newInstance().selectJobsForProcessing().size() > 0) {
			System.enqueueJob(new JobsQueueable());
		} else {
			System.enqueueJob(new JobShiftsQueueable());
		}
	}
}