global with sharing class PostInstall implements InstallHandler {
	global void onInstall(InstallContext context) {
		Priming.prime(context);
	}
}
