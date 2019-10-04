// Create master account
Account master = new Account(Name='Account1');
insert master;

// Create duplicate accounts
Account[] duplicates = new Account[]{
    // Duplicate account 
    new Account(Name='Account1, Inc.'),
    // Second duplicate account
    new Account(Name='Account 1')
};
insert duplicates;

// Create child contact and associate it with first account
Contact c = new Contact(firstname='Joe',lastname='Smith', accountId=duplicates[0].Id);
insert c;



// Get the account contact relation ID, which is created when a contact is created on "Account1, Inc." 
AccountContactRelationID resultAcrel = [SELECT Id FROM AccountContactRelation WHERE ContactId=:c.Id LIMIT 1];


// Merge accounts into master
Database.MergeResult[] results = Database.merge(master, duplicates, false);

for(Database.MergeResult res : results) {
    if (res.isSuccess()) {
        // Get the master ID from the result and validate it
        System.debug('Master record ID: ' + res.getId());
        System.assertEquals(master.Id, res.getId());              
        
        // Get the IDs of the merged records and display them
        List<Id> mergedIds = res.getMergedRecordIds();
        System.debug('IDs of merged records: ' + mergedIds);                
        
        // Get the ID of the reparented record and 
        // validate that this the contact ID.
        System.debug('Reparented record ID: ' + res.getUpdatedRelatedIds());

	 // Make sure there are two IDs (contact ID and account contact relation ID); the order isn't defined
        System.assertEquals(2, res.getUpdatedRelatedIds().size() );    
        boolean flag1 = false;
	boolean flag2 = false;


    	// Because the order of the IDs isn't defined, the ID can be at index 0 or 1 of the array	     
        if (resultAcrel.id == res.getUpdatedRelatedIds()[0] || resultAcrel.id == res.getUpdatedRelatedIds()[1] )
            	flag1 = true;
        
       if (c.id == res.getUpdatedRelatedIds()[0] || c.id == res.getUpdatedRelatedIds()[1] )
            flag2 = true;
            
        System.assertEquals(flag1, true); 
        System.assertEquals(flag2, true);  
            
    }
    else {
        for(Database.Error err : res.getErrors()) {
            // Write each error to the debug output
            System.debug(err.getMessage());
        }
    }
}
