public class MongoJobShiftService extends MongoServiceBase{
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
	*	Entry point to send VolunteerJobShift data from SFDC to MongoDB
	*   	This will retrieve the VolunteerJobShifts and send them to MongoDB
	*/
	public static void syncVolunteerJobShifts() {
		// return if not enabled
		If(!isEnabled)
			return;
		
		// get the list of volunteer shifts to sync and instantiate VolunteerShifts domain object.
		VolunteerShifts dVolShifts = new VolunteerShifts(VolunteerShiftsSelector.newInstance().selectShiftsForProcessing());
		// convert sObjects to DTOs
		VolunteerShiftsService.VolunteerShiftDTOFactory shiftFactory = new VolunteerShiftsService.VolunteerShiftDTOFactory();
		dVolShifts.generate(shiftFactory);
		// send to mongoDB
		MongoJobShift response = insertMongoDBVolunteerJobShifts(shiftFactory.volunteerShiftDTOs);
		
		if(response.status == Constants.MONGO_RESPONSE_SUCCESS_STATUS) {
			// convert the response to SObjects
			List<GW_Volunteers__Volunteer_Shift__c> updtVolunteerJobs = 
				(List<GW_Volunteers__Volunteer_Shift__c>)MongoModelConverter.convertMongoModel(response);
			// update the VolunteerShifts with mongoDB IDs
			VolunteerShiftsService.getInstance().setMongoIds(updtVolunteerJobs);
		} else {
			// Log error
			System.debug(response);	
		}
	}
	
	/*
	* Description:
	*	handles the connection to mongo using POST methods to sync data from sfdc to mongodb
	* Params:
	*	shiftDTOs - the VolunteerShift data to post
	* Returns:
	*	MongoJob - the mongo response model object.
	*/
	public static MongoJobShift insertMongoDBVolunteerJobShifts(List<VolunteerShiftsService.VolunteerShiftDTO> shiftDTOs) {
		// return if not enabled
		If(!isEnabled)
			return null;

		// get the http client
		ffhttp_c52Mongo mongoClient = MongoServicebase.getC52MongoClient();
		// get the VolunteerJobs resource
		ffhttp_C52MongoJobShifts mongoJobShifts = mongoClient.shifts();
		// setup the request object
		ffhttp_C52MongoJobShifts.VolunteerJobShiftsPostRequest request = 
			mongoJobShifts.getVolunteerJobShiftsPostRequest(blob.valueOf(JSON.serialize(shiftDTOs)));
		// send the request and capture the response.
		MongoJobShift responseShifts = (MongoJobShift)request.execute();
		
		return responseShifts;
	}
}
