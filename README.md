# Apex
Apex triggers, classes, web services, ...
[<img src="https://login.salesforce.com/img/logo190.png" align="right" width="300">](https://login.salesforce.com/)

 [Apex Reserved Keywords](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_reserved_words.htm)

## Table of Contents

- [Sections](#sections)
	- [How Does Apex Work?](#how-does-apex-work)
	- [Apex Core Concepts](#apex-core-concepts)
	- [Lists](#lists)
	- [Maps](#maps)
	- [Trigger and Bulk Request Best Practices](#trigger-and-bulk-request-best-practices)
	- [Using Maps and Sets in Bulk Triggers](#maps-and-sets)

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

### Lists

- [List Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_list.htm#apex_methods_system_list)

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
