## How to Expose a Class as a REST Service
* Define the class as `global`
* Define the methods as `global static`
* Add annotations to the class and methods.

```Apex
@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
  @HttpGet
  global static Account getRecord() {
    // Add your code
  }  
}
```
https://na22.salesforce.com/services/apexrest/Account/*
