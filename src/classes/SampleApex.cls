// Create the account sobject
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);

// Insert the account by using DML
insert acct;

// Get the Id for the inserted account
ID myId = acct.Id;

// Display this Id in the debug log
System.debug('Accoint ID is ' + myId);

/** ===========================  */
// Create a List of Contacts
List<Contact> conList = new List<Contact> {
    new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
    new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
    new Contact(FirstName='Kim',LastName='Shain',Department='Education')
};

// Bulk insert all contacts with one DML call
insert conList;

// List for holding new contacts to update
List<Contact> listToUpdate = new List<Contact>();

// Iterate through the List and add a title only if the department is finance
for (Contact con : conList) {
    if (con.Department == 'Finance') {
        con.Title = 'Financial Analyst';

        // Add updated Contact sObject to the List
        listToUpdate.add(con);
    }
}

// Bulk update all Contacts with one DML call
update listToUpdate;
/** ===========================  */

upsert sObjectList Account.Fields.MyExternalId;

// Create Kathy contact but do not persist it in the database
Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');

// List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> { kathy };

// Call upsert
upsert contacts;
/** ===========================  */
// Email field has idLookup property set

Account[] accts = [SELECT Name,Phone FROM Account
                   WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10];
System.debug(accts.size() + ' account(s) returned.');
// Write all account array info
System.debug(accts);


String targetDepartment = 'Wingo';
Contact[] techContacts = [SELECT FirstName,LastName
                          FROM Contact WHERE Department=:targetDepartment];
