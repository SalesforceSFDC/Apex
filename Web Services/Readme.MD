# Web Services

## Expose a Class as a REST Service
1. Define class as `global`
2. Define methods as `static`
3. Add annotations to the class and methods.
4. The URL mapping is case-sensitive and can contain a wildcard character (*).
5. Define each exposed method as global static and add an annotation to associate it with an HTTP method.
6. You can use each annotation only once in each Apex class.
7. Version your API endpoints so that you can provide upgrades in functionality without breaking existing code.
8. Methods annotated with @HttpGet or @HttpDelete should have no parameters.  This is because GET and DELETE requests have no request body, so there's nothing to deserialize.
9. Invoking a custom Apex REST Web service method always uses system context. 

* `RestRequest` - Formats REST API requests from the data your app provides.  Also serves as a factory for instance itself.  Do not directly create instance of `RestRequest`.  Instead, call an appropriate `RestRequest` static getter function such as 
`RestRequest.getRestForCreate()`.  
* `RestResponse` - Formats the response content in the requested format, returns the formatted response to your app,
and closes the content stream.  The `RestRequest` class creates instances of `RestResponse` and returns them to your app through your implementation of the `RestClient.AsyncRequestCallback` interface.  
* The `RestRequest` class natively handles the standard Salesforce data operations offered by the Salesforce REST and SOAP APIs.

| Operation | Parameters | Description |
| --- | --- | --- |
| 

## Supported Data Types for Apex REST
Apex REST supports these data types for parameters and return values.
  * Apex primitives (excluding sObject and Blob).
  * sObjects
  * Lists or maps of Apex primitives or sObjects (only maps with String keys are supported).
  * User-defined types that contain member variables of the types listed above.


## Apex JSON

* [Getting Started with Apex JSON](https://developer.salesforce.com/index.php?title=Getting_Started_with_Apex_JSON)
* [JSON Support - Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_json_overview.htm)
