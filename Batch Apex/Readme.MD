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


