public class TT {
  private static String My_Cls {

// Insert new accounts
List<Account> ls = new List<Account>{
    new Account(name='Vuk'),
      new Account(name='Vuk2')
      };
insert ls;

// Queries to get the inserted accounts
Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Vuk' LIMIT 1];
Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Vuk2' LIMIT 1];

// Add a contact to the account to be merged
Contact c = new Contact(FirstName='Joe',LastName='Merged');
c.AccountId = mergeAcct.Id;
insert c;

try {
    merge masterAcct mergeAcct;
} catch (DmlException e) {
    // Process Exception
    System.debug('An unexpected error has occurred: ' + e.getMessage());
}

// Once the account is merged with the master account,
// the related contact should be moved to the master record.
masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts)
              FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
System.assert(masterAcct.getSObjects('Contact').size() > 0);
System.assertEquals('Joe', masterAcct.getSObjects('Contacts')[0].get('FirstName'));
System.assertEquals('Merged', masterAcct.getSObjects('Contacts')[0].get('LastName'));

// Verify that the merge record got deleted.
Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
System.assertEquals(0, result.size());
    }
}
