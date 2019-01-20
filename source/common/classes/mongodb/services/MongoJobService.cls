public class MongoJobService extends MongoServiceBase {
	private static Boolean isEnabled = true;
	
	/*
	* Description: 
	*	override superclass disable method.
	*	disables this class so that the methods do not process data.
	*/
	public static void disable() {
		isEnabled = false;
	}
	
	/*
	* Description:
	*	Entry point to send VolunteerJob data from SFDC to MongoDB
	*   	This will retrieve the VolunteerJobs and send them to MongoDB
	*/
	public static void syncVolunteerJobs() {
		// return if not enabled
		If(!isEnabled)
			return;
		
		// get the list of volunteer jobs to sync and instantiate VolunteerJobs domain object.
		List<GW_Volunteers__Volunteer_Job__c> jobs = VolunteerJobsSelector.newInstance().selectJobsForProcessing();
		
		// return if there are not any records to update
		if(jobs.size() < 1) {
			return;
		}

		VolunteerJobs dVolJobs = new VolunteerJobs(jobs);

		
		// convert sObjects to DTOs
		VolunteerJobsService.VolunteerJobDTOFactory jobFactory = new VolunteerJobsService.VolunteerJobDTOFactory();
		dVolJobs.generate(jobFactory);
		// send to mongoDB
		MongoJob response = insertMongoDBVolunteerJobs(jobFactory.volunteerJobDTOs);
		
		if(response.status == Constants.MONGO_RESPONSE_SUCCESS_STATUS) {
			// convert the response to SObjects
			List<GW_Volunteers__Volunteer_Job__c> updtVolunteerJobs = 
				(List<GW_Volunteers__Volunteer_Job__c>)MongoModelConverter.convertMongoModel(response);
			// update the VolunteerJobs with mongoDB IDs
			VolunteerJobsService.getInstance().setMongoIds(updtVolunteerJobs);
		} else {
			// Log error
			System.debug(response);	
		}
	}
	
	/*
	* Description:
	*	handles the connection to mongo using POST methods to sync data from sfdc to mongodb
	* Params:
	*	jobDTOs - the VolunteerJob data to post
	* Returns:
	*	MongoJob - the mongo response model object.
	*/
	public static MongoJob insertMongoDBVolunteerJobs(List<VolunteerJobsService.VolunteerJobDTO> jobDTOs) {
		// return if not enabled
		If(!isEnabled)
			return null;

		// get the http client
		ffhttp_c52Mongo mongoClient = MongoServicebase.getC52MongoClient();
		// get the VolunteerJobs resource
		ffhttp_C52MongoJobs mongoJobs = mongoClient.volunteerJobs();
		// setup the request object
		ffhttp_C52MongoJobs.VolunteerJobsPostRequest request = 
			mongoJobs.getVolunteerJobsPostRequest(blob.valueOf(JSON.serialize(jobDTOs)));
		// send the request and capture the response.
		MongoJob responseJobs = (MongoJob)request.execute();
		
		return responseJobs;
	}
}
