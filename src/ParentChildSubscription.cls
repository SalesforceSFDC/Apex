public class ParentChildSubscription {

  public static void InsertParentChild(){
    Subscription__c newSubscription = new Subscription__c(
    Account_Code__c='3684451527',);

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
