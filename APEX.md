# Apex
## Table of Content
  * [Bucket Fields in Reports](#bucket-fields-in-reports)
  * [Email Templates](#email-templates)
   * [Governor Limits](#governor-limits)
   * [Links](#links)
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
