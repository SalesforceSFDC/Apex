public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts)
                                    FROM Account 
                                    WHERE Id 
                                    IN :accountIds];
        // process account records
        for (Account a : accounts) {
            List<Contact> c = a.Contacts;
            a.Number_of_Contacts__c = c.size();
        }
        update accounts;
    }
}