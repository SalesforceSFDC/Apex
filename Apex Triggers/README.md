### Types of Triggers
* Before triggers - are used to update or validate record values before they are saved to the database.
* After triggers - are used to access field values that are set by the system (such as record's Id or `LastModifiedDate` field), and to affect changes in other records.  The records that fire the after trigger are read-only.

### Using Context Variables
To access the records that caused the trigger to fire, use context variables. 
* `Trigger.New` contains all the records that were inserted in `insert` or `update` triggers. 
* `Trigger.Old` provides the old version of sObjects before they were updated in update triggers, or a list of deleted sObjects in delete triggers. 
Triggers can fire when one record is inserted, or when many records are inserted in bulk via the API or Apex. Therefore, context variables, such as `Trigger.New`, can contain only one record or multiple records. You can iterate over `Trigger.New` to get each individual sObject.
