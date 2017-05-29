public class VolunteerJobs extends fflib_SObjectDomain implements IVolunteerJobs {
	
	/*
	* Parameters:
	* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
	* Output:
	*   IVolunteerJobs - VolunteerJobs Domain interface
	* Description:
	* 	returns a New instance of the VolunteerJobs class cast as its interface
	*/
	public static IVolunteerJobs newInstance(List<GW_Volunteers__Volunteer_Job__c> sObjectList) {
		Return (IVolunteerJobs)App.Domain.newInstance(sObjectList);
	}

	/*
	* Constructor
	* Parameters:
	* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	public VolunteerJobs(List<GW_Volunteers__Volunteer_Job__c> sObjectList) {
		super(sObjectList);
	}

	/*
	* This class Is used by the app to return a New instance of the VolunteerJobs class
	*/
	public class Constructor implements fflib_SObjectDomain.IConstructable {

		/*
		* Parameters:
		* 	List<GW_Volunteers__Volunteer_Job__c> sObjectList - list of Volunteer Jobs
		* Output:
		*   fflib_SObjectDomain - fflib_SObjectDomain as VolunteerJobs class
		* Description:
		* 	returns a New instance of fflib_SObjectDomain as the VolunteerJobs class
		*/
		public fflib_SObjectDomain construct(List<SObject> sObjectList){
			return New VolunteerJobs(sObjectList);
		}
	}
}
