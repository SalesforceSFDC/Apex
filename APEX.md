# Apex
## Table of Content
  * [Apex Transaction](#apex-transaction)
  * [Assignment Rules](#assignment-rules)
  * [Asynchronous Apex](#asynchronous-apex)
  * [Automatically Indexed Fields](#automatically-indexed-fields)
  * [Batch Apex](#batch-apex)
  * [Bucket Fields in Reports](#bucket-fields-in-reports)
  * [Change Data Capture](#change-data-capture)
    * [Object Support](#object-support)
    * [Required User Permissions](#required-user-permissions)
    * [Streaming Events](#streaming-events)
    * [Subscribing to an Event Channel](#subscribing-to-an-event-channel)
    * [Subscription Channels](#subscription-channels)
    * [Subscribe Using EMP Connector](#subscribe-using-emp-connector)
  * [Collections](#collections)
    * [Sets](#sets)
  * [Comma within a field while uploading using Data Loader](#comma-within-a-field-while-uploading-using-data-loader)
  * [Components](#components)
  * [Controllers](#controllers)
  * [Custom Labels](#custom-labels)
  * [Custom Settings](#custom-settings)
  * [Data Skew](#data-skew)
  * [Deterministic and Nondeterministic Formula Fields](#deterministic-nondeterministic-formula-fields)
  * [Email Templates](#email-templates)
  * [External ID](#external-id)
  * [Getter and Setter Methods](#getter-and-setter-methods)
   * [Governor Limits](#governor-limits)
   * [Integration Patterns](#integration-patterns)
   * [Links](#links)
   * [Object Relationships](#object-relationships)
   * [Profiles and Roles](profiles-and-roles)
   * [sObjects](#sobjects)
   * [Salesforce Reports](#salesforce-reports)
   * [Sharing Rules](#sharing-rules)
   * [SOQL](#soql)
   * [SOSL](#sosl)
   * [Triggers](#triggers)
   * [Visualforce](#visualforce)
   * [Workflow Rules](#workflow-rules)
   
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
* The Governor Limits enforces the following:
  * Maximum number of records that can be retrieved by SOQL command: 50,000.
  * Maximum number of records that can be retrieved by SOSL command: 2,000.

## Links
https://www.edureka.co/blog/interview-questions/salesforce-interview-questions/
## Visualforce
Visualforce pages are served from a different domain to improve security standards and block cross site scripting. 
To control the number of records displayed on each page, we use pagination. By default, a list controller returns 20 records on the page. To customize it, we can use a controller extension to set the pageSize. 
```apex
<apex:page standardController="Account" recordSetvar="accounts">
 <apex:pageBlock title="Viewing Accounts">
 <apex:form id="theForm">
 <apex:pageBlockSection >
 <apex:dataList var="a" value="{!accounts}" type="1">
 {!a.name}
 </apex:dataList>
 </apex:pageBlockSection>
 <apex:panelGrid columns="2">
 <apex:commandLink action="{!previous}">Previous</apex:commandlink>
 <apex:commandLink action="{!next}">Next</apex:commandlink>
 </apex:panelGrid>
 </apex:form>
 </apex:pageBlock>
</apex:page>
```
Data bindings and Action bindings are the most common and they will be used in every Visualforce page.
There are three types of bindings used in Salesforce:
* Data bindings, which refer to the data set in the controller
* Action bindings, which refer to action methods in the controller
* Component bindings, which refer to other Visualforce components.

##
WhoID refers to people. Typically: contacts or leads. Example: LeadID, ContactID

WhatID refers to objects. Example: AccountID, OpportunityID

You can get the ID’s of all the currently logged in users by using this global function: UserInfo.getUserId().
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
## Workflow Rules
* Time dependent workflow action cannot be create for: “created, and every time it’s edited”.
## Custom Settings
There are two types of custom settings in Salesforce: List Custom Settings and Hierarchy Custom Settings.

List Custom Settings are a type of custom settings that provides a reusable set of static data that can be accessed across your organization irrespective of user/ profile. 
Hierarchy Custom Settings are another type of custom settings that uses built-in hierarchical logic for “personalizing” settings for specific profiles or users.

The advantage of using custom settings is that it allows developers to create a custom set of access rules for various users and profiles.
## Assignment Rules
* Only one rule can be active at a time.
## Custom Labels
Custom labels are custom text values that can be accessed from Apex classes or Visualforce pages. The values here can be translated into any language supported by Salesforce. 
Their benefit is that they enable developers to create multilingual applications which automatically presents information in a user’s native language.

You can create up to 5,000 custom labels for your organization, and they can be up to 1,000 characters in length.
## Profiles and Roles
As mentioned in one of the previous Salesforce interview questions, a profile will ultimately control access to which records a user has in a Salesforce org. No user can work on the Salesforce org without being assigned a profile. The Profile is therefore mandatory for every user.

Role however is not mandatory for every user. The primary function of the Role/ Role hierarchy is that it allows higher level users in hierarchy get access to records owned by lower level users in the hierarchy. An example of that is Sales Managers getting access to records owned by Sales Reps while their peers do not get access to it.
## Deterministic and Nondeterministic Formula Fields
Formula fields whose value will be static are referred to as deterministic fields. Whereas, formula fields whose value will be changed dynamically or whose values will have to be calculated on the fly, they are referred to as non-deterministic formula fields. A classic example of that is a formula returning the current date and time.

Some examples of non-deterministic fields in Force.com are:

Lookup fields
Formula fields whose reference spans over other entities
Fields having dynamic date functions like:- TODAY() or NOW()
## External ID
An external ID is a custom field which can be used as a unique identifier in a record. External IDs are mainly used while importing records/ data. When importing records, one among the many fields in those records need to be marked as an external ID (unique identifier).

An important point to note is that only custom fields can be used as External IDs. The fields that can be marked as external IDs are: Text, Number, E-Mail and Auto-Number.
## Integration Patterns
You can expose your Apex class and methods so that external applications can access your code and your application through the REST architecture. This is done by defining your Apex class with the @RestResource annotation to expose it as a REST resource. You can then use global classes and a WebService callback method.

Invoking a custom Apex REST Web service method always uses system context. Consequently, the current user’s credentials are not used, and any user who has access to these methods can use their full power, regardless of permissions, field-level security, or sharing rules. 

Developers who expose methods using the Apex REST annotations should therefore take care that they are not inadvertently exposing any sensitive data. 
```apex
global class AccountPlan {
  webservice String area; 
  webservice String region; 
  //Define an object in apex that is exposed in apex web service
  global class Plan {
  webservice String name;
  webservice Integer planNumber;
  webservice Date planningPeriod;
  webservice Id planId;
 }
  webservice static Plan createAccountPlan(Plan vPlan) {
  //A plan maps to the Account object in salesforce.com. 
  //So need to map the Plan class object to Account standard object
  Account acct = new Account();
  acct.Name = vPlan.name;
  acct.AccountNumber = String.valueOf(vPlan.planNumber);
  insert acct;
  vPlan.planId=acct.Id;
  return vPlan;
 } 
}
```
## Controllers
Standard controller in Apex, inherits all the standard object properties and standard button functionality directly. It contains the same functionality and logic that are used for standard Salesforce pages.

Custom controller is an Apex class that implements all of the logic for a page without leveraging a standard controller. Custom Controllers are associated with Visualforce pages through the controller attribute.
* To call a controller method (Apex function) from JavaScript, you need to use actionfunction.
```javascript
<script>
function JSmethodCallFromAnyAction()
{
callfromJS();
}
</apex:page>
```
## Components
An attribute tag is a definition of an attribute of a custom component and it can only be a child of a component tag.

Note that you cannot define attributes with names like id or rendered. These attributes are automatically created for all custom component definitions. 
```apex
<apex:component>
 <apex:attribute name="myValue" description="This is the value for the component." type="String" required="true"/>
 <apex:attribute name="borderColor" description="This is color for the border." type="String" required="true"/>
  
</p>
<p>
</p>
<h1 style="border:{!borderColor}">
 <apex:outputText value="{!myValue}"/>
 </h1>
<p>
</p>
<p>
 
</apex:component>
```
## Collections
Collections are the type of variables which can be used to store multiple number of records (data).
It is useful because Governor Limits restrict the number of records you can retrieve per transaction. Hence, collections can be used to store multiple records in a single variable defined as type collection and by retrieving data in the form of collections, Governor Limits will be in check. Collections are similar to how arrays work.
There are 3 collection types in Salesforce:
* Lists
* Maps
* Sets
Maps are used to store data in the form of key-value pairs, where each unique key maps to a single value. 
Syntax: `Map<String, String> country_city = new Map<String, String>();`
## Asynchronous Apex
Future annotations are used to identify and execute methods asynchronously. If the method is annotated with “@future”, then it will be executed only when Salesforce has the available resources.

For example, you can use it while making an asynchronous web service callout to an external service. Whereas without using the annotation, the web service callout is made from the same thread that is executing the Apex code, and no additional processing will occur until that callout is complete (synchronous processing).
## Batch Apex
Database.Batchable interface contains three methods that must be implemented:
* Start method:
global (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {}
* Execute method:
global void execute(Database.BatchableContext BC, list<P>){}
* Finish method:
global void finish(Database.BatchableContext BC){}

## Triggers
Triger.new is a command which returns the list of records that have been added recently to the sObjects. To be more precise, those records will be returned which are yet to be saved to the database. Note that this sObject list is only available in insert and update triggers, and the records can only be modified in before triggers.

But just for your information, Trigger.old returns a list of the old versions of the sObject records. Note that this sObject list is only available in update and delete triggers.
## Sets
Sets can have any of the following data types:
* Primitive types
* Collections
* sObjects
* User-defined types
* Built-in Apex types
## sObjects
An sObject is any object that can be stored in the Force.com platform database. Apex allows the use of generic sObject abstract type to represent any object.

For example, Vehicle is a generic type and Car, Motor Bike all are concrete types of Vehicle.
In SFDC, sObject is generic and Account, Opportunity, CustomObject__c are its concrete type.
## SOQL
* Only one object can be searched at a time
* Can query any type of field
* Can be used in classes and triggers
* DML Operation can be performed on query results
* Returns records
## SOSL
* Many objects can be searched at a time
* Can query only on email, text or phone
* Can be used in classes, but not triggers
* DML Operation cannot be performed on search results
* Returns fields
## Apex Transaction
An Apex transaction represents a set of operations that are executed as a single unit. The operations here include the DML operations which are responsible for querying records. All the DML operations in a transaction either complete successfully, or if an error occurs even in saving a single record, then the entire transaction is rolled back.
* Global class is accessible across the Salesforce instance irrespective of namespaces.
* Whereas, public classes are accessible only in the corresponding namespaces.
## Getter and Setter Methods
* Get (getter) method is used to pass values from the controller to the VF page.
* Whereas, the set (setter) method is used to set the value back to controller variable.
## Change Data Capture
Change Data Capture is a streaming product on the Lightning Platform that enables you to efficiently integrate your Salesforce data with external systems. With Change Data Capture, you can receive changes of Salesforce records in real time and synchronize corresponding records in an external data store. Change Data Capture publishes events for changes in Salesforce records corresponding to create, update, delete, and undelete operations.  Use Change Data Capture to update data in an external system instead of doing periodic exports or API polling. 
Change Data Capture is part of the data replication process for the cloud. Data replication includes the following stages:
* Day 0 copy of the entire data set to the external system
* Continuous synchronization of new and updated data to the external system (it publishes the deltas of Salesforce data, whether for new records or changed records. Change Data Capture requires an integration app for receiving events and performing updates in the external system)
* Reconciliation of duplicate data between the two systems
* Receiving events for new, changed, deleted, and undeleted Salesforce records is the best suited scenario for Changed Data Capture.
### Streaming Events
Streaming events are instant notification messages that one system (the publisher) sends to another (the subscriber). With push technology, the publisher pushes data to the subscriber. This is the opposite of pull technology. With pull technology, clients request data from the server periodically. When you connect systems through pull technology, clients poll the server for data updates, and freshness of data depends on the poll frequency.  Notification  messages are sent to the event bus to which clients can subscribe through a channel. Event-driven systems streamline the communication between distributed enterprise systems, increase scalability, and deliver real-time data.
### Object Support
* Change Data Capture can generate change events for all custom objects defined in your Salesforce org and a subset of standard objects.
* It supports change events for the most popular standard objects including Account, Contact, Lead, User, Order, OrderItem, Product2, and others.
```json
{
   "schema":"TIOb-jG_qRb2ucSBIdByMA",
   "payload":{
     "ChangeEventHeader":{
       "entityName":"Employee__c",
       "recordIds":[
          "a00xx0000004GvqAAE"
       ],
       "changeType":"CREATE",
       "changeOrigin":"com/salesforce/api/soap/44.0;client=GetCloudy",
       "transactionKey":"00059b44-a6c7-ffa7-af68-8a455868ed30",
       "sequenceNumber":1,
       "isTransactionEnd":true,
       "commitTimestamp":1533160499000,
       "commitUser":"005xx000001SwSiAAK",
       "commitNumber":356619267
    },
    "First_Name__c":"Jane",
    "Last_Name__c":"Smith",
    "Name":"e-100",
    "Tenure__c":2.0,     
    "LastModifiedDate":"2018-08-01T21:54:58Z",
    "OwnerId":"005xx000001SwSiAAK",
    "CreatedById":"005xx000001SwSiAAK",
    "CreatedDate":"2018-08-01T21:54:58Z",
    "LastModifiedById":"005xx000001SwSiAAK",
   },
   "event":{
     "replayId":1
   }
}
```
* `changeOrigin` - Use this field to detect whether your app initiated the change.
* `transactionKey` - The transactionKey field uniquely identifies the transaction that the change is part of.
* `sequenceNumber` - The sequenceNumber field identifies the sequence of the change within a transaction. The sequence number is useful for operations that include multiple steps, such as lead conversion or creating related records in an after insert  Apex trigger. 
* `isTransactionEnd` - indicates whether the change is the last step in the sequence
* `replayId` - This field contains an ID for the event message that you can use to replay past events for up to 3 days. 
### Subscribing to an Event Channel
*  `lightning:empApi Lightning component` - To receive instant notifications of Salesforce data changes in an app that is running on the Lightning Platform.  Your streaming app receives events in real time whenever a change occurs in Salesforce. 
### Subscription Channels
| Subscribe to change events for: | Channel | Example |
| --- | --- | --- |
| All objects | `/data/ChangeEvents` | N/A |
| A standard object | `/data/<Standard_Object_Name>ChangeEvent` | For accounts, the channel is: /data/AccountChangeEvent |
| A custom object | `/data/<Custom_Object_Name>__ChangeEvent` | For Employee__c records, the channel is: /data/Employee__ChangeEvent |
### Required User Permissions
Change Data Capture ignores sharing settings and sends change events for all records of a Salesforce object. To receive change events, the subscribed user must have one or more permissions depending on the channel that is subscribed to.

| Channel | Required Permission |
| --- | --- |
| `/data/ChangeEvents` | View All Data AND View All Users |
| `/data/UserChangeEvent` | View All Users |
| `/data/<Standard_Object_Name>ChangeEvent` OR `/data/<Custom_Object_Name>__ChangeEvent` | View All for the object OR View All Data |
### Subscribe Using EMP Connector
EMP Connector is an open-source sample tool that subscribes to streaming channels using Streaming API and CometD.  EMP Connector is a thin wrapper around the CometD library and is implemented in Java. The tool subscribes to a channel, receives notifications, and prints them out to the console. It also supports replaying events with durable streaming. 
#### Delete an Employee Record
```json
{
  "schema":"TIOb-jG_qRb2ucSBIdByMA",
  "payload":{  
    "ChangeEventHeader":{  
      "isTransactionEnd":true,
      "commitNumber":10341190702886,
      "commitUser":"005B0000004xULvIAM",
      "sequenceNumber":1,
      "entityName":"Employee__c",
      "changeType":"DELETE",
      "changeOrigin":"com/salesforce/api/soap/44.0;client=SfdcInternalAPI/",
      "transactionKey":"000861d2-b189-aa52-d7f6-4a635aa1ce03",
      "commitTimestamp":1537479116000,
      "recordIds":[  
        "a00B00000098x4aIAA"
      ]
    }
  },
  "event":{
    "replayId":16907802
  }
}
```
