trigger SoqlTriggerBulk on Account (after update) {
    // Perform SOQL query once
    // Get the accounts and there relates opps
    List<Account> acctsWithOpps = 
        [SELECT Id, (SELECT Id, Name, CloseDate FROM Opportunities)
            FROM Account WHERE Id IN :Trigger.New];
    
    // Iterate over the returned accounts
    for (Account a : acctsWithOpps) {
        Opportunity[] relatedOpps = a.Opportunities;
    }
}

/**
The SOQL query is connected to the trigger context 
records by using
the `IN` clause and binding the `Trigger.New` variable
in the `WHERE` clause - `WHERE Id IN :Trigger.New`.

The `WHERE` condition filters the accounts to only those
records that fired the trigger.

Combining the two parts in the query results in the 
records we want in one call: the accounts in this 
trigger with the related opportunities of each account.

After the records and their related records are obtained,
the for loop iterates over the records of interest by using
the collection variable - in this case: `acctsWithOpps`.

The collection variable holds the results of the SOQL query.
The For Loop iterates only over the records we want to 
operate on.
*/


/**
 * Retrieve only the opportunities that are related to 
 * the accounts within the trigger context.  

 This list is specified in the WHERE clause by matching the 
 AccountId field of the opportunity to the ID of accounts
 in `Trigger.New`:`WHERE AccountId IN :Trigger.New`.

 Example shows query to get all related opps 
*/ 
trigger SoqlTriggerBulk on Account (after update) {
    // Perform SOQL query once
    // Get the related opps for the accounts 
    // and iterate over those records
    for (Opportunity opp : 
        [SELECT Id, Name, CloseDate FROM Opportunity
            WHERE AccountId IN :Trigger.New]){
                // do some other process
            }
}

/**
Triggers execute on batches of 200 records at a time.
If 400 records cause a trigger to fire, the trigger fires twice,
once for each 200 records.

SOQL for loop record batching
 */

 /**
When performing DML calls in a trigger or in a class,
perform DML calls on a collection of sObjects when possible.

Apex runtime allows up to 150 DML calls in one transaction.

This example performs an update call inside a for loop that
iterates over related opps.

It adds the Opp sObject to update to a list of opportunities
(oppsToUpdate) in the loop.

Nest, the trigger performs the DML call outside the loop on this
list after all opps have been added to the list.

This pattern uses only one DML call regardless of the number of 
sObjects being updated.
 */
trigger DmlTriggerBulk on Account(after update) {
    // Get the related opps for the accounts
    List<Opportunity> relatedOpps = [SELECT Id, Name, Probability
        FROM Opportunity WHERE AccountId IN :Trigger.New];

    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    // Iterate over the related opportunities
    for (Opportunity opp : relatedOpps) {
        // Update the description when probability is greater 
        // than 50% but less than 100%
         if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            oppsToUpdate.add(opp);
         }
    }

    // Perform DML on a collection
    update oppsToUpdate;
}


/**
With `After` Trigger we can query the affected records from the database
SOQL query that returns all accounts in this trigger that don’t have related opportunities:
 */
 [SELECT Id,Name FROM Account WHERE Id IN :Trigger.New AND
                                             Id NOT IN (SELECT AccountId FROM Opportunity)]
// iterate over those records by using a SOQL for loop
for(Account a : [SELECT Id,Name FROM Account WHERE Id IN :Trigger.New AND
                                         Id NOT IN (SELECT AccountId FROM Opportunity)]){
}

trigger AddRelatedRecord on Account(after insert, after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    for (Account a : [SELECT Id,Name FROM Account
                     WHERE Id IN :Trigger.New AND
                     Id NOT IN (SELECT AccountId FROM Opportunity)]) {
        // Add a default opportunity for this account
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                   StageName='Prospecting',
                                   CloseDate=System.today().addMonths(1),
                                   AccountId=a.Id)); 
    }
    
    if (oppList.size() > 0) {
        insert oppList;
    }
}



