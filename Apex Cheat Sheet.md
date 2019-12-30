## Table of Contents
* [Using Relationship Queries](#using-relationship-queries)
* 



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
  * With `static` method you do not need to create an instance of the class to access the method - you can just use the name of the class followed by dot (.) and the name of the method.
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

1. Use a map because it doesn't allow duplicate values

2. Access all the information in a single query rather than querying as you need it.
    This is a best practice for bulkifying requests
    ```for(item__c i :itemList) {}`

3. Take a list and put it into a Map.  This will make it easier to look up a shipping invoice because you must iterate a list, but you can use lookup for a map.

4. Treat updates like a removal of the old item and addition of the revised item rather than figuring out the differences of each field and acting accordingly.
* Note updates have both trigger.new and trigger.old

5. never hard code values.  Leveraging Custom Settings for values is a best practice.

6. Only use one DML update at the end.  This minimizes the number of DML requests generated from this trigger.

7. It's a best practice to either use defaults or to explicitly set all values to zero so as to avoid having extraneous data in your test.

```apex
Shipping_Invoice__C order1 = new Shipping_Invoice__C(subtotal__c = 0,
                          totalweight__c = 0, grandtotal__c = 0,
                          ShippingDiscount__c = 0, Shipping__c = 0, tax__c = 0);
```

## @future Annotation
* Use the `future` annotation to identify methods that are executed asynchronously. When you specify future, the method executes when Salesforce has available resources.

For example, you can use the `future` annotation when making an asynchronous Web service callout to an external service. Without the annotation, the Web service callout is made from the same thread that is executing the Apex code, and no additional processing can occur until the callout is complete (synchronous processing).

Methods with the `future` annotation must be static methods, and can only return a void type. 

The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects or objects as arguments.

best practice to use only one trigger per object, which you see in the following example. You can then use context-specific handler methods within triggers to create logic-less triggers. 

Apex triggers can receive up to 200 objects at once.
the synchronous limit for the total number of SOQL queries is 100, and 150 for the total number of DML statements issued 

design your Apex code to handle bulk operations from the very start

https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_bulk

https://trailhead.salesforce.com/content/learn/modules/apex_triggers/apex_triggers_bulk

DO NOT have the insert DML operation is inside the for loop

Apex uses a familiar try-catch-finally block to handle exceptions. But your catch statement and possible rollback could differ depending on where the Apex code is executed.

 If you need data to persist between classes, you do have static variables

### Asynchronous Programming
The following three reasons are usually behind choosing asynchronous programming:

Processing a very large number of records. This reason is unique to the multi-tenanted world of the Lightning Platform where limits rule. The limits associated with asynchronous processes are higher than those with synchronous processes. Therefore, if you need to process thousands or even millions of records, asynchronous processing is your best bet.

Making callouts to external web services. Callouts can take a long time to process, but in the Lightning Platform, triggers can’t make callouts directly.

Creating a better and faster user experience by offloading some processing to asynchronous calls. Why do everything at once? If it can wait, let it.

### Future Methods
In situations where you need to make a callout to a web service or want to offload simple processing to an asynchronous task, creating a future method could be the way to go.
To make a method asynchronous:
* add `@future` annotation to the method
* make sure the method is static 
* and returns only a void type

You cannot pass objects as arguments in future methods.

### Future Limitations
Here are some limitations:
* You can’t track execution because no Apex job ID is returned.
* Parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Future methods can’t take objects as arguments.
* You can’t chain future methods and have one call another.
* Although asynchronous calls are sometimes done to avoid limits, you still need to consider limits

### Batch or Scheduled Apex
The No. 1 reason to use it is if you need to process a large number of records. For example, if you want to clean up or archive up to 50 million records, use batchable interface. You can even schedule your batches to run at a particular time.

To use it, your class implements the Database.Batchable interface.  You also define `start()`, `execute()`, and `finish()` methods.

You can then invoke a batch class using the Database.executeBatch method.

### Queueable Apex
Queueable Apex provides the following benefits to future methods:
* Non-primitive types - Classes can accept parameter variables of non-primitive data types, such as sObjects or custom Apex types.
* Monitoring - When you submit your job, a jobId is returned that you can use to identify the job and monitor its progress.
* Chaining jobs - You can chain one job to another job by starting a second job from a running job. Chaining jobs is useful for sequential processing.

### Apex Flex Queue
Eliminate the limitation of five concurrent batches.

### Classes
All objects have state and behavior.  
* state - things that an object knows about itself
* behavior- things that an object ca do.

A class can contain variables and methods.  Variables are used to specify state of an object, such as the object Name and Type.
Since these variables are associated with a class and are members of it, they are commonly refered to as member variables.  

Methods are used to control behavior, such as `getOtherQuotes` or `copyLineItems`

A class can contain other classes, exception types and initialization code.

An `interface` is like a class in which none of the methods have been implemented.

### To define a class
1. You must use one of the access modifiers (such as public) in definition of the top-level class
2. You do not have to use access modifier for the declaration of the inner level class
3. Required: the keyword class followed by the name of the class
4. The private access modifier declares that this class is only known locally, that is, only by this section of code. This is the default access for inner classes—that is, if you don't specify an access modifier for an inner class, it is considered private. This keyword can only be used with inner classes (or with top level test classes marked with the @isTest annotation).
5. The public access modifier declares that this class is visible in your application or namespace.
6. The global access modifier declares that this class is known by all Apex code everywhere. All classes that contain methods defined with the webservice keyword must be declared as global. If a method or inner class is declared as global, the outer, top-level class must also be defined as global.
7. The virtual definition modifier declares that this class allows extension and overrides. You cannot override a method with the override keyword unless the class has been defined as virtual.
8. The abstract definition modifier declares that this class contains abstract methods, that is, methods that only have their signature declared and no body defined.
9. A class can implement multiple interfaces, but only extend one existing class. This restriction means that Apex does not support `multiple inheritance`.

### To declare a variable
1. Optional: Modifiers, such as public or final, as well as static.
2. Required: The data type of the variable, such as String or Boolean.
3. Required: The name of the variable.
4. Optional: The value of the variable.
```apex
 [public | private | protected | global] [final] [static] data_type variable_name [= value]
 ```
  ### To define a method
  1. Optional: Modifiers, such as public or protected.
  2. Required: The data type of the value returned by the method, such as String or Integer. Use void if the method does not return a value.
  3. Required: A list of input parameters for the method, separated by commas, each preceded by its data type, and enclosed in parentheses (). If there are no parameters, use a set of empty parentheses. A method can only have 32 input parameters.
  4. Required: The body of the method, enclosed in braces {}. All the code for the method, including any local variable declarations, is contained here.
  ```apex
  [public | private | protected | global] [override] [static] data_type method_name (input parameters)
{
// The body of the method
}
```
5. You can use override to override methods only in classes that have been defined as virtual or abstract.
6. methods that return values can also be run as a statement if their results are not assigned to another variable.
7. Can be recursive.
8. Can have side effects, such as DML insert statements that initialize sObject record IDs.
9. Can refer to themselves or to methods defined later in the same class or anonymous block. Apex parses methods in two phases, so forward declarations are not needed.
10. Can be polymorphic. For example, a method named example can be implemented in two ways, one with a single Integer parameter and one with two Integer parameters. Depending on whether the method is called with one or two Integers, the Apex parser selects the appropriate implementation to execute. If the parser cannot find an exact match, it then seeks an approximate match using type coercion rules. 
11. If the parser finds multiple approximate matches, a parse-time exception is generated.
12. Methods with a void return type are typically invoked as a stand-alone statement in Apex code.

### Passing Method Arguments by Value
* all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. Therefore, when the method returns, the passed-in argument still references the same object as before the method call. Within the method, the reference can't be changed to point to another object but the values of the object's fields can be changed.

### Passing non-primitive data-type argument
This example shows how a List agument is passed by reference into the `reference()` method and is modified.  
It then shows, in the `referenceNew()` method, that the List argument can't be changed to point to another List object.

1.  The `createTemperatureHistory` method creates a variable `fillMe` that is a List of integers and passes it to a method.
2. The called method fills this list with integer values representing roundded temperature values.
3. When the method returns, assert statement verifies that the contents of the original `List` variable has changed and now contains five values.  
4. Next, the example creates a second List variable, `createMe`, and passes it to another method.  
5. The called method assigns the passed-in argument to a newly created List that contains new Integer values.
6.  When the method returns, the original createMe variable doesn’t point to the new List but still points to the original List, which is empty.

## 

