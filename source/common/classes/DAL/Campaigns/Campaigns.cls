/**
*	The Campaign Domain class which creates a domain model around sObject collections
**/

public with sharing class Campaigns extends fflib_SObjectDomain implements ICampaigns, CampaignService.ISupportCampaignDTO {	
	/*
	* Parameters:
	* 	List<Campaign> sObjectList - list of Campaigns
	* Output:
	*   mktgICampaigns - Campaigns Domain interface
	* Description:
	* 	returns a New instance of the mktg_Campaigns class cast as its interface
	*/
	public static ICampaigns newInstance(List<Campaign> sObjectList) {
		Return (ICampaigns)App.Domain.newInstance(sObjectList);
	}
	
	/*
	* Property used to toggle the triggered http data sync
	*/
	private static Boolean syncEnabled = true;
	public static void setSyncRecordsEnabled(Boolean val) {
		syncEnabled = val;
	}

	/*
	* Constructor
	* Parameters:
	* 	List<Campaign> sObjectList - list of Campaigns
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	public Campaigns(List<Campaign> sObjectList) {
		super(sObjectList);
	}

	/*
	* This class Is used by the app to return a New instance of the mktg_Campaigns class
	*/
	public class Constructor implements fflib_SObjectDomain.IConstructable {

		/*
		* Parameters:
		* 	List<Campaign> sObjectList - list of Campaigns
		* Output:
		*   fflib_SObjectDomain - fflib_SObjectDomain as mktg_Campaigns class
		* Description:
		* 	returns a New instance of fflib_SObjectDomain as the mktg_Campaigns class
		*/
		public fflib_SObjectDomain construct(List<SObject> sObjectList){
			return New Campaigns(sObjectList);
		}
	}
	
	/*
	* ISupportCampaignDTO generate impl
	*/
	public void generate(CampaignService.CampaignDTOFactory campaignDTOFactory)	{
		for(Campaign c : (List<Campaign>)this.Records){
			campaignDTOFactory.add(c);
		}
	}
	
	/*******************
	 * Trigger Overrides
	*******************/
	
	/*
	 * After Insert trigger method
	*/
	public override void onAfterInsert() {
		//push data to mongoDB
		if(this.Records.size() > 0 && Campaigns.syncEnabled) {
			System.enqueueJob(new CampaignsQueable());
		}
	}
	
	/*
	* Before update trigger event
	*/
	public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {		
		//set processed flag to false so the record is picked up in sync process.
		for(Campaign c : (List<Campaign>)this.Records) {
			c.processed__c = false;
		}
	}
}