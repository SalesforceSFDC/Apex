https://developer.salesforce.com/docs/atlas.en-us.208.0.api.meta/api/sforce_api_calls_create.htm
* [Merging Records](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_dml_examples_merge.htm?search_text=try)

```Apex
MyBatchClass myBatchObject = new MyBatchClass(); 
Id batchId = Database.executeBatch(myBatchObject);

```
* Custom Index Considerations for Selective SOQL Queries
The following fields are indexed by default.
Primary keys (Id, Name, and OwnerId fields)
Foreign keys (lookup or master-detail relationship fields)
Audit dates (CreatedDate and SystemModstamp fields)
RecordType fields (indexed for all standard objects that feature them)
Custom fields that are marked as External ID or Unique
When the Salesforce optimizer recognizes that an index can improve performance for frequently run queries, fields that aren’t indexed by default are automatically indexed.
Salesforce Support can add custom indexes on request for customers.
A custom index can't be created on these types of fields: multi-select picklists, currency fields in a multicurrency organization, long text fields, some formula fields, and binary fields (fields of type blob, file, or encrypted text.) New data types, typically complex ones, are periodically added to Salesforce, and fields of these types don’t always allow custom indexing.
You can’t create custom indexes on formula fields that include invocations of the TEXT function on picklist fields.
Typically, a custom index isn’t used in these cases.
The queried values exceed the system-defined threshold.
The filter operator is a negative operator such as NOT EQUAL TO (or !=), NOT CONTAINS, and NOT STARTS WITH.
The CONTAINS operator is used in the filter, and the number of rows to be scanned exceeds 333,333. The CONTAINS operator requires a full scan of the index. This threshold is subject to change.
You’re comparing with an empty value (Name != '').
