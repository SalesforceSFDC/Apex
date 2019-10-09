## Table of Contents
  * [Asynchronous Programming](#asynchronous-programming)
  * [Future Methods](#future-methods)

1. Use a map because it doesn't allow duplicate values

2. Access all the information in a single query rather than querying as you need it.
    This is a best practice for bulkifying requests
    ```for(item__c i :itemList) {}`

3. Take a list and put it into a Map.  This will make it easier to look up a shipping invoice because you must iterate a list, but you can use lookup for a map.

4. Treat updates like a removal of the old item and addition of the revised item rather than figuring out the differences of each field and acting accordingly.
* Note updates have both trigger.new and trigger.old

5. never hard code values.  Leveraging Custom Settings for values is a best practice.

6. Only use one DML update at the end.  This minimizes the number of DML requests generated from this trigger.

7. It's a best practice to either use defaults or to explicitly set all values to zero so as to avoid having extraneous data in your test.

```apex
Shipping_Invoice__C order1 = new Shipping_Invoice__C(subtotal__c = 0,
                          totalweight__c = 0, grandtotal__c = 0,
                          ShippingDiscount__c = 0, Shipping__c = 0, tax__c = 0);
```

## Asynchronous Programming
The following three reasons are usually behind choosing asynchronous programming:
Processing a very large number of records. This reason is unique to the multi-tenanted world of the Lightning Platform where limits rule. The limits associated with asynchronous processes are higher than those with synchronous processes. Therefore, if you need to process thousands or even millions of records, asynchronous processing is your best bet.

Making callouts to external web services. Callouts can take a long time to process, but in the Lightning Platform, triggers can’t make callouts directly.

Creating a better and faster user experience by offloading some processing to asynchronous calls. Why do everything at once? If it can wait, let it.

### Asynchronous Apex
* use Asynchronous Apex for callouts to external systems, operations that require higher limits, and code that needs to run at a certain time.

The key benefits of asynchronous processing include:
* User efficiency
* Scalability - allows the platform to handle more jobs using parallel processing
* Higher Limits - higher governor and execution limits
Type | 	Overview | Common Scenarios
--- | --- | ---
Future Methods | Run in their own thread, and do not start until resources are available. | Web service callout.
Batch Apex | Run large jobs that would exceed normal processing limits. | Data cleansing or archiving of records.
Queueable Apex | Similar to future methods, but provide additional job chaining and allow more complex data types to be used. | Performing sequential processing operations with external Web services.
Scheduled Apex | Schedule Apex to run at a specified time. | Daily or weekly tasks.

* a common pattern is to kick off a Batch Apex job from a Scheduled Apex job.
* the number of SOQL queries is doubled from 100 to 200 queries when using asynchronous calls. The total heap size and maximum CPU time are similarly larger for asynchronous calls.
* async governor limits are independent of the limits in the synchronous request that queued the async request initially

### How Asynchronous Processing Works
* Ensure fairness of processing - Make sure every customer gets a fair share of processing resources.
* Ensure fault tolerance - Make sure no asynchronous requests are lost due to equipment or software failures.  The platform uses a queue-based asynchronous processing framework. This framework is used to manage asynchronous requests for multiple organizations within each instance. The request lifecycle is made up of three parts:
    * Enqueue - The request gets put into the queue. This could be an Apex batch request, future Apex request or one of many others. The platform will enqueue requests along with the appropriate data to process that request.
    * Persistence - The enqueued request is persisted. Requests are stored in persistent storage for failure recovery and to provide transactional capabilities.
    * Dequeue - The enqueued request is removed from the queue and processed. Transaction management occurs in this step to assure messages are not lost if there is a processing failure.  Each request is processed by a handler. The handler is the code that performs functions for a specific request type. Handlers are executed by a finite number worker threads on each of the application servers that make up an instance. The threads request work from the queuing framework and when received, start a specific handler to do the work.

Asynchronous processing has lower priority than real-time interaction via the browser and API.

### Batch Apex
You can then invoke a batch class using the Database.executeBatch method.
* Mostly used for data cleansing or archiving
* The execution logic of the batch class is called once for each batch of records you are processing.
* Each time you invoke a batch class, the job is placed on the Apex job queue and is executed as a discrete transaction.   This functionality has two advantages:
  * Every transaction starts with a new set of governor limits, making it easier to ensure that your code stays within the governor execution limits.
  * If one batch fails to process successfully, all other successful batch transactions aren’t rolled back.
  * To write a Batch Apex class, your class must implement the Database.Batchable interface and include the following three methods:
    * `start` - Used to collect the records or objects to be passed to the interface method `execute` for processing. This method is called once at the beginning of a Batch Apex job and returns either a Database.QueryLocator object or an Iterable that contains the records or objects passed to the job.  With the QueryLocator object, the governor limit for the total number of records retrieved by SOQL queries is bypassed and you can query up to 50 million records.  If you loop through the results of an API call or pre-process records before being passed to the `execute` method, the governor limit for the total number of records retrueved by SOQL is still enforced.
    * `execute` - performs the processing for each batch of data passed to the method.  The default batch size is 200 records.  Batches of records are not guaranteed to execute in the order they are received from the start method.
    * `execute` method takes the following:
      * A reference to the `Database.BatchableContext` object
      * A list of sObject, such as `List<Object>`, or a list of parameterized types.  If you are using `Database.QueryLocator`, use the returned list.
    * `finish` - Used to execute post-processing operations (for example, sending an email) and is called once after all batches are processed.

#### Skeleton of a Batch Apex class
```apex
global class MyBatchClass implements Database.Batchable<sObject> {
    global (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }
    global void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}
```
#### Invoking Batch Apex
* To invoke batch class:
  1. Instantiate it: `MyBatchClass myBatchObject = new MyBatchClass();`
  2. Call `Database.executBatch` with the instance: `Id batchId = Database.executeBatch(myBatchObject);`
  3. Optionally, pass a second `scope` parameter to specify the number of records that should be passed into the execute method for each batch: `Id batchId = Database.executeBatch(myBatchObject, 100);`

Each batch Apex invocation creates an AsyncApexJob record to track the job's progress.  View the progress via SOQL or manage the job in the Apex Job Queue:
`AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId];`

### Using State in Batch Apex
* Batch Apex is typically stateless.
* Each execution of a batch Apex job is considered a discrete transaction.
* If you specify `Database.Stateful` in the class definition, you can maintain state across all transactions.
* When using `Database.Stateful`, only instance member variables retain their values between transactions.
* Maintaining state is useful for counting or summarizing records as they’re processed.
* Only use Batch Apex if you have more than one batch of records. If you don't have enough records to run more than one batch, you are probably better off using Queueable Apex.
* Tune any SOQL query to gather the records to execute as quickly as possible.
* Minimize the number of asynchronous requests created to minimize the chance of delays.
* Use extreme care if you are planning to invoke a batch job from a trigger. You must be able to guarantee that the trigger won’t add more batch jobs than the limit.

### Future Methods
In situations where you need to make a callout to a web service or want to offload simple processing to an asynchronous task, creating a future method could be the way to go.

* You cannot pass objects as arguments in future methods.
* Future methods must be static methods
* Future methods can only return void type
* The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types.
* Future methods can’t take standard or custom objects as arguments.
* A common pattern is to pass the method a List of record IDs that you want to process asynchronously.
* The reason why objects can’t be passed as arguments to future methods is because the object can change between the time you call the method and the time that it actually executes.
* Future methods are not guaranteed to execute in the same order as they are called
* When using future methods, it’s also possible that two future methods could run concurrently, which could result in record locking and a runtime error if the two methods were updating the same record.
* Since every future method invocation adds one request to the asynchronous queue, avoid design patterns that add large numbers of future requests over a short period of time.
* Ensure that future methods execute as fast as possible.
* If using Web service callouts, try to bundle all callouts together from the same future method, rather than using a separate future method for each callout.
* Conduct thorough testing at scale. Test that a trigger enqueuing the @future calls is able to handle a trigger collection of 200 records. This helps determine if delays may occur given the design at current and future volumes.
* Consider using Batch Apex instead of future methods to process large number of records asynchronously. This is more efficient than creating a future request for each record.
* Future methods can’t be used in Visualforce controllers in `getMethodName()`, `setMethodName()`, nor in the constructor.
* You can’t call a future method from a future method. Nor can you invoke a trigger that calls a future method while running a future method.
* `getContent()` and `getContentAsPDF()` methods can’t be used in methods with the future annotation.
* You’re limited to 50 future calls per Apex invocation, and there’s an additional limit on the number of calls in a 24-hour period.
* Callouts are not permitted from triggers
* Callouts are permitted from controllers
* To test future methods, enclose your test code between the startTest and stopTest test methods.
  * The system collects all asynchronous calls made after the startTest.
  * When stopTest is executed, all these collected asynchronous processes are then run synchronously.
  * You can then assert that the asynchronous call operated properly.

```apex
global class SomeClass {
  @future
  public static void someFutureMethod(List<Id> recordId) {
    List<Account> accounts = [SELECT Id, Name from Account WHERE Id IN :recordIds] {
      // process something
    }
  }
}
```

Future methods are typically used for:
* Callouts to external Web services. If you are making callouts from a trigger or after performing a DML operation, you must use a future or queueable method. A callout in a trigger would hold the database connection open for the lifetime of the callout.
* Operations you want to run in their own thread, when time permits such as some sort of resource-intensive calculation or processing of records.
* Isolating DML operations on different sObject types to prevent the mixed DML error.

## @future Annotation
* Use the `future` annotation to identify methods that are executed asynchronously. When you specify future, the method executes when Salesforce has available resources.

For example, you can use the `future` annotation when making an asynchronous Web service callout to an external service. Without the annotation, the Web service callout is made from the same thread that is executing the Apex code, and no additional processing can occur until the callout is complete (synchronous processing).

Methods with the `future` annotation must be static methods, and can only return a void type.

The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects or objects as arguments.

best practice to use only one trigger per object, which you see in the following example. You can then use context-specific handler methods within triggers to create logic-less triggers.

Apex triggers can receive up to 200 objects at once.
the synchronous limit for the total number of SOQL queries is 100, and 150 for the total number of DML statements issued

design your Apex code to handle bulk operations from the very start

https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_bulk

https://trailhead.salesforce.com/content/learn/modules/apex_triggers/apex_triggers_bulk

DO NOT have the insert DML operation is inside the for loop

Apex uses a familiar try-catch-finally block to handle exceptions. But your catch statement and possible rollback could differ depending on where the Apex code is executed.

 If you need data to persist between classes, you do have static variables

### Future Limitations
Here are some limitations:
* You can’t track execution because no Apex job ID is returned.
* Parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Future methods can’t take objects as arguments.
* You can’t chain future methods and have one call another.
* Although asynchronous calls are sometimes done to avoid limits, you still need to consider limits

### Queueable Apex
Queueable Apex provides the following benefits to future methods:
* Non-primitive types - Classes can accept parameter variables of non-primitive data types, such as sObjects or custom Apex types.
* Monitoring - When you submit your job, a jobId is returned that you can use to identify the job and monitor its progress.
* Chaining jobs - You can chain one job to another job by starting a second job from a running job. Chaining jobs is useful for sequential processing.

### Apex Flex Queue
Eliminate the limitation of five concurrent batches.

### Classes
All objects have state and behavior.
* state - things that an object knows about itself
* behavior- things that an object ca do.

A class can contain variables and methods.  Variables are used to specify state of an object, such as the object Name and Type.
Since these variables are associated with a class and are members of it, they are commonly refered to as member variables.

Methods are used to control behavior, such as `getOtherQuotes` or `copyLineItems`

A class can contain other classes, exception types and initialization code.

An `interface` is like a class in which none of the methods have been implemented.

### To define a class
1. You must use one of the access modifiers (such as public) in definition of the top-level class
2. You do not have to use access modifier for the declaration of the inner level class
3. Required: the keyword class followed by the name of the class
4. The private access modifier declares that this class is only known locally, that is, only by this section of code. This is the default access for inner classes—that is, if you don't specify an access modifier for an inner class, it is considered private. This keyword can only be used with inner classes (or with top level test classes marked with the @isTest annotation).
5. The public access modifier declares that this class is visible in your application or namespace.
6. The global access modifier declares that this class is known by all Apex code everywhere. All classes that contain methods defined with the webservice keyword must be declared as global. If a method or inner class is declared as global, the outer, top-level class must also be defined as global.
7. The virtual definition modifier declares that this class allows extension and overrides. You cannot override a method with the override keyword unless the class has been defined as virtual.
8. The abstract definition modifier declares that this class contains abstract methods, that is, methods that only have their signature declared and no body defined.
9. A class can implement multiple interfaces, but only extend one existing class. This restriction means that Apex does not support `multiple inheritance`.

### To declare a variable
1. Optional: Modifiers, such as public or final, as well as static.
2. Required: The data type of the variable, such as String or Boolean.
3. Required: The name of the variable.
4. Optional: The value of the variable.
```apex
 [public | private | protected | global] [final] [static] data_type variable_name [= value]
 ```
  ### To define a method
  1. Optional: Modifiers, such as public or protected.
  2. Required: The data type of the value returned by the method, such as String or Integer. Use void if the method does not return a value.
  3. Required: A list of input parameters for the method, separated by commas, each preceded by its data type, and enclosed in parentheses (). If there are no parameters, use a set of empty parentheses. A method can only have 32 input parameters.
  4. Required: The body of the method, enclosed in braces {}. All the code for the method, including any local variable declarations, is contained here.
  ```apex
  [public | private | protected | global] [override] [static] data_type method_name (input parameters)
{
// The body of the method
}
```
5. You can use override to override methods only in classes that have been defined as virtual or abstract.
6. methods that return values can also be run as a statement if their results are not assigned to another variable.
7. Can be recursive.
8. Can have side effects, such as DML insert statements that initialize sObject record IDs.
9. Can refer to themselves or to methods defined later in the same class or anonymous block. Apex parses methods in two phases, so forward declarations are not needed.
10. Can be polymorphic. For example, a method named example can be implemented in two ways, one with a single Integer parameter and one with two Integer parameters. Depending on whether the method is called with one or two Integers, the Apex parser selects the appropriate implementation to execute. If the parser cannot find an exact match, it then seeks an approximate match using type coercion rules.
11. If the parser finds multiple approximate matches, a parse-time exception is generated.
12. Methods with a void return type are typically invoked as a stand-alone statement in Apex code.

### Passing Method Arguments by Value
* all primitive data type arguments, such as Integer or String, are passed into methods by value. This fact means that any changes to the arguments exist only within the scope of the method. When the method returns, the changes to the arguments are lost.
* Non-primitive data type arguments, such as sObjects, are passed into methods by reference. Therefore, when the method returns, the passed-in argument still references the same object as before the method call. Within the method, the reference can't be changed to point to another object but the values of the object's fields can be changed.

### Passing non-primitive data-type argument
This example shows how a List agument is passed by reference into the `reference()` method and is modified.
It then shows, in the `referenceNew()` method, that the List argument can't be changed to point to another List object.

1.  The `createTemperatureHistory` method creates a variable `fillMe` that is a List of integers and passes it to a method.
2. The called method fills this list with integer values representing roundded temperature values.
3. When the method returns, assert statement verifies that the contents of the original `List` variable has changed and now contains five values.
4. Next, the example creates a second List variable, `createMe`, and passes it to another method.
5. The called method assigns the passed-in argument to a newly created List that contains new Integer values.
6.  When the method returns, the original createMe variable doesn’t point to the new List but still points to the original List, which is empty.

## PD1

1. To create an additional set of governor limits during the execution of a single test class use `Test.startTest() and Test.stopTest()`.
