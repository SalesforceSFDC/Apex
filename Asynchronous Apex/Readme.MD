# Aysnchronous Apex

## Future Apex
* Future Apex is used to run processes in a separate thread, at a later time when system resources become available.
* When using synchronous processing, all method calls are made from the same thread that is executing the Apex code, and no additional processing can occur until the process is complete. 
* <b>thread</b> of execution is the smallest sequence of programmed instructions that can be managed independently by a scheduler, which is typically a part of the operating system.
* <b>thread</b> is a component of a process
* <b>thread</b> of a process share its executable code and the values of its variables at any given time.

* Future methods are typically used for:
  * Callouts to external Web services. If you are making callouts from a trigger or after performing a DML operation, you must use a future or queueable method. A callout in a trigger would hold the database connection open for the lifetime of the callout and that is a "no-no" in a multitenant environment.
  * Operations you want to run in their own thread, when time permits such as some sort of resource-intensive calculation or processing of records.
  * Isolating DML operations on different sObject types to prevent the mixed DML error. This is somewhat of an edge-case but you may occasionally run across this issue. See sObjects That Cannot Be Used Together in DML Operations for more details.
  
* Future methods must be static methods, and can only return a void type. 
*  The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types.
* future methods can’t take standard or custom objects as arguments.
* A common pattern is to pass the method a List of record IDs that you want to process asynchronously.
* The reason why objects can’t be passed as arguments to future methods is because the object can change between the time you call the method and the time that it actually executes. 
* Future methods are executed when system resources become available.
* future methods are not guaranteed to execute in the same order as they are called



### Single vs multiprocessor systems
* Systems with a single processor generally implement multithreading by time slicing: the central processing unit (CPU) switches between different software threads. This context switching generally happens very often and rapidly enough that users perceive the threads or tasks as running in parallel. 
* On a multiprocessor or multi-core system, multiple threads can execute in parallel, with every processor or core executing a separate thread simultaneously; on a processor or core with hardware threads, separate software threads can also be executed concurrently by separate hardware threads.
* <b>single-threading</b> is the processing of one command at a time. The opposite of single-threading is multithreading. 
* <b>Multithreading</b> is a programming and execution model that allows multiple threads to exist within the context of one process. These threads share the process's resources, but are able to execute independently. The threaded programming model provides developers with a useful abstraction of concurrent execution. Multithreading can also be applied to one process to enable parallel execution on a multiprocessing system.

### Testing Future Methods
* To test future methods, enclose your test code between the `startTest` and `stopTest` test methods. The system collects all asynchronous calls made after the `startTest`. When `stopTest` is executed, all these collected asynchronous processes are then run synchronously.

### Best Practices
Since every future method invocation adds one request to the asynchronous queue, avoid design patterns that add large numbers of future requests over a short period of time. If your design has the potential to add 2000 or more requests at a time, requests could get delayed due to flow control. Here are some best practices you want to keep in mind:
* Ensure that future methods execute as fast as possible.
* If using Web service callouts, try to bundle all callouts together from the same future method, rather than using a separate future method for each callout.
* Conduct thorough testing at scale. Test that a trigger enqueuing the @future calls is able to handle a trigger collection of 200 records. This helps determine if delays may occur given the design at current and future volumes.
* Consider using Batch Apex instead of future methods to process large number of records asynchronously. This is more efficient than creating a future request for each record.
* Methods with the future annotation must be static methods, and can only return a `void` type.
* The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types; future methods can’t take objects as arguments.
* Future methods won’t necessarily execute in the same order they are called. In addition, it’s possible that two future methods could run concurrently, which could result in record locking if the two methods were updating the same record.
* Future methods can’t be used in Visualforce controllers in `getMethodName()`, `setMethodName()`, nor in the constructor.
* You can’t call a future method from a future method. Nor can you invoke a trigger that calls a future method while running a future method.
* The `getContent()` and `getContentAsPDF()` methods can’t be used in methods with the future annotation.
* You’re limited to 50 future calls per Apex invocation, and there’s an additional limit on the number of calls in a 24-hour period.
