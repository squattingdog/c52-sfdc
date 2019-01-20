public interface IVolunteerShiftsService {
    List<VolunteerShiftsService.VolunteerShiftDTO> getVolunteerShiftDTOs();
	void setMongoIds(List<GW_Volunteers__Volunteer_Shift__c> updtVolunteerShifts);
}
