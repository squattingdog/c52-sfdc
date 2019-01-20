public with sharing class VolunteerShiftsServiceImpl implements IVolunteerShiftsService {
	
	/*
	* Description
	*	Get a list of VolunteerJobDTOs for the campaignIds provided.
	* Returns:
	*	A list of VolunteerJobDTOs
	*/
	public List<VolunteerShiftsService.VolunteerShiftDTO> getVolunteerShiftDTOs() {
		List<GW_Volunteers__Volunteer_Shift__c> shiftList = VolunteerShiftsSelector.newInstance().selectShiftsForProcessing();
		VolunteerShiftsService.VolunteerShiftDTOFactory factory = new VolunteerShiftsService.VolunteerShiftDTOFactory();
		for(GW_Volunteers__Volunteer_Shift__c shift : shiftList) {
			factory.add(shift);
		}
		
		return factory.volunteerShiftDTOs;
	}
	
	/*
	* Description:
	*	Update the VolunteerShifts setting the processed flag to true.
	* 
	* Inputs:
	*	updtVolunteerShiftss - list of volunteershifts with mongoId already set.
	*/
	public void setMongoIds(List<GW_Volunteers__Volunteer_Shift__c> updtVolunteerShifts) {
		// disable update trigger events on volunteerShifts domain
		fflib_SObjectDomain.getTriggerEvent(VolunteerShifts.class).disableBeforeUpdate();		
		fflib_SObjectDomain.getTriggerEvent(VolunteerShifts.class).disableAfterUpdate();
		
		// update mongoId and processed flag.
		fflib_ISobjectUnitOfWork uow = App.UnitOfWork.newInstance();
		for(GW_Volunteers__Volunteer_Shift__c shift : updtVolunteerShifts) {
			shift.processed__c = true;
			uow.registerDirty(shift);
		}
		
		uow.commitWork();	
	}
}
