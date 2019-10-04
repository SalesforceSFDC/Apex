public with sharing class ContactController {
@AuraEnabled
    public static List<Contact> getContacts() {
      List<Contact> contacts =
        [SELECT Id, Name, MailingStreet, Phone, Email, LeadSource
          FROM Contact];

          // Add isAccessible() checl
          return contacts;
    }
}

/*
getContacts() - returns all contacts with the selected fields
*/
