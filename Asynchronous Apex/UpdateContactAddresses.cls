/**
 * Business requirement:
 *  all contacts for companies in the USA must have their parent company’s billing address as their mailing address.
 * sample class finds all account records that are passed in by the start() method using a QueryLocator and updates the
 * associated contacts with their account’s mailing address. Finally, it sends off an email with the results of the bulk job and,* since we are using Database.Stateful to track state, the number of records updated.
 */
global class UpdateContactAddresses implements Database.batchable<sObject>, Database.stateful {

    //instance member variable to retain state across transactions
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }
 }
