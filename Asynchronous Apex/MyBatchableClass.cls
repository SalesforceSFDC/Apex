/**
* the following code creates a batchable class that processes all accounts in an org 
* and then sends an email when it is done
*/
global class MyBatchableClass implements
            Database.Batchable<sObject>,
            Database.Stateful {  
    // Use to record the total number of Accounts processed
    global Integer numOfRecs = 0;
    // Use to gather the records that will be passed to the interface method
    // This method will only be called once and will return either a
    // Database.QueryLocator object or an Iterable that contains the records
    // or objects passed to the job.            
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');                
    }
    // This is where the actual processing occurs as data is chunked into
    // batches and the default batch size is 200.
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            // Do some processing here
            // and then increment the counter variable
            numOfRecs = numOfRecs + 1;
        }     
    }
    // Used to execute any post-processing that may need to happen. This
    // is called only once and after all the batches have finished.
    global void finish(Database.BatchableContext bc) {
        EmailManager.sendMail('someAddress@somewhere.com',
                              numOfRecs + ' Accounts were processed!',
                              'Meet me at the bar for drinks to celebrate');            
    }
}

// invoke the batch class using anonymous code
MyBatchableClass myBatchObject = new MyBatchableClass();
Database.executeBatch(myBatchObject);
