public interface IVolunteerJobsService {
	List<VolunteerJobsService.VolunteerJobDTO> getVolunteerJobDTOsByCampaignIds(Set<ID> campaignIds);
	void setMongoIds(List<GW_Volunteers__Volunteer_Job__c> updtVolunteerJobs);
}
