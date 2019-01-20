public with sharing class JobShiftsQueueable implements Queueable, Database.AllowsCallouts {
    /*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoJobShiftService.syncVolunteerJobShifts();

		if(VolunteerShiftsSelector.newInstance().selectShiftsForProcessing().size() > 0) {
			System.enqueueJob(new JobShiftsQueueable());
		}
	}
}
