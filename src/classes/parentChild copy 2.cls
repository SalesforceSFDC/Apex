public class ParentChildSample {

  public static void InsertParentChild(){
    Opportunity newOpportunity = new Opportunity
    Name='OpportunityWithAccountInsert',
    StageName='Prospecting',
    CloseDate=Date.today().addDays(7);

// Create the parent record reference.
// An account with this external ID value already exists.
// This sObject is used only for foreign key reference
// and doesn't contain any other fields.
Account accountReference = new Account(
    MyExtID__c='SAP111111');

// Add the nested account sObject to the opportunity.
newOpportunity.Account = accountReference;

// Create the opportunity.
Database.SaveResult results = Database.insert(newOpportunity);

}
}
