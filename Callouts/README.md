# Apex Calls to External Web Services (Callouts)

 * [Invoking Callouts using Apex](https://developer.salesforce.com/docs/atlas.en-us.206.0.apexcode.meta/apexcode/apex_callouts.htm)
 
 

To make a from a trigger, call a class method that executes `asynchronously`.  
This method is called a future method and is annotated with `@future(callout=true)`.

## Named Credentials
* A named credential specifies the URL of a callout endpoint and its required authentication parameters in one definition. Salesforce manages all authentication for Apex callouts that specify a named credential as the callout endpoint so that your code doesn’t have to. You can also skip remote site settings, which are otherwise required for callouts to external sites, for the site defined in the named credential.
  
