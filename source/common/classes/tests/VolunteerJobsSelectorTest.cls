@isTest
public class VolunteerJobsSelectorTest {
	static testMethod void testSelectById() {
		Test.startTest();
		
		//disable campaign and volunteerJob triggers
		fflib_SObjectDomain.getTriggerEvent(Campaigns.class).disableAll();
		fflib_SObjectDomain.getTriggerEvent(VolunteerJobs.class).disableAll();
		
		//test data
		//insert the campaigns
		List<Campaign> campaignObjs = new List<Campaign>();		
		campaignObjs.add(ObjectsHelper.getCampaign(
			'test campaign'
			,true	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));		
		insert campaignObjs;
		
		//insert the jobs
		List<GW_Volunteers__Volunteer_Job__c> gwvvJobs = new List<GW_Volunteers__Volunteer_Job__c>();
		gwvvJobs.add(ObjectsHelper.getGWVolunteersVolunteerJob(
			'test job'
			,campaignObjs[0].id
			,false	//processed
			,false	//include for web
		));
		insert gwvvJobs;
		
		//test
		List<GW_Volunteers__Volunteer_Job__c> jobs = VolunteerJobsSelector.newInstance().selectById(new Set<Id> { gwvvJobs[0].id });

		//assert
		System.assertEquals(1, jobs.size(), 'VolunteerJobsSelectorTest::testSelectById - invalid size.');
		System.assertEquals('test job', jobs[0].name, 'VolunteerJobsSelectorTest::testSelectById - invalid name.');
		
		Test.stopTest();
	}
	
	static testMethod void testSelectByCampaignId() {
		Test.startTest();
		
		//disable campaign and volunteerJob triggers
		fflib_SObjectDomain.getTriggerEvent(Campaigns.class).disableAll();
		fflib_SObjectDomain.getTriggerEvent(VolunteerJobs.class).disableAll();
		
		//test data
		//insert the campaigns
		List<Campaign> campaignObjs = new List<Campaign>();		
		campaignObjs.add(ObjectsHelper.getCampaign(
			'test campaign'
			,true	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'child campaign'
			,true	//include for web
			,false	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));		
		insert campaignObjs;
		
		//insert the jobs
		List<GW_Volunteers__Volunteer_Job__c> gwvvJobs = new List<GW_Volunteers__Volunteer_Job__c>();
		gwvvJobs.add(ObjectsHelper.getGWVolunteersVolunteerJob(
			'valid job'
			,campaignObjs[0].id
			,false	//processed
			,false	//include for web
		));
		gwvvJobs.add(ObjectsHelper.getGWVolunteersVolunteerJob(
			'do not return job'
			,campaignObjs[1].id
			,false	//processed
			,false	//include for web
		));
		insert gwvvJobs;
		
		//test
		List<GW_Volunteers__Volunteer_Job__c> jobs = VolunteerJobsSelector.newInstance().selectByCampaignId(new Set<ID> { campaignObjs[0].id });		
		
		//assert
		System.assertEquals(1, jobs.size(), 'VolunteerJobsSelectorTest::testSelectByCampaignId - invalid size.');
		System.assertEquals('valid job', jobs[0].name, 'VolunteerJobsSelectorTest::testSelectByCampaignId - invalid name.');

		Test.stopTest();
	}
	
	static testMethod void testSelectJobsForProcessing() {
		Test.startTest();
		
		//disable campaign and volunteerJob triggers
		fflib_SObjectDomain.getTriggerEvent(Campaigns.class).disableAll();
		fflib_SObjectDomain.getTriggerEvent(VolunteerJobs.class).disableAll();
		
		//test data
		//insert the campaigns
		List<Campaign> campaignObjs = new List<Campaign>();		
		campaignObjs.add(ObjectsHelper.getCampaign(
			'test campaign'
			,true	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'child campaign'
			,true	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));		
		insert campaignObjs;
		
		//insert the jobs
		List<GW_Volunteers__Volunteer_Job__c> gwvvJobs = new List<GW_Volunteers__Volunteer_Job__c>();
		gwvvJobs.add(ObjectsHelper.getGWVolunteersVolunteerJob(
			'valid job'
			,campaignObjs[0].id
			,false	//processed
			,true	//include for web
		));
		gwvvJobs.add(ObjectsHelper.getGWVolunteersVolunteerJob(
			'do not return job'
			,campaignObjs[1].id
			,true	//processed
			,true	//include for web
		));
		insert gwvvJobs;
		
		//test
		List<GW_Volunteers__Volunteer_Job__c> jobs = VolunteerJobsSelector.newInstance().selectJobsForProcessing();
		
		//assert
		System.assertEquals(1, jobs.size(), 'VolunteerJobsSelectorTest::testSelectJobsForProcessing - invalid size.');
		System.assertEquals('valid job', jobs[0].name, 'VolunteerJobsSelectorTest::testSelectJobsForProcessing - invalid name');
		
		Test.stopTest();
	}
}
