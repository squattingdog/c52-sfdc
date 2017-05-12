Public Class CampaignsSelector  extends fflib_SObjectSelector Implements ICampaignsSelector {

	/*
	* Output:
	* 	ICampaignsSelector - instance of ICampaignsSelector
	* Description:
	* 	This method returns an instance of CampaignsSelector cast as the 
	*   interface ICampaignsSelector
	*/
	Public Static ICampaignsSelector newInstance() {
		Return (ICampaignsSelector)App.Selector.newInstance(Campaign.SObjectType);
	}

	/*
	* Output:
	* 	Schema.SObjectField - returns the specified campaign fields for this selector
	* Description:
	*   This method returns the list of campaign fields 
	*/
	Public List<Schema.SObjectField> getSObjectFieldList() {
		Return New List < Schema.SObjectField > {
            Campaign.Id,
            Campaign.Name,
            Campaign.Description,
            Campaign.LogoUrl__c,
            Campaign.Parent.Id
        };
	}

	/*
	* Output:
	* 	Schema.sObjectType - returns the selector type, in this case, a campaign  	
	* Description:
	*   This method returns the sObject Type of this selector, which Is campaign
	*/
	Public Schema.SObjectType getSObjectType() { 
		Return Campaign.SObjectType;
	}

	/***
	*  ICampaignSelector implementations
	***/

	Public List<Campaign> selectTopLevelVolunteerCampaigns() {
        Return New list < Campaign > ();
	}
}
