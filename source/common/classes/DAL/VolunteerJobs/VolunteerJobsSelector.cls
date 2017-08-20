public class VolunteerJobsSelector extends fflib_SObjectSelector {
	/*
	* Output:
	* 	VolunteerJobsSelector
	* Description:
	* 	This method returns an instance of VolunteerJobsSelector 
	*/
	public Static VolunteerJobsSelector newInstance() {
		Return (VolunteerJobsSelector)App.Selector.newInstance(GW_Volunteers__Volunteer_Job__c.SObjectType);
	}
	
	/*
	* constructor
	*
	* sets field permission validation to false
	*/
	public VolunteerJobsSelector() {
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
            GW_Volunteers__Volunteer_Job__c.Id,
            GW_Volunteers__Volunteer_Job__c.IsDeleted,
            GW_Volunteers__Volunteer_Job__c.Name,
            GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Campaign__c,
            GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Description__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Display_on_Website__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__First_Shift__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Inactive__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Location_City__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Location_Information__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Location_Street__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Location_Zip_Postal_Code__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Location__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Number_of_Completed_Hours__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Number_of_Shifts__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Number_of_Volunteers_Still_Needed__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Number_of_Volunteers__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Ongoing__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Skills_Needed__c,
			GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Volunteer_Website_Time_Zone__c,
			GW_Volunteers__Volunteer_Job__c.MongoId__c
        };
	}

	/*
	* Output:
	* 	Schema.sObjectType - returns the selector type, in this case, a campaign  	
	* Description:
	*   This method returns the sObject Type of this selector, which Is campaign
	*/
	public Schema.SObjectType getSObjectType() { 
		Return GW_Volunteers__Volunteer_Job__c.SObjectType;
	}
	
	/***
	*  IVolunteerJobsSelector implementations
	***/
	
	/*
	* Parameters:
	* 	Set<Id> idSet - list of Volunteer_Job__c Ids to be selected
	* Output:
	* 	List<GW_Volunteers__Volunteer_Job__c> - list of Volunteer_Job__c including attributes 
	*		specified in the selector
	* Description:
	*   This method returns a list of Volunteer_Job__c with the fields specified in the field list
	*   for this selector
	*/
	public List<GW_Volunteers__Volunteer_Job__c> selectById(Set<Id> idSet){
		return (List<GW_Volunteers__Volunteer_Job__c>)selectSObjectsById(idSet);
	}
	
	/*
	* Parameters:
	*	Set<Id> campaignIdSet - set of campaignIds to filter by
	* Returns:
	*	List<GW_Volunteers__VolunteerJob__c> - List of VolunteerJobs for the given campaign IDs.
	* Description:
	*	This method selects a list of VolunteerJob__c records by CampaignID
	*/
	public List<GW_Volunteers__Volunteer_Job__c> selectByCampaignId(Set<Id> campaignIdSet) {
		return (List<GW_Volunteers__Volunteer_Job__c>)Database.query(
			newQueryFactory().
			setCondition('GW_Volunteers__Volunteer_Job__c.GW_Volunteers__Campaign__c IN :campaignIdSet')
			.toSoql()); 
	}
}
