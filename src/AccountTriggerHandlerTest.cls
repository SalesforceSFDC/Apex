@isTest
private class AccountTriggerHandlerTest {
	@testSetup static void methodName() {
        Id institutionalSalesLeadId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Institutional Sales Lead').getRecordTypeId();
        Lead ld = new Lead();
        ld.Company = 'Test Company';
        ld.LastName = 'Test Last Name';
        ld.Email = 'test@test.test';
        ld.Reference_ID__c = 'Ref123ID';
        ld.RecordTypeId = institutionalSalesLeadId;
        insert ld;
        Id RECORDTYPE_1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Institutional Entity Account').getRecordTypeId();
        Account a = new Account();
        a.Name = 'Test Account';
        a.RecordTypeId = RECORDTYPE_1;
        insert a;

        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Test';
        c.Email = 'test@contact.com';
        c.AccountId = a.Id;
        insert c;

        Id recTypeId1 = Schema.SObjectType.Interest_Form__c.getRecordTypeInfosByName().get('Institutional Investor').getRecordTypeId();
        Interest_Form__c iForm = new Interest_Form__c();
        iForm.RecordTypeId = recTypeId1;
        iForm.Sub_Type__c = 'Bank / Financial Institution';
        iForm.Crypto_monthly_trading_volumes__c = '$100-500k';
        iForm.First_Name__c = 'First';
        iForm.Last_Name__c = 'Last';
        iForm.Phone__c = '1234567890';
        iForm.Email__c = 'test@email.com';
        iForm.Firm_Location__c = 'United States';
        iForm.Name_of_Firm__c = 'Name of Firm';
        iForm.Coinbase_Products_Services_of_Interest__c = 'Coinbase Prime (institutional trading platform)';
        insert iForm;

        a.Applying_Contact__c = c.Id;
        a.Interest_Form__c = iForm.Id;
        update a;
    }
	
	@isTest static void test_method_one() {
		Account acc = [select id from Account limit 1];
		acc.Send_Application__c = true;
        acc.Application_Sent__c = true;
        acc.HashedAccountName__c=null;
		update acc;
	}
	
	@isTest static void test_method_two() {
		Account acc = [select id from Account limit 1];
		acc.Send_Application__c = true;
        acc.Application_Sent__c = true; 
		acc.Interest_Form__c = null;
		update acc;
	}
}