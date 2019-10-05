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
 
