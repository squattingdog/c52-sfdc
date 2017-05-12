/*
* This class can be used to access methods in theCampaignsSelector And CampaignsServiceImpl
*/
Global With sharing Class CampaignService {	

	Private Static CampaignService instance;
	Private Static Boolean allowConstruct = False;

	// throws error if attempted to access instance through constructor
	Global CampaignService(){
		If (!allowConstruct){
			Throw New SingletonException();
		}
	}

	/*
	* Output: CampaignService -instance of the class 
	* Description: This method allows the Object To be accessed from 
	* 	a static context, And allows instance methods to be called on it
	*/
	Global Static CampaignService getInstance(){
		If (instance == null){
            allowConstruct = True;
            instance = New CampaignService();
            allowConstruct = False;
        }             
        Return instance;
    }
	/*
	* Output: CampaignService -instance of the class 
	* Description: This method allows the Object To be accessed from 
	* 	a static context, And allows instance methods to be called on it
	*/
	@TestVisible
	Private Static void setMock(CampaignService i){
		instance = i;
	}

	/*
    * Description: 
    *   This method provides access to the selectTopLevelVolunteerCampaigns in the CampaignsSelector, And
    *   has identical inputs And outputs
    */
    Global List<Campaign> selectTopLevelVolunteerCampaigns() {
        Return selector().selectTopLevelVolunteerCampaigns();
    }

	/*
	* Output:
	* 	ICampaignsService - an instance of CampaignsServiceImpl cast as it's interface
	* Description:
	* 	This method provides access to CampaignsServiceImpl class defined in the app
	*/
	Private ICampaignsService service() {
		Return (ICampaignsService) App.Service.newInstance(ICampaignsService.Class);
	}

    /*
	* Output:
	* 	ICampaignsService - an instance of CampaignsSelector cast as it's interface
	* Description:
	* 	This method provides access to CampaignsSelector class defined in the app
	*/
	Private ICampaignsSelector selector() {
		Return CampaignsSelector.newInstance();
	}

}