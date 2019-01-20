public with sharing class VolunteerShifts extends fflib_SObjectDomain implements IVolunteerShifts, VolunteerShiftsService.ISupportVolunteerShiftDTO {
    /*
	* Parameters:
	* 	List<GW_Volunteers__Volunteer_Shift__c> sObjectList - list of Volunteer shifts
	* Output:
	*   IVolunteerShifts - VolunteerShifts Domain interface
	* Description:
	* 	returns a New instance of the VolunteerShifts class cast as its interface
	*/
	public static IVolunteerShifts newInstance(List<GW_Volunteers__Volunteer_Shift__c> sObjectList) {
		Return (IVolunteerShifts)App.Domain.newInstance(sObjectList);
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
	* 	List<GW_Volunteers__Volunteer_Shift__c> sObjectList - list of Volunteer shifts
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	public VolunteerShifts(List<GW_Volunteers__Volunteer_Shift__c> sObjectList) {
		super(sObjectList);
	}

	/*
	* This class Is used by the app to return a New instance of the VolunteerShifts class
	*/
	public class Constructor implements fflib_SObjectDomain.IConstructable {

		/*
		* Parameters:
		* 	List<GW_Volunteers__Volunteer_Shift__c> sObjectList - list of Volunteer Shifts
		* Output:
		*   fflib_SObjectDomain - fflib_SObjectDomain as VolunteerShifts class
		* Description:
		* 	returns a New instance of fflib_SObjectDomain as the VolunteerShifts class
		*/
		public fflib_SObjectDomain construct(List<SObject> sObjectList){
			return New VolunteerShifts(sObjectList);
		}
	}
	
	/*
	* ISupportVolunteerShiftDTO generate impl
	*/
	public void generate(VolunteerShiftsService.VolunteerShiftDTOFactory factory)	{
		for(GW_Volunteers__Volunteer_Shift__c s : (List<GW_Volunteers__Volunteer_Shift__c>)this.Records){
			factory.add(s);
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
		this.updateC52ServiceData();
	}
	
	/*
	* Before update trigger event
	*/
	public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {		
		//set processed flag to false so the record is picked up in sync process.
		for(GW_Volunteers__Volunteer_Shift__c s : (List<GW_Volunteers__Volunteer_Shift__c>)this.Records) {
			s.processed__c = false;
		}
	}
	
	/*
	* After update trigger event
	*/
	public override void onAfterUpdate(Map<Id,SObject> existingRecords) {			
		// push data to MongoDB
		this.updateC52ServiceData();
	}

	private void updateC52ServiceData() {
		if(this.Records.size() > 0 && VolunteerShifts.syncEnabled) {
			System.enqueueJob(new JobShiftsQueable());
		}
	}
}
