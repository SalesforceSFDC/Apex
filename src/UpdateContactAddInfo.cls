// implement Database.Batchable interface.
// in order to create Database.Batchable interface create an object of this class
// and pass the object to the Database.executeBatch method 
/*
UpdateContactAddInfo updateContactObj = new UpdateContactAddInfo();
Database.executeBatch(batchable);
*/

public class UpdateContactAddInfo implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, BillingStreet, BillingCity, BillingState,' +
            'BillingPostalCode, (SELECT Id, MailingStreet, MailingCity,' +
            'MailingState, MailingPostalCode from Contacts) FROM Account' +
            'WHERE BillingState=\'TX\''
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Contact> contacts = new List<Contact>();
        // scope variable containts all of the methods
        // then iterating over the records, one by one
        for(Account account:scope) {
            for(Contact contact:account.contacts){
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                contacts.add(contact);
            }
        }
        // dml update
        update contacts;
    }

    global void finish(Database.BatchableContext bc){

    }
    
}