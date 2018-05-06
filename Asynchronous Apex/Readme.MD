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

### Single vs multiprocessor systems
* Systems with a single processor generally implement multithreading by time slicing: the central processing unit (CPU) switches between different software threads. This context switching generally happens very often and rapidly enough that users perceive the threads or tasks as running in parallel. 
* On a multiprocessor or multi-core system, multiple threads can execute in parallel, with every processor or core executing a separate thread simultaneously; on a processor or core with hardware threads, separate software threads can also be executed concurrently by separate hardware threads.
