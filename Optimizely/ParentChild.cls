public class ParentChild implements Schedulable {

  global void execute(SchedulableContext ctx)   {

  public static void InsertParentChild(){
  // Insert new accounts
List<Account> ls = new List<Account>{
  new Account(name='Acme Inc.'),
      new Account(name='Acme')
      };
insert ls;

// Queries to get the inserted accounts
Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];

// Add a subscription record to the account to be merged
Subscription__c s = new Subscription__c();
c.AccountId = mergeAcct.Id;
insert c;

try {
  merge masterAcct mergeAcct;
} catch (DmlException e) {
  // Process exception
  System.debug('An unexpected error has occurred: ' + e.getMessage());
}

// Once the account is merged with the master account,
// the related subscription should be moved to the master record.
masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Subscription__c)
            FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
System.assert(masterAcct.getSObjects('Subscription__c').size() > 0);
System.assertEquals('Joe', masterAcct.getSObjects('Subscription__c')[0].get('FirstName'));
System.assertEquals('Merged', masterAcct.getSObjects('Subscription__c')[0].get('LastName'));

// Verify that the merge record got deleted
Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
System.assertEquals(0, result.size());
  }
  }
}

Class ParentChild must implement the method: void System.Schedulable.execute(System.SchedulableContext) at line 1 column 14
