public with sharing class JobShiftsQueable implements Queueable, Database.AllowsCallouts {
    /*
	* Description:
	*	The Queueable impl - entry point for queuing.
	*/
	public void execute(QueueableContext context){
		MongoJobShiftService.syncVolunteerJobShifts();
	}
}
