# Batch Apex

* build an archiving solution that runs on a nightly basis, looking for records past a certain date and adding them to an archive
* build a data cleansing operation that goes through all Accounts and Opportunities on a nightly basis and updates them if necessary, based on custom criteria
* You can only have five queued or active batch jobs at one time
* You can evaluate your current count by viewing the Scheduled Jobs page in Salesforce or programmatically using SOAP API to query the AsyncApexJob object.
* To use batch Apex, write an Apex class that implements the Salesforce-provided interface Database.Batchable and then invoke the class programmatically.
* The Database.Batchable interface contains three methods that must be implemented.
  * <b>Start Method</b> = `global (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext ***bc***) {}`
  * This method returns either a `Database.QueryLocator` object or an iterable that contains the records or objects passed to the job.
  * a batch Apex job for the Account object can return a QueryLocator for all account records (up to 50 million records) in an org
  * <b>Execute Method</b> = 
