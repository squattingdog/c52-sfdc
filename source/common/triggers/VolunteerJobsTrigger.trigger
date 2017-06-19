trigger VolunteerJobsTrigger on GW_Volunteers__Volunteer_Job__c (
	after delete, after insert, after update, before delete, before insert, before update) {

	// Creates Domain class instance and calls apprpoprite overideable methods according to Trigger state
	fflib_SObjectDomain.triggerHandler(VolunteerJobs.class);
}
