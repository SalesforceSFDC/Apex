public class ParentChildSample {

  public static void InsertParentChild(){
    Opportunity newOpportunity = new Opportunity(
    Name='OpportunityWithAccountInsert',
    StageName='Prospecting',
    CloseDate=Date.today().addDays(7));

// Create the parent record reference.
// An account with this external ID value already exists.
// This sObject is used only for foreign key reference
// and doesn't contain any other fields.
Account accountReference = new Account(
    BillingPostalCode='');

// Add the nested account sObject to the opportunity.
newOpportunity.Account = accountReference;

// Create the opportunity.
Database.SaveResult results = Database.insert(newOpportunity);

  }
}
-------
try {
    // Query for the contact, which has been associated with an account.
    Contact queriedContact = [SELECT Account.Name
                              FROM Contact
                              WHERE FirstName = 'Joe' AND LastName='Smith'
                              LIMIT 1];

    // Update the contact's phone number
    queriedContact.Phone = '415.555.1213';

    // Update the related account industry
    queriedContact.Account.Industry = 'Technology';

    // Make two separate calls
    // 1. This call is to update the contact's phone.
    update queriedContact;
    // 2. This call is to update the related account's Industry field.
    update queriedContact.Account;
} catch(Exception e) {
    System.debug('An unexpected error has occurred: ' + e.getMessage());
}
