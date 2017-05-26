// Insert the Josh contact
Contact josh = new
Contact (FirstName='Josh', LastName='Kaplan', Department='Finance');
insert josh;

// Josh's record has been inserted
//    so the variable josh has now an ID
//    which will be used to match the records by upsert

josh.Description='Josh\'s record has been updated by the upsert operation.';

// Create the Kathy contact, but dont persist it in the database.
// Persistence refers to the characteristic of state that outlives the process that created it.
Contact kathy = new
Contact(FirstName='Kathy', LastName='Brown', Department='Technology');

// List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> { josh, kathy };

// Call upsert
upsert contacts;

// Result: Josh is updated and Kathy is created.
