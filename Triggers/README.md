 * Before triggers are used to update or validate record values before they’re saved to the database.
 * After triggers are used to access field values that are set by the system (such as a record's Id or LastModifiedDate field), and to affect changes in other records. The records that fire the after trigger are read-only.
 * To access the records that caused the trigger to fire, use context variables.


```apex
tigger HelloWorldTrigger on Account (before insert) {
    System.debug('Hello World!');
}
```
