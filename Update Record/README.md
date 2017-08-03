https://developer.salesforce.com/docs/atlas.en-us.208.0.api.meta/api/sforce_api_calls_create.htm
* [Merging Records](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_dml_examples_merge.htm?search_text=try)

```Apex
MyBatchClass myBatchObject = new MyBatchClass(); 
Id batchId = Database.executeBatch(myBatchObject);

```
