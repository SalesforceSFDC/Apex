# Batch Apex

### [Using Batch Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm)
* build an archiving solution that runs on a nightly basis, looking for records past a certain date and adding them to an archive
* build a data cleansing operation that goes through all Accounts and Opportunities on a nightly basis and updates them if necessary, based on custom criteria
* You can only have five queued or active batch jobs at one time
* You can evaluate your current count by viewing the Scheduled Jobs page in Salesforce or programmatically using SOAP API to query the AsyncApexJob object.

### Using Batch Apex
To use batch Apex, write an Apex class that implements the Salesforce-provided interface `Database.Batchable` and then invoke the class programmatically.
<br/>
The Database.Batchable interface contains three methods that must be implemented.<br/>
#### Start Method:
```java
global (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc)
```
To collect the records or objects to pass to the interface method `execute`, call the start method at the beginning of a batch Apex job.  This method returns either a `Database.QueryLocator` object or an iterable that contains the records or objects passed to the job.
<br/>
If you use a `QueryLocator` object, the governor limit for the total number of records retrieved by SOQL queries is bypassed.  For example, a batch Apex job for the Account object can return a `QueryLocator` for all account records (up to 50 million) in an org.  
<br/>
#### Execute Method
```java
global void execute(Database.BatchableContext bc, list<P>){}
```
To do the required processing for each chunk of data, use the execute method.  This method is called for each batch of records that you pass to it.

This method takes the following:
* A reference to the `Database.BatchableContext` object
* A list of sObjects, such as `List<sObject>`, or a list of parameterized types.  If you are using a `Database.QueryLocator`, use the returned list.
#### Finish Method
```java
global void finish(Database.BatchableContext bc){}
```

To send confirmation emails or execute post-processing operations, use the `finish` method.  This method is called after all batches are processed.

* Each execution of a batch Apex job is considered a discrete transaction.  
* In batch Apex, if the first transaction succeeds but the second fails, the database updates made in the first transaction are not rolled back.

### Using `Database.BatchableContext`
All the methods in the `Database.Batchable` interface require a reference to a `Database.BatchableContext` object.  Use this object to track the progress of the bacth job.

| name | Arguments | Returns | Description |
| --- | --- | --- | --- |
| getjobID | | ID | Returns the ID of the AsyncApexJob object associated with this batch job as a string.  Use this method to track the progress of records in the batch job.  You can use this ID with the System.abortJob method. |
