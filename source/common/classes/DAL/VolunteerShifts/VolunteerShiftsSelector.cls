public with sharing class VolunteerShiftsSelector extends fflib_SObjectSelector {
/*
	* Output:
	* 	VolunteerJobsSelector
	* Description:
	* 	This method returns an instance of VolunteerJobsSelector 
	*/
	public Static VolunteerShiftsSelector newInstance() {
		Return (VolunteerShiftsSelector)App.Selector.newInstance(GW_Volunteers__Volunteer_Shift__c.SObjectType);
	}
	
	/*
	* constructor
	*
	* sets field permission validation to false
	*/
	public VolunteerShiftsSelector() {
		super(false);
	}
	
	/*
	* Output:
	* 	Schema.SObjectField - returns the specified GW_Volunteers__VolunteerJobs fields for this selector
	* Description:
	*   This method returns the list of campaign fields 
	*/
	public List<Schema.SObjectField> getSObjectFieldList() {
		Return New List <Schema.SObjectField> {
            GW_Volunteers__Volunteer_Shift__c.CreatedDate
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Description__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Desired_Number_of_Volunteers__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Duration__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job_Location_City__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job_Location_State_Province__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job_Location_Street__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job_Location_Zip_Postal_Code__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job_Recurrence_Schedule__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Number_of_Volunteers_Still_Needed__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Start_Date_Time__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__System_Note__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Total_Volunteers__c
            ,GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Volunteer_Job__c
            ,GW_Volunteers__Volunteer_Shift__c.Id
            ,GW_Volunteers__Volunteer_Shift__c.IsDeleted
            ,GW_Volunteers__Volunteer_Shift__c.Name
        };
	}

	/*
	* Output:
	* 	Schema.sObjectType - returns the selector type, in this case, a campaign  	
	* Description:
	*   This method returns the sObject Type of this selector, which Is campaign
	*/
	public Schema.SObjectType getSObjectType() { 
		Return GW_Volunteers__Volunteer_Shift__c.SObjectType;
	}

	/*
	* Parameters:
	* 	Set<Id> idSet - list of Volunteer_Shift__c Ids to be selected
	* Output:
	* 	List<GW_Volunteers__Volunteer_Shift__c> - list of Volunteer_Shift__c including attributes 
	*		specified in the selector
	* Description:
	*   This method returns a list of Volunteer_Shift__c with the fields specified in the field list
	*   for this selector
	*/
	public List<GW_Volunteers__Volunteer_Shift__c> selectById(Set<Id> idSet){
		return (List<GW_Volunteers__Volunteer_Shift__c>)selectSObjectsById(idSet);
	}
	
	/*
	* Parameters:
	*	Set<Id> volunteerJobIdSet - set of volunteer job Ids to filter by
	* Returns:
	*	List<GW_Volunteers__Volunteer_Shift__c> - List of VolunteerShifts for the given volunteer job IDs.
	* Description:
	*	This method selects a list of VolunteerShift__c records by volunteer job IDs
	*/
	public List<GW_Volunteers__Volunteer_Shift__c> selectByVolunteerJobId(Set<Id> volunteerJobIdSet) {
		return (List<GW_Volunteers__Volunteer_Shift__c>)Database.query(
			newQueryFactory().
			setCondition('GW_Volunteers__Volunteer_Shift__c.GW_Volunteers__Job__c IN :volunteerJobIdSet')
			.toSoql()); 
	}
	
	/*
	* Returns:
	*	List<GW_Volunteers__Volunteer_Shift__c> - List of VolunteerJobs for processing
	* Description:
	*	Selects all GW_Volunteers__Volunteer_Shift__c records where processing is false
	*		and the related job.includeForWebsite = true
	*/
	public List<GW_Volunteers__Volunteer_Shift__c> selectShiftsForProcessing() {
		return (List<GW_Volunteers__Volunteer_Shift__c>)Database.query(
			newQueryFactory().
			setCondition('processed__c = false AND GW_Volunteers__Volunteer_Job__r.GW_Volunteers__Display_on_Website__c = true')
			.setLimit(100)
			.toSoql());
	}
}
