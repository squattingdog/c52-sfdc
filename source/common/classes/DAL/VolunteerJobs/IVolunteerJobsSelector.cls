/*
* This class Is an interface implemented in VolunteerJobsSelector.  Every method in this class
* must be implemented in VolunteerJobsSelector
*/
public interface IVolunteerJobsSelector extends fflib_ISObjectSelector {
	List<GW_Volunteers__Volunteer_Job__c> selectById(Set<Id> idSet);	
	List<GW_Volunteers__Volunteer_Job__c> selectByCampaignId(Set<Id> campaignIdSet);
}
