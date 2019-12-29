# Queueable Apex
### reason to use future methods instead of queueable
is when your functionality is sometimes executed synchronously, and sometimes asynchronously. 

It is called by `System.enqueueJob()` method, which returns a job ID that you can monitor.  

Queueable Apex allows you to submit jobs for asynchronous processing similar to future methods with the following additional benefits:
* Non-primitive types: Queueable class can contain member variables of non-primitive data types, such as sObjects or custom Apex types. Those objects can be accessed when the job executes.
* Monitoring: When you submit your job by invoking the `System.enqueueJob` method, the method returns the ID of the `AsyncApexJob` record. You can use this ID to identify your job and monitor its progress, either through the Salesforce user interface in the Apex Jobs page, or programmatically by querying your record from `AsyncApexJob`.
* Chaining jobs: You can chain one job to another job by starting a second job from a running job. Chaining jobs is useful if you need to do some sequential processing.

### Sample Code
A common scenario is to take some set of a sObject records, execute some processing such as making a callout to an external REST endpoint or perform some calculations and then update them in the database asynchronously.

Since `@future` methods are limited to primitive data types (or arrays or collections of primitives), queueable Apex is an ideal choice.  

The following code takes a collection of Account records, sets the `parentId` for each record, and then updates the records in the database.

```java
public class UpdateParentAccount implements Queueable {

    private List<Account> accounts;
    private ID parent;

    public UpdateParentAccount(List<Account> records, ID Id) {
        this.accounts = records;
        this.parent = id;
    }

    public void execute(QueueableContext context) {
        for(Account account : accounts) {
            account.parentId = parent;
            // perform other processing or callout
        }
        update accounts;
    }
}
```
```java
// find all accounts in ‘NY’
List<Account> accounts = [select id from account where billingstate = ‘NY’];
// find a specific parent account for all records
Id parentId = [select id from account where name = 'ACME Corp'][0].Id;
// instantiate a new instance of the Queueable class
UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
// enqueue the job for processing
ID jobID = System.enqueueJob(updateJob);
```

You can use the new job ID to monitor progress, either through the Apex Jobs page or programmatically by querying `AsyncApexJob`:
```java
SELECT Id, Status, NumberOfErrors, FROM AsyncApexJob WHERE Id = :jobID
```