/**
*	The Campaign Domain class which creates a domain model around sObject collections
**/

public with sharing class Campaigns extends fflib_SObjectDomain 
	implements ICampaigns { //CampaignsService.ISupportCampaignDTO
	
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
	* Constructor
	* Parameters:
	* 	List<Campaign> sObjectList - list of Campaigns
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	public Campaigns(List < Campaign > sObjectList) {
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
	/*public void generate(CampaignDTOFactory campaignDTOFactory)	{
		for(Campaign c : (List<Campaign>)this.Records){
			campaignDTOFactory.add(c);
		}
	}*/
}