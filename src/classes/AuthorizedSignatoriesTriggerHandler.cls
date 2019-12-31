public class AuthorizedSignatoriesTriggerHandler {
	public static void deleteAppDocuments(Map<Id,Application_Authorized_Signatories__c> oldMap ){
        try{
            delete [select Id from Application_Documents__c where Application_Authorized_Signatory__c in: oldMap.keySet()];
        }catch(Exception e){
            system.debug('Error deleting Application Documents: '+e.getMessage());
        }
    }
}