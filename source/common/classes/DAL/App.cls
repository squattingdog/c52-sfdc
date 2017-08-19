public class App {
    // Configure And create the UnitOfWorkFactory for this application
	public static final fflib_Application.UnitOfWorkFactory UnitOfWork = 
		New fflib_Application.UnitOfWorkFactory(
						New List<SObjectType>{
							Campaign.SObjectType});
	
	
	// Configure And create the ServiceFactory for this application
	public static final fflib_Application.ServiceFactory Service =
		New fflib_Application.ServiceFactory(
						New Map<Type, Type>{
						ICampaignsService.class => CampaignsServiceImpl.class});
	
	
	// Configure And create the SelectorFactory for this application
	public static final fflib_Application.SelectorFactory Selector =
		New fflib_Application.SelectorFactory(
						New Map<SObjectType, Type>{
							Campaign.SObjectType => CampaignsSelector.class
							,GW_Volunteers__Volunteer_Job__c.SObjectType => VolunteerJobsSelector.class
						});


	// Configure And create the DomainFactory for this application
	public static final fflib_Application.DomainFactory Domain = 
		New fflib_Application.DomainFactory(
			App.Selector,
			New Map<SObjectType, Type>{
				Campaign.SObjectType => Campaigns.Constructor.class});
}
