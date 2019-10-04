# Apex

[<img src="https://login.salesforce.com/img/logo190.png" align="right" width="300">](https://login.salesforce.com/)

* [PMD Source Code Analyzer Project](https://pmd.github.io/latest/pmd_userdocs_installation.html#running-pmd-via-command-line)
 * [Apex Reserved Keywords](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_reserved_words.htm)
 * [Object Reference for Salesforce and Force.com](https://developer.salesforce.com/docs/atlas.en-us.206.0.object_reference.meta/object_reference/sforce_api_objects_concepts.htm)
 * [Startung With Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_intro.htm)
 * The `global` access modifier, which is more permissive than the `public` modifier and allows access across namespaces and applications.
 * http://avionsalesforce.blogspot.com/
 * https://trendspro.builtwith.com/dashboard
 * https://success.salesforce.com/ideaView?id=08730000000DfGeAAK
 * https://medium.com/airbnb-engineering/airflow-a-workflow-management-platform-46318b977fd8
 * https://salesforce.stackexchange.com/questions/23338/trigger-to-update-parent-object-value-with-child-value
 
## Table of Contents

- [Sections](#sections)
	- [How Does Apex Work?](#how-does-apex-work)
	- [Apex Core Concepts](#apex-core-concepts)
	- [Execution Context](#execution-context)
	- [List](#lists)
	- [Maps](#maps)
	- [Trigger and Bulk Request Best Practices](#trigger-and-bulk-request-best-practices)
	- [Using Maps and Sets in Bulk Triggers](#maps-and-sets)
	- [Loops](#loops)
	- [Test Driven Development Process](#test-driven-development-process)
	- [Classes, Objects and Interfaces](#classes-objects-and-interfaces)
	- [Integrations](#integrations)
	- [Static and Instance Methods, Variables, and Initialization Code](#static-and-instance-methods-variables-and-initialization-code)
	- [Triggers](#triggers)
	- [Apex Test Classes](#apex-test-classes)
	- [Execution Governor and Limits](#execution-governor-and-limits)
	- [Data Maninpulation Language](#data-manipulation-language)
	- [Apex Class Metadata Templates](#apex-class-metadata-templates)
	- [Manipulate records with DML](#manipulate-records-with-dml)
	- [Getter Setter](#getter-setter)
	- [Class Methods](#class-methods)
	- [Batch](#batch)
	- [Einstein](#einstein)
	- [SOAP](#soap)

### How Does Apex Work?

When a developer writes and saves Apex code to the platform, the platform application server first compiles the code into an abstract set of instructions that can be understood by the Apex runtime interpreter, and then saves those instructions as metadata.

When an end-user triggers the execution Apex, perhaps by clicking a button or accessing a Visualforce page, the platform application server retrieves the compiled instructions from the metadata and sends them through the runtime interpreter before returning results. 

``
All Apex code runs on the Force.com platform.  To guarantee consistent performance and scalability, the execution of Apex is bound by governor limits that ensure no single Apex execution impacts the overall service of Salesforce.  This means all Apex code is limited by number of operations (such as DML or SOQL) that it can perfrom within one process.
All Apex requests return a collection that contains from 1 to 50,000 records.   You cannot assume that your code works only on a single records at a time.  Therefore, you must implement programming patterns that take bulk processing into account.  Otherwise, you may run into governor limits.
``
public method = 

private helper method - it cannot be called externally because it is private.

member variables = attributes

accessor methods = used to access attributes

instance method = 

Static method = use static keyword

Static methods are easier to call than instance methods because they dont need to vbe called on an instance of the class but are called directly on the class name.

public scope = 

public static method 

Methods are defined in a class and objects are instances of a given class.

Constructor is a method that is called at the beginning of an object's lifetime to create and intialize the object.

A class variable is any field declared with the static modifier; this tells the compiler that there is exactly one copy of this variable in existence, regardless of how many times the class has been instantiated. 

Instance variables (non-static fields) are unique to each instance of a class. 
Class variables (static fields) are fields declared with the static modifier; there is exactly one copy of a class variable, regardless of how many times the class has been instantiated.
Local variables store temporary state inside a method. 
Parameters are variables that provide extra information to a method; both local variables and parameters are always classified as "variables" (not "fields"). 

    The term "instance variable" is another name for non-static field.
    The term "class variable" is another name for static field.
    A local variable stores temporary state; it is declared inside a method.
    A variable declared within the opening and closing parenthesis of a method is called a parameter.
    What are the eight primitive data types supported by the Java programming language? byte, short, int, long, float, double, boolean, char
    Character strings are represented by the class java.lang.String.
    An array is a container object that holds a fixed number of values of a single type.

All objects have state and behavior, that is, things that an object knows about itself, and things that an object can do.

### Apex Core Concepts

[<img src="https://developer.salesforce.com/docs/resources/img/en-us/206.0?doc_id=dev_guides%2Fapex%2Fimages%2FAC_Elements.png&folder=apexcode" align="center" width="1000">](https://login.salesforce.com/)

### Execution Context
An execution context has two characteristics:
* It defines the scope and lifetime of static variables.
* It defines the context for those governor limits that are preset between execution contexts.

#### Static Variables
There lifetime and scope is defined by the execution context.  In other words, static variables can only be accessed from within the execution context in which they are created, and are deleted when the execution context completes.
* Static variables do not persist information between execution contexts.  They cannot be used to keep track of the overall execution of the app, or to cache data or objects for use while the app is running.  
* Apex does not support the equivalent of application or session variables.  Anything you wish to persist must be stored in database objects or custom settings.
* There is no need for synchronization.  A given execution context runs on a single thread, so static variables are, in effect, the equivalent of thread local storage - each thread has its own copy of these variables and there is no need to synchronize access.  

### Variables

Use the following syntax when declaring variables:

```Apex
datatype variable_name [ = value];
```

### Using Statements

In Apex, statements must end in a semicolon and can be one of the following types:
 * Assignment, such as assigning a value to a variable.
 * Conditional (if-else)
 * Loops:
 	* Do-while
	* While
	* For
 * Locking 
 * Data Manipulation Language
 * Transaction control
 * Method invoking
 * Exception handling

A `block` is a series of statements that are grouped together with curly braces and can be used in any place where a single statement would be allowed.  

```Apex
if (true) {
	System.debug(1);
	System.debug(2);
} else {
	System.debug(3);
	System.debug(4);
}
```

### Collections

Apex has the following types of collections:
 * Lists (Arrays)
 * Maps
 * Sets

### Lists

- [List Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_list.htm#apex_methods_system_list)

A `list` is a collection of elements, such as Integers, Strings, objects, or other collections.  Use a list when the sequence of elements is important.  You can have duplicate elements in a list.

The first index position in a list is always [0].

To create a list:

 * Use the `new` keyword
 * Use the `List` keyword followed by the element type contained within <> characters.
 
To create a list:

```Apex
List<datatype> list_name
	[= new List<datatype>();] |
	[= new List<datatype>{value, [, value2...]};] |
	;
```

The following example creates a list of Integer, and assigns it to the variable My_List.  Because Apex is strongly typed, you must declare the data type of My_List as a list of Integer.

```Apex
List<Integer> My_List = new List<Integer>();
```

A list is an ordered collection of elements that are distinguished by their indices. List elements can be of any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types. 

Lists can contain any collection and can be nested within one another and become multidimensional. For example, you can have a list of lists of sets of Integers. A list can contain up to four levels of nested collections inside it, that is, a total of five levels overall.

To declare a list, use the List keyword followed by the primitive data, sObject, nested list, map, or set type within <> characters. 

For example:

```Apex
// Create an empty list of String
List<String> my_list = new List<String>();
// Create a nested list
List<List<Set<Integer>>> my_list_2 = new List<List<Set<Integer>>>();
```

To access elements in a list, use the List methods provided by Apex. 
For example:

```Apex
List<Integer> myList = new List<Integer>(); // Define a new list
myList.add(47);                    // Adds a second element of value 47 to the end 
                                       // of the list
Integer i = myList.get(0);                   // Retrieves the element at index 0
myList.set(0, 1);                           // Adds the integer 1 to the list at index 0
myList.clear();                    // Removes all elements from the list
```

### Sets

A set is a collection of unique unordered elements.   

To create a set:
 * Use the new keyword
 * Use the Set keyword followed by the primitive data type contained within <> characters.

Syntax for creating a `Set`:

```Apex
Set<datatype> set_name
	[= new Set<datatype>();] |
	[= new Set<datatype>{value [, value2...]};] |
;
```

The following example creates a set of String.  The values for the set are passed in curly braces.
```Apex
Set<String> My_String = new Set<String>{'a', 'b', 'c'};
```

### Maps

- [Maps](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_collections_maps.htm) 

A map is a collection of key-value pairs where each unique key maps to a single value.  Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.

Map keys and values can contain any collection, and can contain nested collections.  Map keys can contain up to only four levels of nested collections.

- Map keys can contain up to four levels of nested collections.
- To declare a map, use the Map keyword by the data types of the key and the within <> characters.
- Apex uses hash structure for all maps.
- The iteration order of map elements is deterministic. You can rely on the order being the same in each subsequent execution of the same code. However, we recommend to always access map elements by key. 
- A map key can hold the null value.
- Adding a map entry with a key that matches an existing key in the map overwrites the existing entry with that key with the new entry.
- Map keys of type String are case-sensitive. Two keys that differ only by the case are considered unique and have corresponding distinct Map entries. Subsequently, the Map methods, including put, get, containsKey, and remove treat these keys as distinct.
- A Map object is serializable into JSON only if it uses one of the following data types as a key.
    - Boolean
    - Date
    - DateTime
    - Decimal
    - Double
    - Enum
    - Id
    - Integer
    - Long
    - String
    - Time


To declare a map, use the Map keyword followed by the data types of the key and the value within <> characters. 
For example:

```Apex
Map<String, String> country_currencies = new Map<String, String>();
Map<ID, Set<String>> m = new Map<ID, Set<String>>();
```

As with lists, you can populate map key-value pairs when the map is declared by using curly brace ({}) syntax. Within the curly braces, specify the key first, then specify the value for that key using =>. 
For example:

```Apex
Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
```

To access elements in a map, use the Map methods provided by Apex. This example creates a map of integer keys and string values. It adds two entries, checks for the existence of the first key, retrieves the value for the second entry, and finally gets the set of all keys.

```Apex
Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
m.put(1, 'First entry');                  // Insert a new key-value pair in the map
m.put(2, 'Second entry');                  // Insert a new key-value pair in the map
System.assert(m.containsKey(1));  // Assert that the map contains a key
String value = m.get(2);               // Retrieve a value, given a particular key
System.assertEquals('Second entry', value);
Set<Integer> s = m.keySet();       // Return a set that contains all of the keys in the map
```

### Maps and Sets

Set and map data structures are critical for successful coding of bulk triggers. Sets can be used to isolate distinct records, while maps can be used to hold query results organized by record ID.

For example, this bulk trigger from the sample quoting application first adds each pricebook entry associated with the OpportunityLineItem records in Trigger.new to a set, ensuring that the set contains only distinct elements. It then queries the PricebookEntries for their associated product color, and places the results in a map. Once the map is created, the trigger iterates through the OpportunityLineItems in Trigger.new and uses the map to assign the appropriate color.

```Apex
// When a new line item is added to an opportunity, this trigger copies the value of the
// associated product's color to the new record.
trigger oppLineTrigger on OpportunityLineItem (before insert) {

    // For every OpportunityLineItem record, add its associated pricebook entry
    // to a set so there are no duplicates.
    Set<Id> pbeIds = new Set<Id>();
    for (OpportunityLineItem oli : Trigger.new) 
        pbeIds.add(oli.pricebookentryid);

    // Query the PricebookEntries for their associated product color and place the results
    // in a map.
    Map<Id, PricebookEntry> entries = new Map<Id, PricebookEntry>(
        [select product2.color__c from pricebookentry 
         where id in :pbeIds]);
         
    // Now use the map to set the appropriate color on every OpportunityLineItem processed
    // by the trigger.
    for (OpportunityLineItem oli : Trigger.new) 
        oli.color__c = entries.get(oli.pricebookEntryId).product2.color__c;  
}
```

The following example creates a map that has a data type of Integer for the key and String for the value.  In this example, the values for the map are being passed in between the curly braces as the map is being created.

```Apex
Map<Integer, String> My_Map = new Map<Integer, String>{1 => 'a', 2=> 'b', 3 => 'c'};
```

### Trigger and Bulk Request Best Practices

Apex triggers are optimized to operate in bulk, which, by definition, requires developers to write logic that supports bulk operations.  

This example demonstrates the correct pattern to support the bulk nature of triggers while respecting the governor limits:

```Apex 
Trigger MileageTrigger on Mileage__c (before insert, before update) {
	Set<ID> ids = Trigger.newMap.keySet();
	List<User> c = [SELECT Id FROM user WHERE mileage__c in :ids];
}
```

This pattern respects the bulk nature of the trigger by passing the Trigger.new collection to a set, then using the set in a single SOQL query.  This pattern captures all incoming records within the request while limiting the number of SOQL queries.

Best practices for designing `bulk patterns`:

 * Minimize the number of DML operations by adding records to collections and performing DML operations against these collections.  
 * Minimize the number of SOQL statements by preprocessing records and generating sets, which can be places in single SOQL statement used with the IN clause.


### Correlating Records with Query Results in Bulk Triggers

Use the Trigger.newMap and Trigger.oldMap ID-to-sObject maps to correlate records with query results. For example, this trigger from the sample quoting app uses Trigger.oldMap to create a set of unique IDs (Trigger.oldMap.keySet()). The set is then used as part of a query to create a list of quotes associated with the opportunities being processed by the trigger. For every quote returned by the query, the related opportunity is retrieved from Trigger.oldMap and prevented from being deleted:

```Apex
trigger oppTrigger on Opportunity (before delete) {
    for (Quote__c q : [SELECT opportunity__c FROM quote__c 
                       WHERE opportunity__c IN :Trigger.oldMap.keySet()]) {
        Trigger.oldMap.get(q.opportunity__c).addError('Cannot delete 
                                                       opportunity with a quote');
    }
}
```

Use the following design pattern in the trigger to determine if this was the first or subsequent call for this execution context:

```Apex
if (!myclass.firstcall)
{
	// First call into trigger
	myclass.firstcall = true;
}
else
{
	// Subsequent call into trigger
}
```

A class static variable is a global variable that is associated with a particular class.  It exists regardless of whether you have actually created an instance of the class, and that a single instance of the variable is shared by all instances of the class and, in fact, by the entire application.

### Loops

While the `if` statement enables your application to do things based on a condition, loops tell your application to do the same thing again and again based on a condition.  Apex supports the following types of loops:
 * Do-While
 * While
 * For

A `Do-While` loop checks the condition after the code has executed.
A `While` loop checks the condition at the start, before the code executes.
A `For` loop enables you to more finely control the condition used with the loop.  Apex supports traditional `For` loops where you set the conditions, as well as For loops that use lists and SOQL queries as part of the condition.

### Test Driven Development Process

Test driven development process is test development that occurs at the same time as development of code.

Apex supports the creation and execution of unit tests.  Unit tests are class methods that verify whether a particular piece of code is working properly.  Unit test methods take no arguments, commit no data to the database, send no emails, are flagged with the `testMethod` keyword or the `isTest` annotation in the method definition.  Test methods must be defined in test classes, that is, classes annotated with `isTest`.

 * At least 75% of Apex code must be covered by unit tests and all of those tests must complete successfully.
 * When deploying Apex to a production org, each unit test in org namespace is executed bu default
 * Calls to `System.debug` are not counted as part of Apex code coverage.
 * Test methods and test classes are not counted as part of Apex code coverage.
 * Every trigger must have some code coverage.
 * All classes and triggers must compile successfully.
 
### Classes, Objects and Interfaces
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes.htm

### Static and Instance Methods, Variables, and Initialization Code
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_static.htm

With `Static Methods` you do not need to create an instance of the class to access the method - you can just use the name of the class followed by a dot(.) notation and the name of the method.  

```Apex
b.Price__c *= 0.9;
```
This statement takes the old value of `b.Price__c` multiples it by 0.9 and then stores the new value into the `b.Price__c` field.

```Apex
public class MyHelloWorld {
	public static void applyDiscount (Book__c[] books) {
		for (Book__c b :books) {
			b.Price__c *= 0.9;
		}
	}
}
```

#### Calling a Static Method
Static methods are easier to call than instance methods because they don’t need to be called on an instance of the class but are called directly on the class name.

### Triggers

```Apex
trigger HelloWorldTrigger on Book__c (before insert) {
	
	Book__c[] books = Trigger.new;
	
	MyHelloWorld.applyDiscount (books);
}
```

`Book__c[] books = Trigger.new;` creates a list of book records named *books* and assigns it the contents of a trigger context variable called Trigger.new.  Trigger context variables are implicitly defined in all triggers and provide access to the records that caused the trigger to fire.  In this case, Trigger.new contains all the new books that are about to be inserted.  

`MyHelloWorld.applyDiscount (books);` the code calls the method *applyDiscount* in the *MyHelloWorld* class.  It passes in the array of new books.


### Apex Test Classes

```Apex
@isTest
private class HelloWorldTestClass {
	static testMethod void validateHelloWorld() {
		Book__c b = new Book__c (Name='Behind the cloud', Price__c = 100);
		System.debug('Price before inserting new book: ' + b.Price__c);
		
		// Insert book
		insert b;
		
		// Retrieve the new book
		b = [SELECT Price__c FROM Book__c WHERE Id = :b.Id];
		System.debug('Price after triggger fired: ' + b.Price__c);
		
		// Test that the trigger correctly updated the price
		System.assertEquals(90, b.Price__c);
	}
}
```

### Execution Governor and Limits

https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_gov_limits.htm#total_heap_size_limit_desc
	
### Data Manipulation Language

DML provides a straightforward way to manage records by providing simple statements to insert, update, merge, delete, and restore records.

The upsert DML operation creates new records and updates sObject records within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.

The merge statement merges up to three records of the same sObject type into one of the records, deleting the others, and re-parenting any related records.

If a DML operation fails, it returns an exception of type DmlException. You can catch exceptions in your code to handle error conditions.

This example adds the Acme account to Salesforce. An account sObject is created first and then passed as an argument to the insert statement, which persists the record in Salesforce.
```Apex
// Create the account sObject
Account acct = new Account (Name='Acme', Phone='(415)-635-9877', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
```

This example shows how to get the ID on the sObject that corresponds to the inserted account.
```Apex
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


Performing bulk DML operations is the recommended way because it helps avoid hitting governor limits, such as the DML limit of 150 statements per Apex transaction. 


This example inserts contacts in bulk by inserting a list of contacts in one call. The sample then updates those contacts in bulk too.
```Apex
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
Persistence refers to the characteristic of state that outlives the process that created it. This is achieved in practice by storing the state as data in computer data storage. Programs have to transfer data to and from storage devices and have to provide mappings from the native programming-language data structures to the storage device data structures.

## Apex Class Metadata Templates

### Apex Interface
```Apex
public interface {{ api_name }} {

	//Define the method signature to be implemented in classes that implements the interface
	//Example method
	Integer operation();
}
```
### Auth Registration Handler
```Apex
public class {{ api_name }} implements Auth.RegistrationHandler {
    
    public User createUser(Id portalId, Auth.UserData data) {
        
		// Match the Auth.UserData to an existing user?
		// Update user details from Auth.UserData?
		// Provision a new user where the User does not exist?
		
        return null;
    }
    
    public void updateUser(Id userId, Id portalId, Auth.UserData data) {
        
		// Update user details from Auth.UserData?
		
    }
}
```
### Batch
* process records asynchronously in batches to stay within platform limits.
* The execution logic of the batch class is called once for each batch of records you are processing.
* Each time you invoke a batch class, the job is placed on the Apex job queue and is executed as a discrete transaction.
	* Advantages:
	* Every transaction starts with a new set of governor limits, making it easier to ensure that your code stays within the governor execution limits.
	* If one batch fails to process successfully, all other successful batch transactions aren’t rolled back.
	
* class must implement the Database.Batchable interface and include the following three methods:
	* start - Used to collect the records or objects to be passed to the interface method execute for processing. This method is called once at the beginning of a Batch Apex job and returns either a Database.QueryLocator object or an Iterable that contains the records or objects passed to the job.
* To ensure fast execution of batch jobs, minimize Web service callout times and tune queries used in your batch Apex code.
```Apex
global class {{ api_name }} implements Database.Batchable<sObject> {
	
	String query;
	
	global {{ api_name }}() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
	
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}
```
### BDD Unit Test
```Apex
@isTest
private class {{ api_name }}
{
	@isTest
	static void itShould()
	{
		// Given


		// When


		// Then

	}
}
```
### Controller Extension
```Apex
public with sharing class {{ api_name }} {

	private final sObject mysObject;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public {{ api_name }}(ApexPages.StandardController stdController) {
        this.mysObject = (sObject)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    }
}
```
### Custom Exception
```Apex
public class {{ api_name }} extends Exception {

}
```
### Custom Iterable
```Apex
public with sharing class {{ api_name }} implements Iterable<{{ type_name }}> {

  public Iterator<{{ type_name }}> Iterator(){
    return new {{ iterator_class_name }}();
  }
  
}
```
### Custom Iterator
```Apex
public class {{ api_name }} implements Iterator<{{ type_name }}> {

  {{ type_name }}[] results { get;set; }
  Integer index { get;set; }
  String query;

  public {{ api_name }}() {
    index = 0;
    results = Database.query(query);   
  }

  public Boolean hasNext(){ 
   return results != null && !results.isEmpty() && index < results.size(); 
  }    

  public {{ type_name }} next() { 
    return results[index++];
  }    

}
```
### Domain Class
```Apex
/**
 * See https://github.com/financialforcedev/fflib-apex-common for more info
 *
 * Install library via 
 *   https://githubsfdeploy.herokuapp.com/app/githubdeploy/financialforcedev/fflib-apex-common
 */

/**
 * Encapsulates all behaviour logic relating to the {{ object_name }} object
 * 
 * For more guidelines and details see 
 *   https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Domain_Layer
 *
 **/
public class {{ api_name }} extends fflib_SObjectDomain 
{
	public {{ api_name }}(List<{{ object_name }}> records) 
	{
		super(records);	
	}

	public override void onValidate()
	{
		for({{ object_name }} record : (List<{{ object_name }}>) Records)
		{
		}
	}

	public override void onValidate(Map<Id,SObject> existingRecords)
	{
		for({{ object_name }} record : (List<{{ object_name }}>) Records)
		{
		}
	}

	public override void onBeforeInsert()
	{
		for({{ object_name }} record : (List<{{ object_name }}>) Records)
		{
		}
	}

	public void someMethod()
	{
		for({{ object_name }} record : (List<{{ object_name }}>) Records)
		{
		}		
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new {{ api_name }}(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new {{ api_name }}(sObjectList);
		}			
	}	
}
```
### Manipulate records with DML

* The `upsert` DML operation creates new records and updates sObject records within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.
* The `merge` statement merges up to three records of the same sObject type into one of the records, deleting the others, and re-parenting any related records.
* When inserting records, the system assigns an ID for each record. In addition to persisting the ID value in the database, the ID value is also autopopulated on the sObject variable that you used as an argument in the DML call.
* This example shows how to get the ID on the sObject that corresponds to the inserted account.
```Apex
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
* DML limit of 150 statements per Apex transaction. 
* This example inserts contacts in bulk by inserting a list of contacts in one call. The sample then updates those contacts in bulk too.
```Apex
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
* You can insert records related to existing records if a relationship has already been defined between the two objects, such as a lookup or master-detail relationship.
* A record is associated with a related record through a foreign key ID. 
* For example, if inserting a new contact, you can specify the contact's related account record by setting the value of the AccountId field.
* This example shows how to add a contact to an account (the related record) by setting the AccountId field on the contact. Contact and Account are linked through a lookup relationship.
```Apex
Account acct = new Account(Name='SFDC Account');
insert acct;

// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;

// Add a contact to this account.
Contact mario = new Contact(
    FirstName='Mario',
    LastName='Ruiz',
    Phone='415.555.1212',
    AccountId=acctID);
insert mario;
```
#### Updating Related Records
* Fields on related records can't be updated with the same call to the DML operation and require a separate DML call. 
* For example, if inserting a new contact, you can specify the contact's related account record by setting the value of the AccountId field. However, you can't change the account's name without updating the account itself with a separate DML call. 
* The following example updates a contact and its related account using two `update` statements.
```Apex
// Query for the contact, which has been associated with an account.
Contact queriedContact = [SELECT Account.Name 
                          FROM Contact 
                          WHERE FirstName = 'Mario' AND LastName='Ruiz'
                          LIMIT 1];

// Update the contact's phone number
queriedContact.Phone = '(415)555-1213';

// Update the related account industry
queriedContact.Account.Industry = 'Technology';

// Make two separate calls 
// 1. This call is to update the contact's phone.
update queriedContact;
// 2. This call is to update the related account's Industry field.
update queriedContact.Account; 
````
### Getter Setter
```Apex
public class MyClass {
	public String myVariable {get; set;}
}
```

```Apex
public class MyClass {
	public String myVariable;
	
	public void setMyVariable(String input){
		myVariable = input;
	}
	
	public String getMyVariable(){
		return myVariable;
	}
}
```

### Class Methods
* `void` - if the method does not return a value.

## Integrations
* [Integrations and Apex Utilities](https://developer.salesforce.com/docs/atlas.en-us.220.0.apexcode.meta/apexcode/apex_integration_intro.htm)
## SOQL
Downwards traversal SOQL query:

```apex
SELECT Id, Name, Industry, AnnualRevenue,
    ( SELECT Name, Email, BirthDate FROM Contacts )
    FROM Account
```
We essentially have two queries in one SOQL statement. One to pull the general account data, and one to pull the contact related list.
Three things when using downwards traversal:
* The nested query is treated like another field. That’s why there is a comma after the AnnualRevenue field.
* We use the plural version “Contacts” in the nested SOQL query, If you’re using custom relationships, add “__r” to the keyword: “Contacts__r”
* You can combine all the SOQL techniques into one query

## Variables and data types – strings, dates, numbers, booleans, and sObjects
Data types are simply the different types of variables you can have.
Strings are used  with all text, email, or picklist type fields in Salesforce. 

### Lists
The unique aspect of Lists is that they are ordered.  Since Lists are ordered, you can get specific elements of your List by the element’s index, or, List position. Indexes start at zero and go all the way up to number of records in your list, minus one
```apex
Contact firstContact = peopleToSpam[0];
Contact lastContact  = peopleToSpam[peopleToSpam.size() - 1];
```
### Sets
Sets aren’t used as often in Apex – they’re basically lists however they’re unordered and don’t allow any duplicate values. 

### Maps
A map essentially lets you “search” through a list for a particular value

### Dot notation
* use of dot notation is that you can call an object’s instance methods
```apex
Integer numOpps = opps.size();  // A List instance method!
String iLoveCaps = myContact.FirstName.capitalize();
// This is a String instance method. The result is DAVID
```

### Loops – FOR and FOREACH loops
FOREACH loops let you repeatedly execute code on every element of a list:
```Apex
List<Contact> allContacts = [SELECT Id FROM Contact];
for (Contact currentContact : allContacts) {
    // This is my contact ID. People love me!
    currentContact.Best_Friend__c = '003i000000Mnm1R';
}
```

### IF Statements
```apex
if (insert comparison operator) {
    // Code that runs if the above is true
} else if (another comparison operator) {
    // Code that runs if only the above line is true
} else {
    // Code that runs if everything else is false
}
```
### Using Apex variables inside a SOQL query
* output of every SOQL query is an Apex list.
* bind variable is the term for an Apex variable used inside a SOQL query, Salesforce knows you are using a bind variable when you precede your Apex variable with a colon (:)
## Einstein
* [API Access Token](https://api.einstein.ai/token)
* []()

## Heroku
### Dynos
Dynos are managed runtime containers with a Linux operating system.  These containers run processes that allow the code to run.
* Containerization is a mechanism for keeping running processes isolated one from another.
* Runtime containers keep code and configuration from touching another.
* Containers also provide separation between two or more dynos running identical instances of the app, accepting client requests and serving up responses.
### Slugs and Buildpacks
Slugs are compressed and pre-packaged copies of the application optimized for distribution to the Dyno manager.
When you push code to Heroku, your code is received by the slug compiler which transforms it into a slug.  Slug compiler is a collection of scripts called a buildpack that handle different languages.

## SOAP
* [Simple Object Access Protocol (SOAP) 1.1](https://www.w3.org/TR/2000/NOTE-SOAP-20000508/)


* [Object-Oriented Programming Concepts](http://java.sun.com/docs/books/tutorial/java/concepts/index.html)
* [Access Modifiers](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_access_modifiers.htm)
* [Lightning Picklist Component](https://naveendhanaraj.wordpress.com/2018/06/19/lightning-picklist-component/)


* The `global` access modifier, which is more permissive than the `public` modifier and allows access across namespaces and applications.

## List
You can add elements to a list when creating the list, or after creating the list by calling the add() method. 
* lists don’t require you to determine ahead of time how many elements you need to allocate.
* You can add elements to a list when creating the list, or after creating the list by calling the add() method.
* List elements can be read by specifying an index between square brackets
* you can use the get() method to read a list element.
* Create a list and add elements to it:
```apex
List<String> colors = new List<String> {'red', 'blue'};

//Add elements to list after it has been created
List<String>  moreColors = new List<String>();
moreColors.add('orange');

```
* List syntax: `List<Data Type> variable name = new List<Data Type>();`

* List elements can be read by specifying an index between square brackets, just like with array elements. Also, you can use the get() method to read a list element.

```apex
// Get elements from a list
String color1 = moreColors.get(0);
String color2 = moreColors[0];
System.assertEquals(color1, color2);

//iterate over a list to read elements
for(Integer i=0; i<colors.size(); i++) {
    //write value to the debug log
    System.debug(colors[i]);
}
```

## Apex Class Definition

* Class methods can be called by triggers and other classes.
* public method
* private helper method - 
* built-in Messaging methods
* Apex class library
* class encapsulates the methods that are related to managing email
* member variables (attributes) 
* accessor methods to access attributes
* class member variables
* Instance methods access class member variables.
* Static methods are easier to call than instance methods because they don’t need to be called on an instance of the class but are called directly on the class name.

### sObject
* Every record in Salesforce is natively represented as an sObject in Apex. 
* The Account sObject is an abstraction of the account record and holds the account field information in memory as an object.
* Each Salesforce record is represented as an sObject before it is inserted into Salesforce.
* when persisted records are retrieved from Salesforce, they’re stored in an sObject variable.
* to create an sObject, you need to declare a variable and assign it to an sObject instance. The data type of the variable is the sObject type.
* For custom relationship fields, the API name ends with the __r suffix. 
* [Object Reference for Salesforce and Lightning Platform](https://developer.salesforce.com/docs/atlas.en-us.216.0.object_reference.meta/object_reference/sforce_api_objects_concepts.htm)

All objects have a state and a behavior, things that objects know about itself and things that an object can do.
Variables are used to specify the state of an object, such as the object's Name or Type.  

A class can contain other classes, exception types, and initialization code.

An interface is like a class in which none of the methods have been implemented—the method signatures are there, but the body of each method is empty. To use an interface, another class must implement it by providing a body for all of the methods contained in the interface.

Methods are used to control behavior, such as getOtherQuotes or copyLineItems.

To define a class, specify the following:
* Access modifiers:
    * Must use one of the access modifiers (such as `public` or `global`) in the declaration of the top-level class.
    * You do not have to use an access modifier in the declaration of an inner level class.
* Optional definition modifiers (`virtual`, `abstract`, etc.)
* Required: The keyword `class` followed by the name of the class.
* Optional extensions and/or implementations

Syntax to define a class:
```apex
private | public | global 
[virtual | abstract | with sharing | without sharing]
class ClassName [implements InterfaceNameList] [extends ClassName]
{
    //the body of the class
}
```
* The `virtual` definition modifier declares that this class allows extension and overrides. You cannot override a method with the `override` keyword unless the class has been defined as `virtual`.
* The `abstract` definition modifier declares that this class contains abstract methods, that is, methods that only have their signature declared and no body defined.

### Apex Class Definition
```apex
private | public | global 
[virtual | abstract | with sharing | without sharing] 
class ClassName [implements InterfaceNameList] [extends ClassName] 
{ 
// The body of the class
}
```

### Class Variables
```apex
[public | private | protected | global] [final] [static] data_type variable_name 
[= value] 
```
### Class Methods
```apex 
[public | private | protected | global] [override] [static] data_type method_name 
(input parameters) 
{
// The body of the method
}
```
* Methods with a void return type are typically invoked as a stand-alone statement in Apex code. 
* void - the method does not return a value.
* In Apex, all primitive data type arguments, such as Integer or String, are passed into methods by value. 
* This fact means that any changes to the arguments exist only within the scope of the method.
* When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. 
* when the method returns, the passed-in argument still references the same object as before the method call.
#### Example: Passing Primitive Data Type Arguments
* This example shows how a primitive argument of type String is passed by value into another method.
* The debugStatusMessage method in this example creates a String variable, msg, and assigns it a value. 
* It then passes this variable as an argument to another method, which modifies the value of this String. 
* since String is a primitive type, it is passed by value, and when the method returns, the value of the original variable, msg, is unchanged. 
* An assert statement verifies that the value of msg is still the old value.
```apex
public class PassPrimitiveTypeExample {
    public static void debugStatusMessage() {
        String msg = 'Original value';
        processString(msg);
        // The value of the msg variable didn't
        // change; it is still the old value.
        System.assertEquals(msg, 'Original value');
    }

    public static void processString(String s) {
        s = 'modified value';
    }
}
```
#### Invoking a public method
```apex
EmailManager em = new EmailManager();
em.sendMail('Your email address', 'Trailhead Tutorial', '123 body');
```
### Static Methods and Variables
* You can use static methods and variables only with outer classes.
* Inner classes have no static methods or variables.
* Before an object of a class is created, all static member variables in a class are initialized, and all static initialization code blocks are executed.
* These items are handled in the order in which they appear in the class.
* A static method is used as a utility method, and it never depends on the value of an instance member variable. 
* Because a static method is only associated with a class, it can’t access the instance member variable values of its class.
* A static variable is static only within the scope of the Apex transaction.
* It’s not static across the server or the entire organization.
* The value of a static variable persists within the context of a single transaction and is reset across transaction boundaries. 
* For example, if an Apex DML request causes a trigger to fire multiple times, the static variables persist across these trigger invocations.
* All instances of the same class share a single copy of the static variable.
* recursive trigger - trigger that calls itself.
* define the static variables in a class so that the trigger can access these class member variables and check their static values.
* A class static variable can’t be accessed through an instance of that class.
* Local variable names are evaluated before class names.
* Instance methods and member variables are used by an instance of a class, that is, by an object.
* Instance of a class === object
* An instance member variable is declared inside a class, but not within a method.
* Instance methods usually use instance member variables to affect the behavior of the method.
* Static initialization code is a block of code preceded with the keyword static.
* Similar to other static code, a static initialization code block is only initialized once on the first use of the class.
* A class can have any number of either static or instance initialization code blocks.
* They can appear anywhere in the code body.
* The code blocks are executed in the order in which they appear in the file.

#### Using Initialization Code
* The instance initialization code in a class is executed each time an object is instantiated from that class. 
* These code blocks run before the constructor.

### Apex Properties
* An Apex property is similar to a variable
* Properties can be used to validate data before a change is made, 
    * to prompt an action when data is changed (such as altering the value of other member variables), or * to expose data that is retrieved from some other source (such as another class).
* getter accessor - The code in a get accessor executes when the property is read.
* setter accessor - The code in a set accessor executes when the property is assigned a new value.
* If a property has only a get accessor, it is considered read only.
* If a property has only a set accessor, it is considered write only. 
* A property with both accessors is considered read-write.

#### Property Declaration
```apex
Public class BasicClass {

   // Property declaration
   access_modifier return_type property_name {
      get {
         //Get accessor code block
      }
      set {
         //Set accessor code block
      }
   } 
}
``` 
Where:
* access_modifier is the access modifier for the property. The access modifiers that can be applied to properties include: `public`, `private`, `global`, and `protected`. In addition, these definition modifiers can be applied: `static` and `transient`
* return_type is the type of the property, such as `Integer`, `Double`, `sObject`, and so on.
* property_name is the name of the property
### Inheritance
* OOP suggests that you do not modify the existing code but extend it so that testing can be done only on the new code and there are fewer maintenance issues. === inheritance
* To use inheritance in Apex, we need to use the `virtual` or `abstract` keywords in the base class and methods.
* `virtual` keyword states that a class or method can be inherited and overridden by child classes. 
* `extends` keyword is used in a child class to inform a parent class.
* If we are writing the same method again in a child class of a parent class, then the `override` keyword needs to be used. 
* `override` keyword informs Apex that this is a new version of the same method in the parent class. 
* If we want to call any method in a parent class, we need to use the `super` keyword.
* a child class is able to reuse a parent class method with an added behavior. 
* The type of object is Mario, which is the parent class, but Apex is able to call a method of the Mario_Runclass using dynamic dispatch, which is a kind of Polymorphism.
* Assigning a child class reference to a parent class is known as subtype polymorphism.
#### Static and dynamic dispatch
* Types of polymorphism can be identified on the basis of when an implementation is selected. 
* when an implementation is selected at compile time, it is known as static dispatch. 
* When an implementation is selected while a program is running (in case of a virtual method), it is known as dynamic dispatch.
#### Interface
* `interface` is another way to achieve polymorphism and abstraction in Apex. 
* We cannot instantiate interfaces
* we can assign any child class to them
* Huge applications and APIs are created using interfaces. 
* `Queueable` and `Schedulable` are examples of interfaces.
*  Apex only needs to invoke the `execute()` method in your class because it knows that you follow the contract of an `interface`.
* Apex does not support multiple inheritance where one child class extends multiple parent classes at a time. However, using an `interface` a child class can implement multiple interfaces at a time.
### Abstract Classes
* In inheritance, a child class extends a parent class, where both the classes have full implementations. 
* In an interface, a parent class does not have any implementation and depends on child classes completely. 

```apex
public abstract class GameCoin { 
     
  public abstract Integer coinValue(); 
     
  public Integer absorbCoin(Integer existingPoint){ 
    return existingPoint + coinValue(); 
  }  
} 
```

* we cannot instantiate an abstract class
### Advantages of Design Patterns
* Coupling measures the dependency of software components on each other.
    * this is how two components interact with each other and pass information.
* robustness of the code:  the impact it has on a component if any related component is modified.
* low coupling indicates a good code structure.
* Cohesion measures the degree to which a code component has been well built and focused.
* Encapsulation - all the related data and functionalities should be encapsulated in the same program component (for example, a class). 
    * It ensures that all related functionalities are present in one place and controls their accessibility. 
    * Lower code cohesion indicates lower dependency of modules/classes, that is, higher maintainability, less complexity, and lesser impact on the part of change.
* high cohesion is better for you and indicates that a class is doing a well-defined job. 
* Low cohesion means that a class is doing many jobs with little in common between jobs.
* In Apex, a static variable lasts for the duration of an individual user request execution only (until the time the user request is being processed on a server). 
### The single responsibility principle (SRP)
The advantages of SRP are as follows:
* It makes code as easy as possible to reuse
* Small classes can be changed easily
* Small classes are more readable

## SOSL
Like SOQL, SOSL allows you to search your organization’s records for specific information. Unlike SOQL, which can only query one standard or custom object at a time, a single SOSL query can search all objects.

Another difference is that SOSL matches fields based on a word match while SOQL performs an exact match by default (when not using wildcards). For example, searching for 'Digital' in SOSL returns records whose field values are 'Digital' or 'The Digital Company', but SOQL returns only records with field values of 'Digital'.
* [SOQL and SOSL Reference Document](https://developer.salesforce.com/docs/atlas.en-us.216.0.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_sosl_intro.htm)
* SOSL indexes data for searching
* Use SOQL to retrieve records for a single object.
* Use SOSL to search fields across multiple objects. SOSL queries can search most text fields on an object.
* The search query in the Query Editor and the API must be enclosed within curly brackets ({Wingo}). In contrast, in Apex the search query is enclosed within single quotes ('Wingo').
* Search terms can be grouped with logical operators (AND, OR) and parentheses. 
* search terms can include wildcard characters (*, ?). 
* The * wildcard matches zero or more characters at the middle or end of the search term. 
* The ? wildcard matches only one character at the middle or end of the search term.
* Text searches are case-insensitive.

## Triggers
* Before triggers are used to update or validate record values before they’re saved to the database.
* After triggers are used to access field values that are set by the system (such as a record's `Id` or `LastModifiedDate` field), and to affect changes in other records. The records that fire the after trigger are read-only.
### Using Context Variables
To access the records that caused the trigger to fire, use context variables.
* `Trigger.New` contains all the records that were inserted in insert or update triggers. 
* `Trigger.Old` provides the old version of sObjects before they were updated in update triggers, or a list of deleted sObjects in delete triggers.

### Trigger Context Variables
| Variable | Usage |
| --- | --- |
| `isExecuting` | Returns true if the current context for the Apex code is a trigger, not a Visualforce page, a Web service, or an `executeanonymous()` API call. |
| `isInsert` | Returns `true` if this trigger was fired due to an insert operation, from the Salesforce user interface, Apex, or the API. |
| `isUpdate` | Returns `true` if this trigger was fired due to an update operation, from the Salesforce user interface, Apex, or the API. |
| `isDelete` | Returns `true` if this trigger was fired due to a delete operation, from the Salesforce user interface, Apex, or the API. |
| `isBefore` | Returns `true` if this trigger was fired before any record was saved. |
| `isAfter` | Returns `true` if this trigger was fired after all records were saved. |
| `isUndelete` | Returns `true` if this trigger was fired after a record is recovered from the Recycle Bin (that is, after an undelete operation from the Salesforce user interface, Apex, or the API.) |
| `new` | Returns a list of the new versions of the sObject records.  This sObject list is only available in `insert`, `update`, and `undelete` triggers, and the records can only be modified in `before` triggers. |
| `newMap` | A map of IDs to the new versions of the sObject records.  This map is only available in `before update`, `after insert`, `after update`, and `after undelete` triggers. |
| `old` | Returns a list of the old versions of the sObject records.  This sObject list is only available in `update` and `delete` triggers.|
| `oldMap`| A map of IDs to the old versions of the sObject records.  This map is only available in `update` and `delete` triggers. |
| `size` | The total number of records in a trigger invocation, both old and new. |

* Triggers are often used to access and manage records related to the records in the trigger context—the records that caused this trigger to fire.
* To prevent saving records in a trigger, call the `addError()` method on the sObject in question.
* `addError()` method throws a fatal error inside a trigger. 

### Triggers and Callouts
* Apex calls to external Web services are referred to as callouts. 
*  When making a callout from a trigger, the callout must be done asynchronously so that the trigger process doesn’t block you from working while waiting for the external service's response.
* The asynchronous callout is made in a background process, and the response is received when the external service returns it.
* To make a callout from a trigger, call a class method that executes asynchronously.
* Such a method is called a future method and is annotated with `@future(callout=true)`.
* [Invoking Callouts Using Apex](https://developer.salesforce.com/docs/atlas.en-us.216.0.apexcode.meta/apexcode/apex_callouts.htm)

### Trigger Factory
* [Pros and Cons of using a Trigger Factory](https://salesforce.stackexchange.com/questions/101835/pros-and-cons-of-using-a-trigger-factory)

### Asynchronous Apex
| Type | Overview | Common Scenario |
| Future Methods | Run in their own thread, and do not start until resources are available. | Web service callout. |

### Apex Test Classes
The benefits of Apex unit tests:
* Having a suite of regression tests that can be rerun every time classes and triggers are updated to ensure that future updates you make to your app don’t break existing functionality
* Meeting the code coverage requirements for deploying Apex to production or distributing Apex to customers via packages
* High-quality apps delivered to the production org, which makes production users more productive
* High-quality apps delivered to package subscribers, which increase your customers trust

#### Apex Unit Tests
UNIT TESTING is a level of software testing where individual units/ components of a software are tested. The purpose is to validate that each unit of the software performs as designed. A unit is the smallest testable part of any software. It usually has one or a few inputs and usually a single output.
* Unit tests are class methods that verify whether a particular piece of code is working properly.
* Unit test methods take no arguments, commit no data to the database, send no emails, and are flagged with the `testMethod` keyword or the `@isTest` annotation in the <b>method definition</b>.

##### `@isTest` annotation
* Use the `@isTest` annotation to define classes and methods that only contain code used for testing your application. 
* The `@isTest` annotation on methods is equivalent to the `testMethod` keyword.
* `@isTest` annotation can take multiple modifiers within parentheses and separated by blanks.

* 75% of Apex code must be covered by tests, and all those tests must pass.
* code coverage is a requirement for deployment
*  test the common use cases in your app, 
* including positive and negative test cases,
* and bulk and single-record processing
* Test methods take no arguments
* The visibility of a test method doesn’t matter
* testing framework is always able to access test methods
* For this reason, the access modifiers are omitted in the syntax.
* Test methods must be defined in test classes, which are classes annotated with isTest
* Test classes can be either private or public.
* If you’re using a test class for unit testing only, declare it as private. 
* The verifications are done by calling the `System.assertEquals()` method, which takes two parameters: 
        * the first is the expected value, and 
        * the second is the actual value. 

* private access member variable
* private inner class
* private method
* private custom exception
* `@TestVisible` - private or protectd members can be accessed by test methods and only code running in test context.
* 

## Schema Namespace
A namespace is a declarative region that provides a scope to the identifiers (the names of types, functions, variables, etc) inside it. Namespaces are used to organize code into logical groups and to prevent name collisions that can occur especially when your code base includes multiple libraries.

## Static and Instance Methods, Variables, and Initialization Code
### Using Instance Methods and Variables
* Instance methods and member variables are used by an instance of a class, that is, by an object.
* An instance member variable is declared inside a class, but not within a method. 
* Instance methods usually use instance member variables to affect the behavior of the method.
* A class static variable can’t be accessed through an instance of that class. 
* If class MyClass has a static variable `myStaticVariable`, and `myClassInstance` is an instance of `MyClass`, `myClassInstance.myStaticVariable` is not a legal expression.
* The same is true for instance methods. If `myStaticMethod()` is a static method, `myClassInstance.myStaticMethod()` is not legal. 
* Instead, refer to those static identifiers using the class: `MyClass.myStaticVariable` and `MyClass.myStaticMethod()`.
* An inner class behaves like a static Java inner class, but doesn’t require the static keyword. 
### Using Initialization Code


### Constants 
Apex constants are variables whose values do not change after being initialized once.  Constants can be defined using the `final` keyword.  
The `final` keyword means that the variable can be assigned at most once, either in the declaration itself, or with a static initializer method if the constant is defined in a class. 
*  This example declares two constants. The first is initialized in the declaration statement. The second is assigned a value in a static block by calling a static method.
```apex
public class myClass {
    static final Integer PRIVATE_INT_CONST = 220;
    static final Integer PRIVATE_INT_CONST2;

    public static Integer calculate() {
        return 2 + 7;
    }

    static {
        PRIVATE_INT_CONST2 = calculate;
    }
}
```

### Classes 
* `virtual` - definition modifier declares that this class allows extension and overrides.  You cannot override a method with the `override` keyword unless the class has been defined as `virtual`
* `abstract` - definition modifier declares that this class contains abstract methods - methods that only have their signature declared and no body defined.
* a class can implement multiple interfaces but only extend one existing class.  Apex does not support multiple inheritance
* use `void` if method does not return a value
* Class variable and class methods
* Passed into methods by value: primitive data types
* Passed into methods by reference: non-primitive data types

###
* This example shows how a List argument is passed by reference into the `reference()` method and is modified
* It then shows, in the referenceNew() method, that the List argument can’t be changed to point to another List object.
* 1-- the createTemperatureHistory method creates a variable, fillMe, that is a List of Integers and passes it to a method.

```Apex 
public class PassNonPrimitiveTypeExample {

}
```
### Static and Instance Methods, Variables, and Initialization Code
Apex classes cannot be static.
* Static methods
    * associated with a class
    * allowed only in outer classes
    * Initialized only when a class is loaded
    * ARE NOT transmitted as part of the view state for a Visualforce page
* Static Variables
    * associated with a class
    * allowed only in outer classes
    * Initialized only when a class is loaded
    * ARE NOT transmitted as part of the view state for a Visualforce page
* Static Initialization code
    * associated with a class
    * allowed only in outer classes
    * Initialized only when a class is loaded
    * ARE NOT transmitted as part of the view state for a Visualforce page
* Instance methods
    * associated with a particular object
    * have no definition modifier
    * created with every object instantiated from the class in which they are created
* Instance Member Variables
    * associated with a particular object
    * have no definition modifier
    * created with every object instantiated from the class in which they are created
* Instance Initialization code
    * associated with a particular object
    * have no definition modifier
    * created with every object instantiated from the class in which they are created
* Local Variables
    * associated with a block of code in which they are declared
    * must be initialized before they are used
#### Using Static Methods and Variables
* You can use static methods and variables only with outer classes.
* Inner classes have no static methods or variables.
* A static method or variable doesnt require an instance of a class to run 
* Before an object of a class is created, all static member variables in a class are initialized, and all static initialization code blocks are executed.  
* These items are handled in the order in which they appear in the class
* A static method is used as a utlitiy method, and it never depends on the value of an instance member variable.
* Because a static method is only associated with a class, it cant access the instance member variable values of its class
* static variable is static only within the scope of the Apex transaction.  
* it is not static across the server or the entire organization
* the value of a static variable persists within the context of a single transaction and is reset across transaction boundaries
* `to information that is shared across instances of a class, use a static variable`
* all instances of the same class share a single copy of the static variable
* all triggers that a single transaction spawns can communicate with each other by viewing and updating static variables in a related class
* a recursive trigger can use the value of a class variable to determine when to exit the recursion
* define the static variables in a class so that the trigger can access these class member variables and check their static values
* a class static variable cant be accessed through an instance of that class.  
```apex
// MyClass has a static variable = myStaticVariable
// myClassInstance is an instance of MyClass
myClassInstance.myStaticVariable // not a legal expression
MyClass.myStaticVariable // legal
MyClassInstance.myStaticMethod() // not a legal expression
MyClass.myStaticMethod() // legal
```
* local variable names are evaluated before class names.
 
### Using Instance Methods and Variables
Instance methods and member variables are used by an instance of a class, object.
* an instance member variable is declared inside a class, but not within a method
* instance methods usually use instance member variables to affect the behavior of a method

```apex
public class Plotter {
    // This inner class manages the points
    class Point {
        Double x;
        Double y;

        Point(Double x, Double y) {
            this.x = x;
            this.y = y;
        }
        Double getXCoordinate() {
            return x;
        }
        Double getYCoordinate() {
            return y;
        }
    }

    List<Point> points = new List<Point>();

    public void plot(Double x, Double y) {
        points.add(new Point(x, y));
    }

    // The followting method takes the list of points and does somethin
    public void render() {

    }
}
```
* The instance initialization code in a class is executed each time an object is instantiated from that class. 
* These code blocks run before the constructor.
* static initialization block runs only once, regardless of how many times you access the class that contains it.
* Static initialization code is a block of code preceded with the keyword `static`.
* The code blocks are executed in the order in which they appear in the file
* You can use static initialization code to initialize static final variables and to declare information that is static, such as a map of values.

### Apex Properties
An Apex property is similar to a variable; however, you can do additional things in your code to a property value before it is accessed or returned. 
* Properties can be used to validate data before a change is made
* to prompt an action when data is changed 
* to expose data that is retrieved from some other source (such as another class).
* Property definitions include one or two code blocks, representing a get accessor and a set accessor:
* The code in a get accessor executes when the property is read.
* The code in a set accessor executes when the property is assigned a new value.
* If a property has only a get accessor, it is considered read only. 
* If a property has only a set accessor, it is considered write only. 
* A property with both accessors is considered read-write.
* To declare a property, use the following syntax in the body of a class:
```apex
Public class BasicClass {

    // Property declaration
    access_modifier return_type property_name {
        get {
            // Get accessor code block
        }
        set {
            // Set accessor code block
        }
    }
}
``` 
* access_modifier is the access modifier for the property. The access modifiers that can be applied to properties include: `public`, `private`, `global`, and `protected`. In addition, these definition modifiers can be applied: `static` and `transient`.
* `return_type` is the type of the property, such as `Integer`, `Double`, `sObject`, and so on.
```apex
public class BasicProperty {
    public Integer prop {
        get { return prop; }
        set { prop = value; }
    }
}
```
Call the `BasicProperty` class:
```apex
BasicProperty bp = new BasicProperty();
bp.prop = 5; // calls set accessor
System.assertEqual(5, bp.prop); // calls get accessor
```
* The body of the get accessor is similar to that of a method. 
* It must return a value of the property type. 
* Executing the get accessor is the same as reading the value of the variable.
* The get accessor must end in a return statement.
* We recommend that your get accessor not change the state of the object that it is defined on.
* The set accessor is similar to a method whose return type is void.
* When you assign a value to the property, the set accessor is invoked with an argument that provides the new value.
* When the set accessor is invoked, the system passes an implicit argument to the setter called value of the same data type as the property.
* Properties cannot be defined on `interface`.
* Properties provide storage for values directly. 
* You do not need to create supporting members for storing values.
* Properties do not require additional code in their get or set accessor code blocks.
* The following example creates three automatic properties:
```apex
public class AutomaticProperty {
    public integer MyReadOnlyProperty { get; }
    public double MyReadWriteProperty { get; set; }
    public string MyWriteOnlyProperty { set; }
}
// calling this class:
AutomaticProperty ap = new AutomaticProperty();
ap.MyReadOnlyProperty = 5; // this produces a compile error: not writable
ap.MyReadWriteProperty = 5; // No error
System.assertEquals(5, MyWriteOnlyProperty); // This produces a compile error: not readable
```

### Using Static Properties
When a property is declared as `static`, the property's accessor methods execute in a static context. 
* accessors do not have access to non-static member variables defined in the class. 
```apex
public class StaticProperty {
    private static integer StaticMember;
    private integer NonStaticMember;

    // The following produces a system error
    // public static integer MyBadStaticProp { return NonStaticMember; }

    public static integer MyGoodStaticProperty {
        get { return StaticMember; }
        set { StaticMember = value; }
    }

    public integer MyGoogNonStaticProperty {
        get { return NonStaticMember; }
        set { NonStaticMember = value; }
    }
}

// call the instance and static properties
StaticProperty sp = new StaticProperty();
// The following produces a system error: a static variable cannot be
// accessed through an object instance
// sp.MyGoodStaticProp = 5;
// The following does not produce an error
StaticProperty.MyGoodStaticProp = 5;
```
### Using Access Modifiers on Property Accessors
Property accessors can be defined with their own access modifiers. 
* If an accessor includes its own access modifier, this modifier overrides the access modifier of the property. 
* The access modifier of an individual accessor must be more restrictive than the access modifier on the property itself. 
```apex
global virtual class PropertyVisibility {
    // X is private for read and public for write
    public integer X { private get; set; }
    // Y can be globally read but only written within a class
    global integer Y { get; public set; }
    // Z can be read within the class but only subclasses can set it
    public integer Z { get; protected set; }
}
```
### Extending a Class
A class that extends another class inherits all the methods and properties of the extended class.
* the extending class can override the existing virtual methods by using the override keyword in the method definition. 
* Overriding a virtual method allows you to provide a different implementation for an existing method. 
* This means that the behavior of a particular method is different based on the object you’re calling it on. This is referred to as polymorphism.
* A class extends another class using the extends keyword in the class definition. 
* A class can only extend one other class, but it can implement more than one interface.

