public with sharing class ffhttp_C52MongoJobShifts extends ffhttp_C52MongoResource {
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_C52Mongo service.
	 * @return Access to the Job Shifts API calls.
	 */
	public ffhttp_C52MongoJobShifts(ffhttp_C52Mongo service) 
	{
		super(service);
	}

	/**
	 * /shifts_post
	 *
	 * Insert Shifts using post semantics. 
	 *
	 */
	 public VolunteerJobShiftsPostRequest getVolunteerJobShiftsPostRequest(Blob jobShiftsJsonContent){
	 	if(jobShiftsJsonContent == null) throw new ffhttp_SystemException(Constants.CALLOUT_CONTENT_NULL);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(jobShiftsJsonContent, 'application/json');
	 	return new VolunteerJobShiftsPostRequest(this, content);
	 }

	 /**
	 * /shift_put
	 *
	 * Update a Shift using put semantics. 
	 *
	 */
	 public VolunteerJobShiftsPutRequest getVolunteerJobShiftsPutRequest(string path, Blob jobShiftsJsonContent){
	 	if(String.isBlank(path)) throw new ffhttp_SystemException(Constants.CALLOUT_PATH_NULL);
	 	if(jobShiftsJsonContent == null) throw new ffhttp_SystemException(Constants.CALLOUT_CONTENT_NULL);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(jobShiftsJsonContent, Constants.CONTENT_TYPE_JSON);
	 	return new VolunteerJobShiftsPutRequest(this, path, content);
	 }
	 
	 
	 
	 /*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	 /*
	 * Get a VolunteerJobShiftsPostRequest object used to call execute()
	 */
	 public class VolunteerJobShiftsPostRequest extends C52MongoRequest {
	 	VolunteerJobShiftsPostRequest(ffhttp_C52MongoJobShifts jobShifts, ffhttp_IHttpContent content) {
	 		super(jobShifts
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_JOBS
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoJobShift.class));	 	
	 	}
	 }
	 
	 /*
	 * Get a VolunteerJobShiftsPUtRequest object used to call execute()
	 */
	 public class VolunteerJobShiftsPutRequest extends C52MongoRequest {
	 	VolunteerJobShiftsPutRequest(ffhttp_C52MongoJobShifts jobShifts, string path, ffhttp_IHttpContent content) {
	 		super(jobShifts
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_JOBS + path
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoJobShift.class)); 	
	 	}
	 }
}
