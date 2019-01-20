trigger VolunteerShiftsTrigger on GW_Volunteers__Volunteer_Shift__c (
	after delete, after insert, after update, before delete, before insert, before update) {

	// Creates Domain class instance and calls apprpoprite overideable methods according to Trigger state
	fflib_SObjectDomain.triggerHandler(VolunteerShifts.class);
}
