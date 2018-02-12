public class ffhttp_C52MongoJobs extends ffhttp_C52MongoResource {
	/**
	 * Constructor
	 *
	 * @param service The ffhttp_C52Mongo service.
	 * @return Access to the Jobs API calls.
	 */
	public ffhttp_C52MongoJobs(ffhttp_C52Mongo service) 
	{
		super(service);
	}
	
	/**
	 * /volunteerJobs_post
	 *
	 * Insert Jobs using post semantics. 
	 *
	 */
	 public VolunteerJobsPostRequest getVolunteerJobsPostRequest(Blob jobsJsonContent){
	 	if(jobsJsonContent == null) throw new ffhttp_SystemException(Constants.CALLOUT_CONTENT_NULL);
	 	
	 	ffhttp_BlobContent content = new ffhttp_BlobContent(jobsJsonContent, 'application/json');
	 	return new VolunteerJobsPostRequest(this, content);
	 }
	 
	 
	 
	 /*********************************************************************************************************
	 * API Callout Inner Classes
	 *********************************************************************************************************/
	 /*
	 * Get a VolunteerJobsPostRequest object used to call execute()
	 */
	 public class VolunteerJobsPostRequest extends C52MongoRequest {
	 	VolunteerJobsPostRequest(ffhttp_C52MongoJobs jobs, ffhttp_IHttpContent content) {
	 		super(jobs
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_JOBS
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoJob.class));	 	
	 	}
	 }
	 
	 public class JobsPutRequest extends C52MongoRequest {
	 	JobsPutRequest(ffhttp_C52MongoJobs jobs, string path, ffhttp_IHttpContent content) {
	 		super(jobs
	 			,C52MONGO_URL + C52MONGO_DB + MONGO_JOBS + path
	 			,REQUEST_METHOD_POST
	 			,content
	 			,new ffhttp_JsonDeserializer(MongoJob.class)); 	
	 	}
	 }
}
