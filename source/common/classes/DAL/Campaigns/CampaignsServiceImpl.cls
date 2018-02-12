/*
* This class contains the implementation of the service method in CampaignsRouterService
*/
public class CampaignsServiceImpl implements ICampaignsService {
	/*
	* Summary:
	*	Get a list of CmapaignDTOs from the most parent level campaigns
	*
	* Returns: 
	*	A list of CampaignService.campaignDTO
	*/
	public List<CampaignService.CampaignDTO> getTopLevelVolunteerCampaigns(){
		List<Campaign> campaignList = CampaignsSelector.newInstance().selectTopLevelVolunteerCampaigns();
		CampaignService.CampaignDTOFactory factory = new CampaignService.CampaignDTOFactory();
		for(Campaign c : campaignList){
			factory.add(c);
		}
		return factory.CampaignDTOs;
	}
	
	/*
	* Description:
	*	Get list of Campaigns that need to be processed.
	*
	* Returns:
	*	A list of Campaign records
	*/	
	public List<Campaign> getTopLevelVolunteerCampaignsForProcessing() {
		return CampaignsSelector.newInstance().selectTopLevelVolunteerCampaignsForProcessing();
	}
	
	/*
	* Description:
	*	Update the campaigns setting the processed flag to true.
	* 
	* Inputs:
	*	updtCampaigns - list of compaigns with mongoId already set.
	*/
	public void setMongoIds(List<Campaign> updtCampaigns) {
		// disable trigger to prevent processed__c being set to false.
		fflib_SObjectDomain.getTriggerEvent(Campaigns.class).disableBeforeUpdate();
		
		// update objects - mongoId and processed flag
		fflib_ISobjectUnitOfWork uow = App.UnitOfWork.newInstance();
		for(Campaign c : updtCampaigns) {
			c.processed__c = true;
			system.debug('Campaign: ' + c);
			uow.registerDirty(c);
		}
		
		uow.commitWork();		
	}
}