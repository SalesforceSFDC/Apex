 * Before triggers are used to update or validate record values before they’re saved to the database.
 * After triggers are used to access field values that are set by the system (such as a record's Id or LastModifiedDate field), and to affect changes in other records. The records that fire the after trigger are read-only.
 * To access the records that caused the trigger to fire, use context variables.


```apex
tigger HelloWorldTrigger on Account (before insert) {
    System.debug('Hello World!');
}
```

```Apex
Account a = new Account(Name='Test Trigger');
insert a;
```

 * To access the records that caused the trigger to fire, use context variables.  

``Trigger.New contains all the records that were inserted in insert or update triggers.``

``Trigger.Old provides the old version of sObjects before they were updated in update triggers, or a list of deletd sObjects in delete triggers.``
