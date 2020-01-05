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
   * [Platform Events](#platform-events)
     * [Components of Event-Driven Systems](#components-of-event-driven-systems)
     * [Platform Events and sObjects](#platform-events-and-sobjects)
     * [Subscribe to Platform Event Notifications with Apex Triggers](#subscribe-to-platform-event-notifications-with-apex-triggers)
     * [Using Platform Events in Native and External Apps](#using-platform-driven-events-in-native-and-external-apps)
   * [Profiles and Roles](profiles-and-roles)
   * [sObjects](#sobjects)
   * [Salesforce Reports](#salesforce-reports)
   * [Sharing Rules](#sharing-rules)
   * [SOQL](#soql)
   * [SOSL](#sosl)
   * [Triggers](#triggers)
   * [Variables](#variables)
   * [Visualforce](#visualforce)
   * [Workflow Rules](#workflow-rules)
   
##
* <b>Static method</b> - with this method there is no need to create an instance of a class to access the method, use the name of the class followed by dot(.) and the name of the method.
##### Iterate over a list of books and update price field for each book
```apex
public class IterateOverBooks {
  public static void applyDiscount(Book__c[] books) {
    for (Book__c b :books) {
      b.Price__c *= 0.9;
    }
  }
}
```
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
#### Undelete an Employee Record
```json
{
  "schema":"TIOb-jG_qRb2ucSBIdByMA",
  "payload":{
    "LastModifiedDate":"2018-09-20T21:52:27Z",
    "OwnerId":"005B0000004xULvIAM",
    "CreatedById":"005B0000004xULvIAM",
    "ChangeEventHeader":{  
      "isTransactionEnd":true,
      "commitNumber":10341195374106,
      "commitUser":"005B0000004xULvIAM",
      "sequenceNumber":1,
      "entityName":"Employee__c",
      "changeType":"UNDELETE",
      "changeOrigin":"com/salesforce/api/soap/44.0;client=devconsole",
      "transactionKey":"000a9934-32e1-ed11-a74d-8c735d12841c",
      "commitTimestamp":1537480347000,
      "recordIds":[  
        "a00B00000098x4aIAA"
      ]
    },
    "CreatedDate":"2018-09-20T21:30:06Z",
    "First_Name__c":"Trish",
    "LastModifiedById":"005B0000004xULvIAM",
    "Tenure__c":3.0,
    "Name":"e-100",
    "Last_Name__c":"Smith"
  },
  "event":{  
    "replayId":16908128
  }
}
```
#### Update an Employee Record
```json
{
  "schema":"TIOb-jG_qRb2ucSBIdByMA",
  "payload":{
    "LastModifiedDate":"2018-09-20T21:31:08Z",
    "ChangeEventHeader":{ 
      "isTransactionEnd":true,
      "commitNumber":10341190536560,
      "commitUser":"005B0000004xULvIAM",
      "sequenceNumber":1,
      "entityName":"Employee__c",
      "changeType":"UPDATE",
      "changeOrigin":"com/salesforce/api/soap/44.0;client=SfdcInternalAPI/",
      "transactionKey":"000861c7-a3cb-f5bf-8c8a-a5e3cf9b8278",
      "commitTimestamp":1537479068000,
      "recordIds":[
        "a00B00000098x4aIAA"
      ]
    },
    "First_Name__c":"Trish",
    "Tenure__c":3.0
  },
  "event":{ 
    "replayId":16907799
  }
}
```
#### Create an Employee Record
```json
{  
  "schema":"TIOb-jG_qRb2ucSBIdByMA",
  "payload":{
    "LastModifiedDate":"2018-09-20T21:30:06Z",
    "OwnerId":"005B0000004xULvIAM",
    "CreatedById":"005B0000004xULvIAM",
    "ChangeEventHeader":{
      "isTransactionEnd":true,
      "commitNumber":10341190291016,
      "commitUser":"005B0000004xULvIAM",
      "sequenceNumber":1,
      "entityName":"Employee__c",
      "changeType":"CREATE",
      "changeOrigin":"com/salesforce/api/soap/44.0;client=SfdcInternalAPI/",
      "transactionKey":"000861b9-2218-2464-9404-c16b0e2fee71",
      "commitTimestamp":1537479006000,
      "recordIds":[ 
        "a00B00000098x4aIAA"
      ]
    },
    "CreatedDate":"2018-09-20T21:30:06Z",
    "First_Name__c":"Patricia",
    "LastModifiedById":"005B0000004xULvIAM",
    "Name":"e-100",
    "Last_Name__c":"Smith"
  },
  "event":{  
    "replayId":16907794
  }
}
```
## Platform Events
Event driven software architecture.  With platform events, you can publish any custom data. You define the schema of event data at a granular level as typed fields. Also, you can use platform events in native Salesforce platform apps and external apps alike. Use platform events in the following cases:
* To send and receive custom event data with a predefined schema
* To publish or subscribe to events in Apex
* For the flexibility of publishing and processing events on and off the Salesforce platform

| Feature | Generic Event | Platform Event |
| --- | --- | --- |
| Define event schema as typed fields | NO | YES |
| Include user-defined payloads | YES | YES |
| Publish events via one or more APIs | YES | YES |
| Publish events via Apex | NO | YES |
| Subscribe via CometD | YES | YES |
| Subscribe via Apex triggers | NO | YES |
Publish declaratively using Process Builder and flows | NO | YES |

### Components of Event-Driven Systems
#### Event
A change in state that is meaningful in a business process. For example, placement of a purchase order is a meaningful event, because the order fulfillment center expects to receive a notification before processing an order.
#### Event Message
A message that contains data about the event. Also known as an event notification. For example, an event message can be a notification about an order placement containing information about the order.
#### Event Producer
The publisher of an event message over a channel. For example, an order placement app.
#### Event Channel
A stream of events on which an event producer sends event messages and event consumers read those messages. Also called an event bus in Salesforce.
#### Event Consumer
A subscriber to a channel that receives messages from the channel. For example, an order fulfillment app that is notified of new orders.

### Platform Events and sObjects
An event message is an instance of a platform event, similar to how a record is an instance of a custom object.  
You can set read and create permissions for platform events. You grant permissions to users in profiles or in permission sets.
### Using Platform Events in Native and External Apps
Apps on the Salesforce platform use an Apex method to publish events and an Apex trigger to consume events. Also, Visualforce and Lightning component apps can subscribe to events using CometD. As an alternative to code, you can publish events with declarative tools, such as Process Builder and Cloud Flow Designer. Finally, external apps publish events using the sObject API and consume events using CometD clients. 
### Subscribe to Platform Event Notifications with Apex Triggers
* write an after insert Apex trigger on the event object to subscribe to incoming events. 
* Triggers provide an autosubscription mechanism in Apex.
* Triggers receive event notifications from various sources—whether they’re published through Apex or APIs.
* Platform events support only after insert triggers.
* After an event message is published, the after insert trigger is fired.
* Salesforce app uses a trigger to listen to events. 
#### Order of Event Processing
* A trigger processes platform event notifications sequentially in the order they’re received.
* The order of events is based on the event replay ID.
* An Apex trigger can receive a batch of events at once. 
* The order of events is preserved within each batch. 
* The events in a batch can originate from one or more publishers.
#### Asynchronous Trigger Execution
A platform event trigger runs in its own process asynchronously and isn’t part of the transaction that published the event. As a result, there might be a delay between when an event is published and when the trigger processes the event.
#### Automated Process System User
* event triggers don’t run under the user who executes them (the running user) but under the Automated Process system user
*  If you create a Salesforce record with an OwnerId field in the trigger, such as a case or opportunity, explicitly set the owner ID. 
* For cases and leads, you can, alternatively, use assignment rules to set the owner.
* system fields of records created or updated in the event trigger, such as CreatedById and LastModifiedById, reference the Automated Process entity and not the running user. 
* the Apex `UserInfo.getUserId()` statement returns the Automated Process entity.
#### Apex Trigger Limitations
Platform event triggers share many of the same limitations of custom and standard object triggers. For example, you can’t make Apex callouts synchronously from triggers.

## Variables

### Instance Variable


#
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

## Table of Contents
* [Database Methods](#database-methods)
* [DML Statements](#dml-statements)
* [For Loops](#for-loops)
* [Important Reserved Keywords](#important-reserved-keywords)
* [Instance Methods and Variables](#instance-methods-and-variables)
* [SOQL For Loops](#soql-for-loops)
* [Static Methods](#static-methods)
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

