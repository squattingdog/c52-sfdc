@isTest
public class CampaignsSelectorTest {
	static testMethod void testSelectById() {
		Test.startTest();
		
		//disable campaign trigger to mongoDB
		Campaigns.setSyncRecordsEnabled(false);
		
		//test data
		//setup a parent campaign
		Campaign parentCampaign = ObjectsHelper.getCampaign(
			'parent'
			,true	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		);
		insert parentCampaign;
		
		//setup the campaigns for the selector
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
			,parentCampaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		
		insert campaignObjs;
		
		//test
		List<Campaign> camps = CampaignsSelector.newInstance().selectByID(new Set<ID> { campaignObjs[0].id });
		
		//assert
		System.assertEquals(1, camps.size());
		System.assertEquals('test campaign', camps[0].Name);
		
		Test.stopTest();
	}
	
	static testMethod void testSelectTopLevelVolunteerCampaigns() {
		Test.startTest();
		
		//disable campaign trigger to mongoDB
		Campaigns.setSyncRecordsEnabled(false);
		
		//test data
		//setup a parent campaign
		Campaign parentCampaign = ObjectsHelper.getCampaign(
			'parent'
			,true	//include for web
			,true	//processed
			,null	//parent campaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		);
		insert parentCampaign;
		
		//setup selector campaigns
		List<Campaign> campaignObjs = new List<Campaign>();		
		campaignObjs.add(ObjectsHelper.getCampaign(
			'test campaign'
			,true	//include for web
			,true	//processed
			,parentCampaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'other campaign'
			,true	//include for web
			,false	//processed
			,parentCampaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'another campaign'
			,false	//include for web
			,false	//processed
			,parentCampaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		
		//test
		List<Campaign> camps = CampaignsSelector.newInstance().selectTopLevelVolunteerCampaigns();
		
		//assert
		System.assertEquals(1, camps.size());
		System.assertEquals('parent', camps[0].Name);
				
		Test.stopTest();
	}
	
	static testMethod void testSelectTopLevelVolunteerCampaignsForProcessing() {
		Test.startTest();
		
		//disable campaign trigger to mongoDB
		Campaigns.setSyncRecordsEnabled(false);
		
		//test data
		Campaign parentCampaign = ObjectsHelper.getCampaign(
			'parent'
			,false	//include for web
			,false	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		);
		insert parentCampaign;
		
		//setup selector campaigns
		List<Campaign> campaignObjs = new List<Campaign>();
		
		campaignObjs.add(ObjectsHelper.getCampaign(
			'test campaign'
			,true	//include for web
			,false	//processed
			,parentCampaign
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'needs processing campaign'
			,true	//include for web
			,false	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		campaignObjs.add(ObjectsHelper.getCampaign(
			'do not return campaign'
			,false	//include for web
			,true	//processed
			,null
			,Constants.RECORD_TYPE_VOLUNTEER_CAMPAIGN
		));
		
		//test
		List<Campaign> camps = CampaignsSelector.newInstance().selectTopLevelVolunteerCampaignsForProcessing();
		
		//assert
		System.assertEquals(1, camps.size());
		System.assertEquals('needs processing campaign', camps[0].Name);
				
		Test.stopTest();
	}
}
