# Apex

* execute flow and transaction control statements on Salesforce servers in conjunction with calls to the API.
* add business logic to system events (button clicks, related record updates, Vf pages)
* Apex acts like database stored procedures
* Apex code can be initiated by Web service requests and from triggers on objects
* Developers write and save Apex code to the platform, and end users trigger the execution of the Apex code via the user interface.
* Data manipulation language (DML) calls, such as INSERT, UPDATE, and DELETE, that include built-in DmlException handling
* Inline Salesforce Object Query Language (SOQL) and Salesforce Object Search Language (SOSL) queries that return lists of sObject records
* Looping that allows for bulk processing of multiple records at a time
* Locking syntax that prevents record update conflicts
* Custom public API calls that can be built from stored Apex methods
* Warnings and errors issued when a user tries to edit or delete a custom object or field that is referenced by Apex
* Apex is designed to thread together multiple query and DML statements into a single unit of work on the Salesforce server. 
* Apex is a strongly typed language that uses direct references to schema objects such as object and field names. It fails quickly at compile time if any references are invalid. It stores all custom field, object, and class dependencies in metadata to ensure that they are not deleted while required by active Apex code.
* In Apex, all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. Therefore, when the method returns, the passed-in argument still references the same object as before the method call. Within the method, the reference can't be changed to point to another object but the values of the object's fields can be changed.
### Statements
In Apex, statements must end with a semicolon and can be one of the following types:
* Assignment, such as assigning a value to a variable
* Conditional (if-else)
* Loops:
    * Do-while
    * While
    * For
* Locking
* Data Manipulation Language (DML)
* Transaction Control
* Method Invoking
* Exception Handling
### Lists
```Apex
List<datatype> list_name
   [= new List<datatype>();] |
   [= new List<datatype>{value [, value2...]};] |
   ;
```
### Sets
```Apex
Set<datatype> set_name 
   [= new Set<datatype>();] |
   [= new Set<datatype>{value [, value2. . .] };] |
   ;
```
### Maps
A map is a collection of key-value pairs. Keys can be any primitive data type. Values can include primitive data types, as well as objects and other collections. Use a map when finding something by key matters. You can have duplicate values in a map, but each key must be unique.
```Apex
Map<key_datatype, value_datatype> map_name
   [=new map<key_datatype, value_datatype>();] | 
   [=new map<key_datatype, value_datatype>
   {key1_value => value1_value 
   [, key2_value => value2_value. . .]};] |
   ;
```
### Using Loops
While the if statement enables your application to do things based on a condition, loops tell your application to do the same thing again and again based on a condition. Apex supports the following types of loops:

Do-while
While
For
A Do-while loop checks the condition after the code has executed.

A While loop checks the condition at the start, before the code executes.

A For loop enables you to more finely control the condition used with the loop. In addition, Apex supports traditional For loops where you set the conditions, as well as For loops that use lists and SOQL queries as part of the condition.

