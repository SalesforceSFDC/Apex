# Apex
Apex triggers, classes, web services, ...
[<img src="https://login.salesforce.com/img/logo190.png" align="right" width="300">](https://login.salesforce.com/)

 [Apex Reserved Keywords](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_reserved_words.htm)

## Table of Contents

- [Sections](#sections)
	- [How Does Apex Work?](#how-does-apex-work)
	- [Apex Core Concepts](#apex-core-concepts)
	- [List](#lists)
	- [Maps](#maps)
	- [Trigger and Bulk Request Best Practices](#trigger-and-bulk-request-best-practices)
	- [Using Maps and Sets in Bulk Triggers](#maps-and-sets)
	- [Loops](#loops)
	- [Test Driven Development Process](#test-driven-development-process)
	- [Classes, Objects and Interfaces](#classes-objects-and-interfaces)
	- [Static and Instance Methods, Variables, and Initialization Code](#static-and-instance-methods-variables-and-initialization-code)
	- [Triggers](#triggers)
	- [Apex Test Classes](#apex-test-classes)
	- [Execution Governor and Limits](#execution-governor-and-limits)
	- [Data Maninpulation Language](#data-manipulation-language)

### How Does Apex Work?

When a developer writes and saves Apex code to the platform, the platform application server first compiles the code into an abstract set of instructions that can be understood by the Apex runtime interpreter, and then saves those instructions as metadata.

When an end-user triggers the execution Apex, perhaps by clicking a button or accessing a Visualforce page, the platform application server retrieves the compiled instructions from the metadata and sends them through the runtime interpreter before returning results. 

``
All Apex code runs on the Force.com platform.  To guarantee consistent performance and scalability, the execution of Apex is bound by governor limits that ensure no single Apex execution impacts the overall service of Salesforce.  This means all Apex code is limited by number of operations (such as DML or SOQL) that it can perfrom within one process.
All Apex requests return a collection that contains from 1 to 50,000 records.   You cannot assume that your code works only on a single records at a time.  Therefore, you must implement programming patterns that take bulk processing into account.  Otherwise, you may run into governor limits.
``

### Apex Core Concepts

[<img src="https://developer.salesforce.com/docs/resources/img/en-us/206.0?doc_id=dev_guides%2Fapex%2Fimages%2FAC_Elements.png&folder=apexcode" align="center" width="1000">](https://login.salesforce.com/)

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

This example adds the Acme account to Salesforce. An account sObject is created first and then passed as an argument to the insert statement, which persists the record in Salesforce.
```Apex
// Create the account sObject
Account acct = new Account (Name='Acme', Phone='(415)-635-9877', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
```
