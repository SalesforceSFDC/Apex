Integer NUM = 10;
Account[] accs; // variable declaration
// Clean up old data
accs = [SELECT Id FROM Account WHERE name LIKE 'test%'];
Delete accs;

accs = new Account[NUM];
For (Integer I = 0; I < NUM; I++) { // control structure
    accs[I] = new Account(name='test   ' + I,
          outstandingshares__c = I);
    }
insert accs;
Contact[] cons = new Contact[0]; // Array (list)
For (Account acc : accs) {
    cons.add(new Contact(lastName = acc.nam + '1',
        accountid = acc.id));
    cons.add(new Contact(lastName = acc.nam + '2',
        accountid = acc.id));
    }
Insert cons; // Data (DML) operation

datatype variable_name [ = value];

Account MyAcct = new Account();

Apex types of statements:
1. Assignement (assigning a value to a variable)
2. Conditional (if-else)
3. Loops (Do-while, While, For)
4. Locking
5. DML
6. Transaction control
7. Method invoking
8. Exception handling

// Syntax for creating a list
List <datatype> list_name
    [= new List<datatype>();] |
    [= new List<datatype>{value [, value2. . .]};] |
    ;

// create a list of Integer, and assign it to the variable My_List.
List<Integer> My_List = new List<Integer>();

Set<***datatype***> set_name
   [= new Set<datatype>();] |
   [= new Set<datatype>{value [, value2. . .] };] |
   ;

Set<String> My_String = new Set<String>{'a', 'b', 'c'};

Map<***key_datatype***>, value_datatype> map_name
   [=new map<key_datatype, value_datatype>();] |
   [=new map<key_datatype, value_datatype>
   {key1_value => value1_value
   [, key2_value => value2_value. . .]};] |
   ;

Map<Integer, String> My_Map = new Map<Integer, String>{1 => 'a', 2 => 'b', 3 => 'c'};

if (***Condition***){
// Do this if the condition is true
} else {
// Do this if the condition is not true
}


Understanding Apex Core Concepts
Apex code typically contains many things that you might be familiar with from other programming languages.
Programming elements in Apex
Programming Elements in Apex Code
The section describes the basic functionality of Apex, as well as some of the core concepts.

Using Version Settings
In the Salesforce user interface you can specify a version of the Salesforce API against which to save your Apex class or trigger. This setting indicates not only the version of SOAP API to use, but which version of Apex as well. You can change the version after saving. Every class or trigger name must be unique. You cannot save the same class or trigger against different versions.

You can also use version settings to associate a class or trigger with a particular version of a managed package that is installed in your organization from AppExchange. This version of the managed package will continue to be used by the class or trigger if later versions of the managed package are installed, unless you manually update the version setting. To add an installed managed package to the settings list, select a package from the list of available packages. The list is only displayed if you have an installed managed package that is not already associated with the class or trigger.

The Apex Class Edit page. The Version Settings tab is selected and the Version is set to 16.0.
For more information about using version settings with managed packages, see “About Package Versions” in the Salesforce online help.

Naming Variables, Methods and Classes
You cannot use any of the Apex reserved keywords when naming variables, methods or classes. These include words that are part of Apex and the Force.com platform, such as list, test, or account, as well as reserved keywords.

Using Variables and Expressions
Apex is a strongly-typed language, that is, you must declare the data type of a variable when you first refer to it. Apex data types include basic types such as Integer, Date, and Boolean, as well as more advanced types such as lists, maps, objects and sObjects.

Variables are declared with a name and a data type. You can assign a value to a variable when you declare it. You can also assign values later. Use the following syntax when declaring variables:

1
datatype​ variable_name [ = value];
Tip
Note that the semi-colon at the end of the above is not optional. You must end all statements with a semi-colon.

The following are examples of variable declarations:

1
// The following variable has the data type of Integer with the name Count,
2
// and has the value of 0.
3
Integer Count = 0;
4
// The following variable has the data type of Decimal with the name Total. Note
5
// that no value has been assigned to it.
6
Decimal Total;
7
// The following variable is an account, which is also referred to as an sObject.
8
Account MyAcct = new Account();
In Apex, all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.

Non-primitive data type arguments, such as sObjects, are also passed into methods by value. This fact means that when the method returns, the passed-in argument still references the same object as before the method call and can't be changed to point to another object. However, the values of the object's fields can be changed in the method.

Using Statements
A statement is any coded instruction that performs an action.

In Apex, statements must end with a semicolon and can be one of the following types:
Assignment, such as assigning a value to a variable
Conditional (if-else)
Loops:
Do-while
While
For
Locking
Data Manipulation Language (DML)
Transaction Control
Method Invoking
Exception Handling
A block is a series of statements that are grouped together with curly braces and can be used in any place where a single statement would be allowed. For example:

1
if (true) {
2
    System.debug(1);
3
    System.debug(2);
4
} else {
5
    System.debug(3);
6
    System.debug(4);
7
}
In cases where a block consists of only one statement, the curly braces can be left off. For example:

1
if (true)
2
    System.debug(1);
3
else
4
    System.debug(2);
Using Collections
Apex has the following types of collections:

Lists (arrays)
Maps
Sets
A list is a collection of elements, such as Integers, Strings, objects, or other collections. Use a list when the sequence of elements is important. You can have duplicate elements in a list.

The first index position in a list is always 0.

To create a list:

Use the new keyword
Use the List keyword followed by the element type contained within <> characters.
Use the following syntax for creating a list:

1
List <datatype> list_name
2
   [= new List<datatype>();] |
3
   [=new List<datatype>{value [, value2. . .]};] |
4
   ;
The following example creates a list of Integer, and assigns it to the variable My_List. Remember, because Apex is strongly typed, you must declare the data type of My_List as a list of Integer.

1
List<Integer> My_List = new List<Integer>();
For more information, see Lists.

A set is a collection of unique, unordered elements. It can contain primitive data types, such as String, Integer, Date, and so on. It can also contain more complex data types, such as sObjects.

To create a set:

Use the new keyword
Use the Set keyword followed by the primitive data type contained within <> characters
Use the following syntax for creating a set:

1
Set<datatype> set_name
2
   [= new Set<datatype>();] |
3
   [= new Set<datatype>{value [, value2. . .] };] |
4
   ;
The following example creates a set of String. The values for the set are passed in using the curly braces {}.

1
Set<String> My_String = new Set<String>{'a', 'b', 'c'};
For more information, see Sets.

A map is a collection of key-value pairs. Keys can be any primitive data type. Values can include primitive data types, as well as objects and other collections. Use a map when finding something by key matters. You can have duplicate values in a map, but each key must be unique.

To create a map:

Use the new keyword
Use the Map keyword followed by a key-value pair, delimited by a comma and enclosed in <> characters.
Use the following syntax for creating a map:

1
Map<key_datatype, value_datatype> map_name
2
   [=new map<key_datatype, value_datatype>();] |
3
   [=new map<key_datatype, value_datatype>
4
   {key1_value => value1_value
5
   [, key2_value => value2_value. . .]};] |
6
   ;
The following example creates a map that has a data type of Integer for the key and String for the value. In this example, the values for the map are being passed in between the curly braces {} as the map is being created.

1
Map<Integer, String> My_Map = new Map<Integer, String>{1 => 'a', 2 => 'b', 3 => 'c'};
For more information, see Maps.

Using Branching
An if statement is a true-false test that enables your application to do different things based on a condition. The basic syntax is as follows:

if (Condition){
// Do this if the condition is true
} else {
// Do this if the condition is not true
}
For more information, see Conditional (If-Else) Statements.

Using Loops
While the if statement enables your application to do things based on a condition, loops tell your application to do the same thing again and again based on a condition. Apex supports the following types of loops:

A Do-while loop checks the condition after the code has executed.

A While loop checks the condition at the start, before the code executes.

A For loop enables you to more finely control the condition used with the loop. In addition, Apex supports traditional For loops where you set the conditions, as well as For loops that use lists and SOQL queries as part of the condition.

Unit test methods take no arguments, commit no data to the database, send no emails, and are flagged with the testMethod keyword or the isTest annotation in the method definition. Also, test methods must be defined in test classes, that is, classes annotated with isTest.

@isTest
private class HelloWorldTestClass {
    static testMethod void validateHelloWorld() {
       Book__c b = new Book__c(Name='Behind the Cloud', Price__c=100);
       System.debug('Price before inserting new book: ' + b.Price__c);

       // Insert book
       insert b;

       // Retrieve the new book
       b = [SELECT Price__c FROM Book__c WHERE Id =:b.Id];
       System.debug('Price after trigger fired: ' + b.Price__c);

       // Test that the trigger correctly updated the price
       System.assertEquals(90, b.Price__c);
    }
}

- System.debug statement writes the value of the price in the debug log.
-
Add a Test Class
In this step, you add a test class with one test method. You also run the test and verify code coverage. The test method exercises and validates the code in the trigger and class. Also, it enables you to reach 100% code coverage for the trigger and class.
Prerequisites:
A Salesforce account in a sandbox Professional, Enterprise, Performance, or Unlimited Edition org, or an account in a Developer org.
The HelloWorldTrigger Apex trigger.
Note
Testing is an important part of the development process. Before you can deploy Apex or package it for the Force.com AppExchange, the following must be true.

At least 75% of your Apex code must be covered by unit tests, and all of those tests must complete successfully.
Note the following.
When deploying Apex to a production organization, each unit test in your organization namespace is executed by default.
Calls to System.debug are not counted as part of Apex code coverage.
Test methods and test classes are not counted as part of Apex code coverage.
While only 75% of your Apex code must be covered by tests, your focus shouldn't be on the percentage of code that is covered. Instead, you should make sure that every use case of your application is covered, including positive and negative cases, as well as bulk and single records. This should lead to 75% or more of your code being covered by unit tests.
Every trigger must have some test coverage.
All classes and triggers must compile successfully.
From Setup, enter Apex Classes in the Quick Find box, then select Apex Classes and click New.
In the class editor, add this test class definition, and then click Save.

@isTest
private class HelloWorldTestClass {
    static testMethod void validateHelloWorld() {
       Book__c b = new Book__c(Name='Behind the Cloud', Price__c=100);
       System.debug('Price before inserting new book: ' + b.Price__c);

       // Insert book
       insert b;
       // Retrieve the new book
       b = [SELECT Price__c FROM Book__c WHERE Id =:b.Id];
       System.debug('Price after trigger fired: ' + b.Price__c);

       // Test that the trigger correctly updated the price
       System.assertEquals(90, b.Price__c);
    }
}
This class is defined using the @isTest annotation. Classes defined as such can only contain test methods. One advantage to creating a separate class for testing is that classes defined with isTest don’t count against your org’s limit of 3 MB of Apex code. You can also add the @isTest annotation to individual methods. For more information, see IsTest Annotation and Execution Governors and Limits.

The method validateHelloWorld is defined as a testMethod. This annotation means that if changes are made to the database, they are rolled back when execution completes. You don’t have to delete any test data created in the test method.

First, the test method creates a book and inserts it into the database temporarily. The System.debug statement writes the value of the price in the debug log.

Book__c b = new Book__c(Name='Behind the Cloud', Price__c=100);
System.debug('Price before inserting new book: ' + b.Price__c);
// Insert book
insert b;
After the book is inserted, the code retrieves the newly inserted book, using the ID that was initially assigned to the book when it was inserted. The System.debug statement then logs the new price that the trigger modified.

List<Integer> myList = new List<Integer>(); // Define a new list
myList.add(47);                    // Adds a second element of value 47 to the end
                                       // of the list
Integer i = myList.get(0);                   // Retrieves the element at index 0
myList.set(0, 1);                           // Adds the integer 1 to the list at index 0
myList.clear();                    // Removes all elements from the list

-  List.sort method, you can sort elements in a list.
- set is an unordered collection of elements that do not contain any duplicates.

new Set<String>()
Set<String> s1 = new Set<String>{'a', 'b + c'}; // Defines a new set with two elements
Set<String> s2 = new Set<String>(s1); // Defines a new set that contains the
                                     // elements of the set created in the previous step
                                     Set<Integer> s = new Set<Integer>(); // Define a new set
                                     s.add(1);                            // Add an element to the set
                                     System.assert(s.contains(1));        // Assert that the set contains an element
                                     s.remove(1);                         // Remove the element from the set


Map<String, String> country_currencies = new Map<String, String>();
Map<ID, Set<String>> m = new Map<ID, Set<String>>();

Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};

Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
m.put(1, 'First entry');                  // Insert a new key-value pair in the map
m.put(2, 'Second entry');                  // Insert a new key-value pair in the map
System.assert(m.containsKey(1));  // Assert that the map contains a key
String value = m.get(2);               // Retrieve a value, given a particular key
System.assertEquals('Second entry', value);
Set<Integer> s = m.keySet();       // Return a set that contains all of the keys in the map
