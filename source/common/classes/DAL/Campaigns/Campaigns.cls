/**
*	The Campaign Domain class which creates a domain model around sObject collections
**/

Public With sharing Class Campaigns extends fflib_SObjectDomain Implements ICampaigns {
	
	/*
	* Parameters:
	* 	List<Campaign> sObjectList - list of Campaigns
	* Output:
	*   mktgICampaigns - Campaigns Domain interface
	* Description:
	* 	returns a New instance of the mktg_Campaigns class cast as its interface
	*/
	Public Static ICampaigns newInstance(List<Campaign> sObjectList) {
		Return (ICampaigns)App.Domain.newInstance(sObjectList);
	}

	/*
	* Constructor
	* Parameters:
	* 	List<Campaign> sObjectList - list of Campaigns
	* Description:
	* 	Domain classes are initialized with lists to enforce bulkification throughout
	*/
	Public Campaigns(List < Campaign > sObjectList) {
		super(sObjectList);
	}

	/*
	* This class Is used by the app to return a New instance of the mktg_Campaigns class
	*/
	Public Class Constructor Implements fflib_SObjectDomain.IConstructable {

		/*
		* Parameters:
		* 	List<Campaign> sObjectList - list of Campaigns
		* Output:
		*   fflib_SObjectDomain - fflib_SObjectDomain as mktg_Campaigns class
		* Description:
		* 	returns a New instance of fflib_SObjectDomain as the mktg_Campaigns class
		*/
		Public fflib_SObjectDomain construct(List<SObject> sObjectList){
			Return New Campaigns(sObjectList);
		}
	}
	
}