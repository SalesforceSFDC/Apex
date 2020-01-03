global class AccountContactDifferentOwnerBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Account.OwnerId, OwnerId ' +
            'FROM Contact ' + 
            'WHERE AccountId != null AND Different_Owner_Than_in_Account__c = true LIMIT 400'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        for (Contact contact : scope) {
            contact.OwnerId = contact.Account.OwnerId;
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext bc){
    }
    
}

/**
Id batchJobId = Database.executeBatch(new RunThisBatch(), 200);

Id batchJobId = Database.executeBatch(new AutoInviteLeadsBatch(), 10);
System.debug(batchJobId);

AccountContactDifferentOwnerBatch batch = new AccountContactDifferentOwnerBatch();
Database.executeBatch(batch, 250);
 */