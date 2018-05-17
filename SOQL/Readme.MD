# SOQL

* `Account[] accts = [SELECT Name,Phone FROM Account];`
* Sample queries:
```Apex
// Add account and related contact
Account acct = new Account(
    Name='SFDC Computing',
    Phone='(415)555-1212',
    NumberOfEmployees=50,
    BillingCity='San Francisco');
insert acct;
// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact con = new Contact(
    FirstName='Carol',
    LastName='Ruiz',
    Phone='(415)555-1212',
    Department='Wingo',
    AccountId=acctID);
insert con;
// Add account with no contact
Account acct2 = new Account(
    Name='The SFDC Query Man',
    Phone='(310)555-1213',
    NumberOfEmployees=50,
    BillingCity='Los Angeles',
    Description='Expert in wing technologies.');
insert acct2;

```
* You don’t need to specify the Id field in the query as it is always returned in Apex queries, whether it is specified in the query or not. For example: SELECT Id,Phone FROM Account and SELECT Phone FROM Account are equivalent statements. The only time you may want to specify the Id field if it is the only field you’re retrieving because you have to list at least one field: SELECT Id FROM Account. You may want to specify the Id field also when running a query in the Query Editor as the ID field won’t be displayed unless specified.
* `SELECT Name,Phone FROM Account WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)`
* `SELECT Name,Phone FROM Account WHERE (Name='SFDC Computing' OR (NumberOfEmployees>25 AND BillingCity='Los Angeles'))`
* `SELECT Name,Phone FROM Account ORDER BY Name`
* `SELECT Name,Phone FROM Account ORDER BY Name ASC`
* `SELECT Name,Phone FROM Account ORDER BY Name DESC`
* `Account oneAccountOnly = [SELECT Name,Phone FROM Account LIMIT 1];`
```Apex
SELECT Name,Phone FROM Account 
                   WHERE (Name = 'SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10
```
```Apex
Account[] accts = [SELECT Name,Phone FROM Account 
                   WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10];
System.debug(accts.size() + ' account(s) returned.');
// Write all account array info
System.debug(accts);
```
