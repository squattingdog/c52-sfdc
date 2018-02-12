public class VolunteerJobs extends fflib_SObjectDomain implements IVolunteerJobs, VolunteerJobsService.ISupportVolunteerJobDTO {
	
	/*
	* Parameters:
	* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
	* Output:
	*   IVolunteerJobs - VolunteerJobs Domain interface
	* Description:
	* 	returns a New instance of the VolunteerJobs class cast as its interface
	*/
	public static IVolunteerJobs newInstance(List<GW_Volunteers__Volunteer_Job__c> sObjectList) {
		Return (IVolunteerJobs)App.Domain.newInstance(sObjectList);
	}
	
	/*
	* Property used to toggle the triggered http data sync
	*/
	private static Boolean syncEnabled = true;
	public static void setSyncRecordsEnabled(Boolean val) {
		syncEnabled = val;
	}

	/*
	* Constructor
	* Parameters:
	* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	public VolunteerJobs(List<GW_Volunteers__Volunteer_Job__c> sObjectList) {
		super(sObjectList);
	}

	/*
	* This class Is used by the app to return a New instance of the VolunteerJobs class
	*/
	public class Constructor implements fflib_SObjectDomain.IConstructable {

		/*
		* Parameters:
		* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
		* Output:
		*   fflib_SObjectDomain - fflib_SObjectDomain as VolunteerJobs class
		* Description:
		* 	returns a New instance of fflib_SObjectDomain as the VolunteerJobs class
		*/
		public fflib_SObjectDomain construct(List<SObject> sObjectList){
			return New VolunteerJobs(sObjectList);
		}
	}
	
	/*
	* ISupportVolunteerJobDTO generate impl
	*/
	public void generate(VolunteerJobsService.VolunteerJobDTOFactory factory)	{
		for(GW_Volunteers__Volunteer_Job__c j : (List<GW_Volunteers__Volunteer_Job__c>)this.Records){
			factory.add(j);
		}
	}
	
	/*******************
	 * Trigger Overrides
	*******************/
	
	/*
	 * After Insert trigger method
	*/
	public override void onAfterInsert() {		
		//push data to mongoDB
		if(this.Records.size() > 0 && VolunteerJobs.syncEnabled) {
			System.enqueueJob(new JobsQueable());
		}
	}
	
	/*
	* Before update trigger event
	*/
	public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {		
		//set processed flag to false so the record is picked up in sync process.
		for(GW_Volunteers__Volunteer_Job__c j : (List<GW_Volunteers__Volunteer_Job__c>)this.Records) {
			j.processed__c = false;
		}
	}
	
	/*
	* After update trigger event
	*/
	public override void onAfterUpdate(Map<Id,SObject> existingRecords) {			
		// push data to MongoDB
		if(this.Records.size() > 0 && VolunteerJobs.syncEnabled) {
			System.enqueueJob(new JobsQueable());
		}
	}
}
