@IsTest
public class AccountProcessorTest {
    public static testmethod void TestAccountProcessorTest() {
        Account a = new Account();
        a.Name = 'Bob Account';
        Insert a;

        Contact c = New Contact();
        c.FirstName ='Bob';
        c.LastName ='Masters';
        c.AccountId = a.Id;
        Insert c;

        List<Id> acctId = new List<Id>();
        acctId.add(a.Id);

        Test.startTest();
            AccountProcessor.countContacts(acctId);
        Test.stopTest();

        Account acct = [SELECT Number_Of_Contacts__c FROM Account
                        WHERE Id = :a.Id LIMIT 1];
        System.assertEquals(Integer.valueOf(acct.Number_Of_Contacts__c), 1);
    }    
}