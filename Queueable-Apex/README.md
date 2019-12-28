# Queueable Apex
It is called by `System.enqueueJob()` method, which returns a job ID that you can monitor.  

Queueable Apex allows you to submit jobs for asynchronous processing similar to future methods with the following additional benefits:
* Non-primitive types: Queueable class can contain member variables of non-primitive data types, such as sObjects or custom Apex types. Those objects can be accessed when the job executes.
* Monitoring: When you submit your job by invoking the `System.enqueueJob` method, the method returns the ID of the `AsyncApexJob` record. You can use this ID to identify your job and monitor its progress, either through the Salesforce user interface in the Apex Jobs page, or programmatically by querying your record from `AsyncApexJob`.