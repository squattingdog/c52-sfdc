/*
	The idea here is that Priming.prime() can be called from ExecuteAnonymous and it should
	cycle through all install class methods, in order, to prime data into the dev org.
	
	Alternatively, the PostInstall class will also call it, passing the InstallContext
	which will call all install classes' install methods.
*/

public with sharing class Priming {
	public static void prime(){ prime(null, true, null); }
	public static void prime(String username){ prime(username, true, null); }
	public static void prime(InstallContext context){ prime(null, false, context); }
	
	/**
	* Description: primes the appesttings and other congifurations
	*
	* Params:
	*	username - the string username key used to prime a specific user's settings
	*	isPriming - the boolean used to desinate if this is on package install or exe anon
	*	context - the InstallContext provide on package install
	*
	**/
	private static void prime(String username, boolean isPriming, InstallContext context){
		//initialize the different install class objects
		AppSettingsInstaller appSettings = new AppSettingsInstaller();
		AdminUsersInstaller adminUsers = new AdminUsersInstaller();
		
		if(isPriming){
			//call the class methods, in order to prime data
			appSettings.initialInstall(username);
		}else{
			//in this case, we are doing a package install and need to feed the context to each of the installer classes
			for(IInstallable installer : new List<IInstallable>{ appSettings, adminUsers }){
				installer.install(context);
			}
		}
	}
}
