public with sharing class VolunteerJobsServiceImpl {
	
	/*
	* Description
	*	Get a list of VolunteerJobDTOs for the campaignIds provided.
	* Returns:
	*	A list of VolunteerJobDTOs
	*/
	public List<VolunteerJobsService.VolunteerJobDTO> getVolunteerJobDTOsByCampaignIds(Set<ID> campaignIds){
		List<GW_Volunteers__Volunteer_Job__c> jobList = VolunteerJobsSelector.newInstance().selectByCampaignId(campaignIds);
		VolunteerJobsService.VolunteerJobDTOFactory factory = new VolunteerJobsService.VolunteerJobDTOFactory();
		for(GW_Volunteers__Volunteer_Job__c job : jobList) {
			factory.add(job);
		}
		
		return factory.volunteerJobDTOs;
	}
	
	/*
	* Description:
	*	Update the campaign with the related mongoId and set processed to true.
	* 
	* Inputs:
	*	idMap - map of CampaignId to mongoId
	*/
	void setMongoIds(List<GW_Volunteers__Volunteer_Job__c> updtVolunteerJobs){
		fflib_ISobjectUnitOfWork uow = App.UnitOfWork.newInstance();
		for(GW_Volunteers__Volunteer_Job__c job : updtVolunteerJobs) {
			job.processed__c = true;
			uow.registerDirty(job);
		}
		
		uow.commitWork();		
	}
}
