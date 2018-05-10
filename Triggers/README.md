# Apex Triggers

## Table of Contents  
* [Apex Trigger Methods](#apex-trigger-methods)
* [Static Variables](#static-variables)
* [Trigger.new](#trigger-new)
##

* [Apex Trigger Context Variables](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_context_variables.htm)
* [Invoking Callouts Using Apex](https://developer.salesforce.com/docs/atlas.en-us.208.0.apexcode.meta/apexcode/apex_callouts.htm)

* Before triggers are used to update or validate record values before they’re saved to the database.
 * After triggers are used to access field values that are set by the system (such as a record's Id or LastModifiedDate field), and to affect changes in other records. The records that fire the after trigger are read-only.
 * To access the records that caused the trigger to fire, use context variables.
* Callouts - Apex calls to external web services

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

## Trigger.new
* 



``Trigger.New contains all the records that were inserted in insert or update triggers.``

``Trigger.Old provides the old version of sObjects before they were updated in update triggers, or a list of deletd sObjects in delete triggers.``

```Apex
trigger HelloWorldTrigger on Account (before insert) {
        for(Account a : Trigger.New) {
            a.Description = 'New description';
        }
}
```

````Apex
trigger ContextVariableExampleTrigger on Account (before insert, after insert, after delete) {
        if (Trigger.isInsert) {
                if (Trigger.isBefore) {
                    // Process before insert
                } else if (Trigger.isAfter) {
                    // Process after insert
                }
         } 
         else if (Trigger.isDelete) {
            // Process after delete
         }
 }
````

 * ``Custom transactional logic - logic that occurs over the entire transaction, not just with a single record or object.``


## Static Variables

Utility class - a class that defines a set of methods that perform common, often re-used functions.  Most utility classes define these common methods under static scope.  

Static variable - a variable that has been allocated statically so that its lifetime or 'extent' extends across the entire run of the program.

Static memory allocation in general is the allocation of memory at compile time before the associated program is executed, unlike dynamic memory allocation automatic memory allocation where memory is allocated as required at runtime.

Automatic variables - (local variables are generally automatic) the storage is allocated and deallocated on the call stack.

Objects - storage is dynamically allocated in heap memory.

### Scope

In terms of scope and context, static variables have extent the entire run of the program, but may have more limited scope.  A basic distinction is between a static global variable, which has global scope and thus is in context throughout the program, and a static local variable, which has local scope.  A `static local variable` is different from a local variable as a static local variable is initialized only once no matter how many times the function in which it resides is called and its value is retained and accessible through many calls to the function in which it is declared.

## Global Variables

`Global Variable` is a variable with a global scope, meaning that it is visible (hence accessible) throughout the program, unless shadowed.  The set of all global variables is known as global environment or global state.

## Apex Trigger Methods
| Syntax | Action | Output |
|------|-----|---|
|`addError`| prevent saving records in a trigger | throws a fatal error inside a trigger |
|`@future(callout=true)` | make a callout from a trigger | call a class method that executes asynchronously | 
