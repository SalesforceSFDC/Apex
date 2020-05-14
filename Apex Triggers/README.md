### Types of Triggers
* Before triggers - are used to update or validate record values before they are saved to the database.
* After triggers - are used to access field values that are set by the system (such as record's Id or `LastModifiedDate` field), and to affect changes in other records.  The records that fire the after trigger are read-only.

### Using Context Variables
To access the records that caused the trigger to fire, use context variables. 
* `Trigger.New` contains all the records that were inserted in `insert` or `update` triggers. 
* `Trigger.Old` provides the old version of sObjects before they were updated in update triggers, or a list of deleted sObjects in delete triggers. 

Triggers can fire when one record is inserted, or when many records are inserted in bulk via the API or Apex. Therefore, context variables, such as `Trigger.New`, can contain only one record or multiple records. You can iterate over `Trigger.New` to get each individual sObject.

| Variable | Usage |
| --- | --- |
| isExecuting | Returns true if the current context for the Apex code is a trigger, not a Visualforce page, a Web service, or an executeanonymous() API call. |
| isInsert | Returns true if this trigger was fired due to an insert operation, from the Salesforce user interface, Apex, or the API. |
| isUpdate | Returns true if this trigger was fired due to an update operation, from the Salesforce user interface, Apex, or the API. |
| isDelete | Returns true if this trigger was fired due to a delete operation, from the Salesforce user interface, Apex, or the API. | 
| isBefore | Returns true if this trigger was fired before any record was saved. |
| isAfter | Returns true if this trigger was fired after all records were saved. |
| isUndelete | Returns true if this trigger was fired after a record is recovered from the Recycle Bin. This recovery can occur after an undelete operation from the Salesforce user interface, Apex, or the API. |
| new | Returns a list of the new versions of the sObject records.  This sObject list is only available in insert, update, and undelete triggers, and the records can only be modified in before triggers. |
| newMap | A map of IDs to the new versions of the sObject records.  This map is only available in before update, after insert, after update, and after undelete triggers. |
| old | Returns a list of the old versions of the sObject records.  This sObject list is only available in update and delete triggers. |
| oldMap | A map of IDs to the old versions of the sObject records.  This map is only available in update and delete triggers. |
| operationType | Returns an enum of type System.TriggerOperation corresponding to the current operation.  Possible values of the System.TriggerOperation enum are: BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, and AFTER_UNDELETE. If you vary your programming logic based on different trigger types, consider using the switch statement with different permutations of unique trigger execution enum states. |
| size | The total number of records in a trigger invocation, both old and new. |
