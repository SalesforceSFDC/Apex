# Apex
## Table of Content
  * [Automatically Indexed Fields](#automatically-indexed-fields)
  * [Bucket Fields in Reports](#bucket-fields-in-reports)
  * [Comma within a field while uploading using Data Loader](#comma-within-a-field-while-uploading-using-data-loader)
  * [Data Skew](#data-skew)
  * [Email Templates](#email-templates)
   * [Governor Limits](#governor-limits)
   * [Links](#links)
   * [Object Relationships](#object-relationships)
   * [Salesforce Reports](#salesforce-reports)
   * [Sharing Rules](#sharing-rules)
   * [Visualforce](#visualforce)
   
##
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
##
A block is a series of statements that are grouped together with curly braces and can be used in any place where a single statement would be allowed. 
## Governor Limits
Different Governor Limits in Salesforce are:
* Per-Transaction Apex Limits
* Force.com Platform Apex Limits
* Static Apex Limits
* Size-Specific Apex Limits
* Miscellaneous Apex Limits
* Email Limits
* Push Notification Limits

## Links
https://www.edureka.co/blog/interview-questions/salesforce-interview-questions/
## Visualforce
Visualforce pages are served from a different domain to improve security standards and block cross site scripting. 
##
WhoID refers to people. Typically: contacts or leads. Example: LeadID, ContactID

WhatID refers to objects. Example: AccountID, OpportunityID
## Sharing Rules
Sharing rules are written to give edit access (public read and write) or public read only access to certain individuals in Salesforce org. Sharing rules are used to extend sharing access to users in public groups or roles. We cannot use sharing rules to restrict data access. It is only used for allowing greater access to records.
## Email templates
* Text - All users can create or change this template
* HTML with letterhead -	Only Administrators and users having “Edit HTML Templates” permissions can create this template based on a letterhead.
* Custom HTML -	Administrators and users having “Edit HTML Templates” permissions can create this template without the need of a letterhead
* Visualforce -	Only administrators and developers can create this template. Advanced functionalities like merging data from multiple records is available only in this template
## Bucket Fields in Reports
A bucket field lets you group related records together by ranges and segments, without the use of complex formulas and custom fields. Bucketing can thus be used to group, filter, or arrange report data. When you create a bucket field, you need to define multiple categories (buckets) that are used to group report values.

The advantage is that earlier, we had to create custom fields to group or segment certain data.
## Salesforce Reports
* Tabular reports -	Simple Excel type tables which provide a list of items with the grand total
* Summary reports -	Similar to Tabular reports, but also have functionality of grouping rows, viewing subtotals & creating charts
* Matrix reports -	Two-dimensional reports which allow you to group records both by row and column
* Joined reports -	Multiple blocks showing data from different reports based on same or different report types
* only Summary reports and Matrix reports can be fed as data source for dashboards. Tabular and Joined reports cannot be used as data source for dashboards.
## Object Relationships
### Master-Detail Relationship (1:n)
It is a parent-child relationship in which the master object controls the behavior of the dependent child object. It is a 1:n relationship, in which there can be only one parent, but many children.The main concept you need to be know is that, being the controlling object, the master field cannot be empty. If a record/ field in master object is deleted, the corresponding fields in the dependent object are also deleted. This is called a cascade delete. Dependent fields will inherit the owner, sharing and security settings from its master.You can define master-detail relationships between two custom objects, or between a custom object and standard object as long as the standard object is the master in the relationship.  You can have a roll-up summary in case of a master-detail relationship. But not in case of a lookup relationship.
#### Roll-up Summary 
A roll-up summary field is used to display a value in a master record based on the values of a set of fields in a detail record. The detail record must be related to the master through a master-detail relationship.

There are 4 calculations that you can do using roll-up summary field. You can count the number of detail records related to a master record. Or, you can calculate the sum, minimum value, or maximum value of a field in the detail records.
### Lookup Relationship (1:n)
Lookup relationships are used when you want to create a link between two objects, but without the dependency on the parent object. Similar to Master-Detail relationship, you can think of this as a form of parent-child relationship where there is only one parent, but many children i.e. 1:n relationship.The difference here is that despite being controlling field, deleting a record will not result in automatic deletion of the lookup field in the child object. Thus the records in the child object will not be affected and there is no cascade delete here. Neither will the child fields inherit the owner, sharing or security settings of its parent.
### Junction Relationship (Many-To-Many)
This kind of a relationship can exist when there is a need to create two master-detail relationships. Two master-detail relationships can be created by linking 3 custom objects. Here, two objects will be master objects and the third object will be dependent on both the objects. In simpler words, it will be a child object for both the master objects.
## Data Skew
“Data skew” is a condition which you will encounter when working for a big client where there are over 10,000 records. When one single user owns that many records we call that condition ‘ownership data skew’.

When such users perform updates, performance issues will be encountered because of “data skew”. This happens when a single user/ members of a single role own most of the records for a particular object.
## Automatically Indexed Fields
Only the following fields are automatically indexed in Salesforce:
* Primary keys (Id, Name and Owner fields).
* Foreign keys (lookup or master-detail relationship fields).
* Audit dates (such as SystemModStamp).
## Comma within a field while uploading using Data Loader
In a Data Loader .CSV, if there is a comma in field content, you will have to enclose the contents within double quotation marks: ” “.
* Custom fields marked as an External ID or a unique field.
