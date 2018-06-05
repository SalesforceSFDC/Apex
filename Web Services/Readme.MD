# Web Services

## Expose a Class as a REST Service
1. Define class as `global`
2. Define methods as `static`
3. Add annotations to the class and methods.
4. The URL mapping is case-sensitive and can contain a wildcard character (*).
5. Define each exposed method as global static and add an annotation to associate it with an HTTP method.
6. You can use each annotation only once in each Apex class.
7. Version your API endpoints so that you can provide upgrades in functionality without breaking existing code.

* `RestRequest` - Formats REST API requests from the data your app provides.  Also serves as a factory for instance itself.  Do not directly create instance of `RestRequest`.  Instead, call an appropriate `RestRequest` static getter function such as 
`RestRequest.getRestForCreate()`.  
* `RestResponse` - Formats the response content in the requested format, returns the formatted response to your app,
and closes the content stream.  The `RestRequest` class creates instances of `RestResponse` and returns them to your app through your implementation of the `RestClient.AsyncRequestCallback` interface.  
* The `RestRequest` class natively handles the standard Salesforce data operations offered by the Salesforce REST and SOAP APIs.

