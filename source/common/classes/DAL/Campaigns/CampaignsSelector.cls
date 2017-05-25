public Class CampaignsSelector  extends fflib_SObjectSelector implements ICampaignsSelector {

	/*
	* Output:
	* 	ICampaignsSelector - instance of ICampaignsSelector
	* Description:
	* 	This method returns an instance of CampaignsSelector cast as the 
	*   interface ICampaignsSelector
	*/
	public Static ICampaignsSelector newInstance() {
		Return (ICampaignsSelector)App.Selector.newInstance(Campaign.SObjectType);
	}

	/*
	* Output:
	* 	Schema.SObjectField - returns the specified campaign fields for this selector
	* Description:
	*   This method returns the list of campaign fields 
	*/
	public List<Schema.SObjectField> getSObjectFieldList() {
		Return New List <Schema.SObjectField> {
            Campaign.Id,
            Campaign.Name,
            Campaign.Description,
            Campaign.LogoUrl__c,
            Campaign.Parent.Id,
			Campaign.IncludeForWebMobile__c
        };
	}

	/*
	* Output:
	* 	Schema.sObjectType - returns the selector type, in this case, a campaign  	
	* Description:
	*   This method returns the sObject Type of this selector, which Is campaign
	*/
	public Schema.SObjectType getSObjectType() { 
		Return Campaign.SObjectType;
	}

	/***
	*  ICampaignSelector implementations
	***/
	
	/*
	* Parameters:
	* 	Set<Id> idSet - list of campaign Ids to be selected on
	* Output:
	* 	List<Campaign> - list of campaigns including attributes specified in the selector
	* Description:
	*   This method returns a list of campaigns with the fields specified in the field list
	*   for this selector
	*/
	public List<Campaign> selectById(Set<Id> idSet){
		return (List<Campaign>)selectSObjectsById(idSet);
	}

	/*
	* Output:
	* 	List<Campaign> - list of campaigns including attributes specified in the selector
	* Description:
	*   This method returns a list of Volunteer Campaign record type campaigns 
	*   where the parent is null.
	*   It includes the fields specified in the field list for this selector.
	*/
	public List<Campaign> selectTopLevelVolunteerCampaigns() {
        return (List<Campaign>)Database.query(
			newQueryFactory().
			setCondition('RecordType.Name = \'Volunteer Campaign\' AND Parent.ID = null AND IncludeForWebMobile__c = true')
			.toSoql());
	}
}
