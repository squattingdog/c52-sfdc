public with sharing class VolunteerJobsServiceImpl implements IVolunteerJobsService {
	
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
	*	Update the VolunteerJobs setting the processed flag to true.
	* 
	* Inputs:
	*	updtVolunteerJobs - list of volunteerjobs with mongoId already set.
	*/
	public void setMongoIds(List<GW_Volunteers__Volunteer_Job__c> updtVolunteerJobs){
		// disable update trigger events on volunteerJobs domain
		fflib_SObjectDomain.getTriggerEvent(VolunteerJobs.class).disableBeforeUpdate();		
		fflib_SObjectDomain.getTriggerEvent(VolunteerJobs.class).disableAfterUpdate();
		
		// update mongoId and processed flag.
		fflib_ISobjectUnitOfWork uow = App.UnitOfWork.newInstance();
		for(GW_Volunteers__Volunteer_Job__c job : updtVolunteerJobs) {
			job.processed__c = true;
			uow.registerDirty(job);
		}
		
		uow.commitWork();		
	}
}
