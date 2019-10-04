@isTest
public class AuthorizedSignatoriesTriggerHandlerTest {
	static testMethod void testAuthorizedSignatoriesTriggerHandler(){
        Application__c app = new Application__c (); 
        insert app;
        Application_Authorized_Signatories__c aas = new Application_Authorized_Signatories__c();
        aas.Application__c = app.Id;
        insert aas;
        Application_Documents__c ad = new Application_Documents__c();
        ad.Application_Authorized_Signatory__c = aas.Id;
        ad.Application__c = app.Id;
        insert ad;
        Test.startTest();
        delete aas;
        Test.stopTest();
    }
}