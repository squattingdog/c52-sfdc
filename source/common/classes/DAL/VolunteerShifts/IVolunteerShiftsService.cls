public interface IVolunteerShiftsService {
    List<VolunteerShiftsService.VolunteerShiftDTO> getVolunteerShiftDTOsByVolunteerJobIds(Set<ID> volunteerJobIds);
	void setMongoIds(List<GW_Volunteers__Volunteer_Shift__c> updtVolunteerShifts);
}
