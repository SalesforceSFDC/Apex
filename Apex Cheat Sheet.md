## Using Relationship Queries
* Relationship between objects are named
    * Use the parent's singular name to reference the child-to-parent relationship
    * Use the children's name (i.e. plural) to reference the parent-to-child relationship
    * Add the suffix `__r` if the relationship is custom
* Use dot notation to traverse child-to-parent relationships in a query
* Use a nested `SELECT` to retrieve children's fields when traversing from parent to child


* Query child-to-parent relationships:
```apex
SELECT Id, Name, Account.Name
FROM Contact
WHERE Account.Industry = 'media'
```
This query returns the ID and name for only the contacts whose related account industry is media, and for each contact returned, the account name.

* Query parent-to-child:
```apex
SELECT Name,
  (
    SELECT LastName
    FROM Contacts
  )
FROM Account
```
Specify these relationships using a subquery (enclosed in parentheses), where the initial member of the FROM clause in the subquery is related to the initial member of the outer query FROM clause. Note that for standard object subqueries, you should specify the plural name of the object as that is the name of the relationship for each object.

### Write a Child-to-Parent Query (Can go 5 levels up)
This relationship query uses "dot notation" to access data from the parent, that is, a period separates the relationship name from the name of the field being queried.
```sql
SELECT FirstName, LastName, Account.Name FROM Contact
```
* you can traverse five levels up with the dot notation.
* From the child, use dot notation to access the parent's fields:
    * `Parent__r.ParentField`
    ```sql
    SELECT Name, Position__r.Name //(Dot notation:Parent__r.ParentField)
    FROM Job_Application__c //Child object
    ```
In SOQL, use `Dot notation` to retrieve a parent field such as `p.Name`   
#### The default syntax of a custom foreign key relationship:
* Child-to-parent: `Parent Name__r`
* Parent-to-Child: `Children Name__r`

#### The syntax of a standard foreign key relationship
A standard relationship is a predefined foreign key relationship.

### Writing Parent-to-Children Queries (Can go one level down)
```sql
SELECT Name, (Select FirstName, LastName FROM Contacts) FROM Account
```
* When working with relationship queries, the parent-to-child relationship name must be a plural name.
* When working with custom objects, the relationship name is not only plural, but it is appended with two underscores and an r. For example, the relationship name for the custom object `My_Object__c` is `My_Objects__r`.
* From the `parent`, use the relationship name in a nested `SELECT` to access a child's fields.
```sql
SELECT Name, (SELECT Name
              FROM Job_Application__r) // Nested SELECT with parent-to-child relationship name
FROM Position__c //Parent object
```

### Right Anti-Joins in SOQL
In SOQL, a Right Anti Join returns only orphans - children without parents.
```sql
SELECT Name, Status__c 
FROM Job_Application__c
WHERE Position__c = null
```

```sql
SELECT Id, Name
FROM Position__c
WHERE Id NOT IN (SELECT Position__c FROM Job_Application__c)
```

### Multilevel Ancestor Joins
```sql
SELECT Id, Job_Application__r.Position__r.Hiring_Manager__r.Name
FROM Offer__c
```
### Traverse a Complex Query Result
In this example, the job applications associated with a position are returned as a list:
```sql
SELECT Id, Name, (SELECT Id, Name
                  FROM Job_Application__r)
FROM Position__c
WHERE Id IN (SELECT Position__c
              FROM Job_Application__c)
```
* Using a for-loop for the above example"
```apex
for (Position__c pos : [QUERY]) {
  for (Job_application__c jobApp : pos.Job_Applications__r) {
    // business logic
  }
}
```
### Aggregates
To get a record count:
```sql
SELECT COUNT(*) FROM Account
```

Returns the number of rows where the fieldName has a non-null value:
```sql
SELECT Count(fieldName) FROM Account
```

* In SOQL, you can only alias fields in aggregate queries that use the GROUP BY clause.

### SOQL For Loops
```soql
SELECT Id, Name, (SELECT Id, Name FROM Job_Applications__r)
FROM Position__c
WHERE Id IN (SELECT Position__c FROM Job_Application__c)
```
* `Position__c` is the parent
* `WHERE Id IN (SELECT Position__c FROM Job_Application__c)` - Limiting results to only include parents with children and we are going to get the children back

Adding the query to Apex:
```apex
List<Position__c> ps;
ps = [SELECT Id, Name, (SELECT Id, Name FROM Job_Applications__r)
      FROM Position__c
      WHERE Id IN (SELECT Position__c FROM Job_Application__c)];
      
for (Position__c p : ps) {
  for (Job_Application__c ja :p.Job_Applications__r) {
    System.debug(p.id + ' - ' + p.Name + ' - ' + ja.Name);
  }
}
```

### Best Practices
#### Building Selective Queries
Anytime you use one of these indexed fields in your query’s WHERE clause, you’re increasing the chance that your query is considered selective and an index used as opposed to a full table scan. 

## For Loops
```apex
for(Integer i=0; i<5; i++) {}
```
#### Two reasons to use For-Loops instead of While and do-While Loops:
* `For` loops are used when you know how many times the loop should run.  If you want the loop to stop based on a condition other than the number of times it runs you should use the `while` loop.
* `For` loops are more concise because they keep the three parts - the variable, the condition, and the increment - together in one statement.

### List or Set Iteration For Loops
*  The iteration for loop, works through the items in a list or set.
* Because the list or set has a specific number of items, you don’t need to increment a variable or check a condition. The loop works through all of the items in the list or set, and then the loop ends.
* When you declare an iteration for loop, the data type of the variable must match the data type of the list or set. Here’s the syntax for an iteration for loop.
```apex
for (data_type variable_name : list_name or set_name) {}
```
* Example:
```apex
List <String> tea = new List<String>{'Black Tea', 'Green Tea', 'Chai Tea'};
for(String t : tea){
    System.debug('We have ' + t);
}
```

#
* `Constants` - variables whose values don't change after being initialized once.  It can be defined using `final` keyword.
* `final` - means that the variable can be assigned at most once, either in the declaration itself, or with a static method in in class.
* `class` - a template from which objects are created.
* `object` - instance of a class, instaniate the object.  All objects have a state and behavior.  Things that an object knows about itself and that it can do.
  * A `class` can contain `variables` and `methods`.  
  * `Variables` are used to specify the state and `methods` are used to control behavior.
* `Interface` is like a class in which none of the methods have been implemented - the method signatures are there, but the body of each method is empty.  To use an interface, another class must implement it by providing a body for all of the methods contained in the interface.
* `void` - method does not return a value.
## Static Methods
[Static and Instance Methods, Variables, and Initialization Code](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_static.htm?search_text=static)
* Apex classes cannot be static.  
* Static methods, member variables and initialization code have these characteristics:
  * They are associated with a class
  * They are allowed only in outer classes
  * They are initialized only when a class is loaded.
  * They are not transmitted as part of the view state for a Visualforce page.
  * Inner classes have no static methods or variables.
  * Before an object of a class is created, all static member variables in a class are initialized, and all static initialization code blocks are executed.
  * A static method is used as a utility method, and it never depends on the value of an instance member variable. 
  * Because a static method is only associated with a class, it can’t access the instance member variable values of its class.
  * A static variable is static only within the scope of the Apex transaction. It’s not static across the server or the entire organization. 
  * The value of a static variable persists within the context of a single transaction and is reset across transaction boundaries. 
  * To store information that is shared across instances of a class, use a static variable.
  * All instances of the same class share a single copy of the static variable. 
  * Local variable names are evaluated before class names.

## Instance Methods and Variables
* Instance methods and member variables are used by an instance of a class, that is, by an object. 
* An instance member variable is declared inside a class, but not within a method. 
* Instance methods usually use instance member variables to affect the behavior of the method.
## Important Reserved Keywords
| Keyword | Description | Example |
|------|-----|---|
|abstract| Declares a class that contains abstract methods that only have their signature and no body defined.  Can also define method. | `public abstract class Foo { protected void method1() { /*... */ } abstract Integer abstractMethod();}` |
| break | Exits the entire loop | `while(reader.hasNExt()) {if (reader.getEventType() == END) {break;};reader.next();}` |

### catch
Identifies a block of code that can handle a particular type of exception.
```apex
try {
  // code
} catch (ListException e) {
  //List exception handling code
}
```
### class
Defines a class.
```apex 
private class Foo {
  private Integer x;
  public Integer getX() { return x; }
}
```

## DML Statements
```apex
// Create the account sObject 
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
```
```apex
// Create the account sObject 
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
// Get the new ID on the inserted sObject argument
ID acctID = acct.Id;
// Display this ID in the debug log
System.debug('ID = ' + acctID);
// Debug log result (the ID will be different in your case)
// DEBUG|ID = 001D000000JmKkeIAF
```
```apex
// Create a list of contacts
List<Contact> conList = new List<Contact> {
    new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
        new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
        new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
        new Contact(FirstName='Kim',LastName='Shain',Department='Education')};
            
// Bulk insert all contacts with one DML call
insert conList;
// List to hold the new contacts to update
List<Contact> listToUpdate = new List<Contact>();
// Iterate through the list and add a title only
//   if the department is Finance
for(Contact con : conList) {
    if (con.Department == 'Finance') {
        con.Title = 'Financial analyst';
        // Add updated contact sObject to the list.
        listToUpdate.add(con);
    }
}
// Bulk update all contacts with one DML call
update listToUpdate;

```
```apex
upsert sObjectList Account.Fields.MyExternalId;
```
```apex
// Insert the Josh contact
Contact josh = new Contact(FirstName='Josh',LastName='Kaplan',Department='Finance');       
insert josh;
// Josh's record has been inserted
//   so the variable josh has now an ID
//   which will be used to match the records by upsert
josh.Description = 'Josh\'s record has been updated by the upsert operation.';
// Create the Kathy contact, but don't persist it in the database
Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');
// List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> { josh, kathy };
// Call upsert
upsert contacts;
// Result: Josh is updated and Kathy is created.
```
```apex
Contact jane = new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='jane.smith@example.com',
                         Description='Contact of the day');
insert jane;
// 1. Upsert using an idLookup field
// Create a second sObject variable.
// This variable doesn’t have any ID set.
Contact jane2 = new Contact(FirstName='Jane',
                         LastName='Smith',  
                         Email='jane.smith@example.com',
                         Description='Prefers to be contacted by email.');
// Upsert the contact by using the idLookup field for matching.
upsert jane2 Contact.fields.Email;
// Verify that the contact has been updated
System.assertEquals('Prefers to be contacted by email.',
                   [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);

```
## Database Methods
```apex
AccountHandler.insertNewAccount("Test");
```
### `insert` method with the allOrNone set to `false`
```apex
Contact[] contactsDel = [SELECT Id FROM Contact WHERE LastName='Smith']; 
delete contactsDel;
```
### Insert records with partial success
```apex 
// Create a list of contacts
List<Contact> conList = new List<Contact> {
        new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
        new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
        new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
        new Contact()};
            
// Bulk insert all contacts with one DML call
Database.SaveResult[] srList = Database.insert(conList, false);
// Iterate through each returned result
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else {
        // Operation failed, so get all errors
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
	 }
    }
}

```
* SOQL query limits are 100 SOQL queries for synchronous Apex and 200 for asynchronous Apex