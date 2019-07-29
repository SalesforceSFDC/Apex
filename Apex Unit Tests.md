## Unit Tests   

The following are the benefits of Apex unit tests:
* Ensuring that your Apex classes and triggers work as expected
* Having a suite of regression tests that can be rerun every time classes and triggers are updated to ensure that future updates you make to your app don’t break existing functionality
* Meeting the code coverage requirements for deploying Apex to production or distributing Apex to customers via packages
* High-quality apps delivered to the production org, which makes production users more productive
* High-quality apps delivered to package subscribers, which increase your customers trust

# Writing Tests
Testing is the key to successful long-term development and is a critical component of the development process. We strongly recommend that you use a test-driven development process, that is, test development that occurs at the same time as code development.
To facilitate the development of robust, error-free code, Apex supports the creation and execution of unit tests. Unit tests are class methods that verify whether a particular piece of code is working properly. Unit test methods take no arguments, commit no data to the database, send no emails, and are flagged with the testMethod keyword or the @isTest annotation in the method definition. Also, test methods must be defined in test classes, that is, classes annotated with @isTest.
Note: The testMethod keyword is now deprecated. Use the @isTest annotation on classes and methods instead.
In addition, before you deploy Apex or package it for the AppExchange, the following must be true.
• Unit tests must cover at least 75% of your Apex code, and all of those tests must complete successfully.
Note the following.
– When deploying Apex to a production organization, each unit test in your organization namespace is executed by default.
– Calls to System.debug are not counted as part of Apex code coverage.
– Test methods and test classes are not counted as part of Apex code coverage.
– While only 75% of your Apex code must be covered by tests, don’t focus on the percentage of code that is covered. Instead, make sure that every use case of your application is covered, including positive and negative cases, as well as bulk and single records. This approach ensures that 75% or more of your code is covered by unit tests.
• Every trigger must have some test coverage.
• All classes and triggers must compile successfully.

## Exceptions
### Create Custom Exceptions
* You cant throw built-in Apex exception.  You can only catch them.
* With custom exceptoins, you can throw and catch them in methods.
* Custom exceptions enable you to specify detailed error messages and have more custom error handling in catch blocks.
* Top level classes have member variables, methods and constructors, they can implement interfaces.
* Custom exceptions can be top level classes.
### To Create Custom Exception
To create custom exception class, extend the built-in `Exception` class and make sure class name ends with the word `Exception`, such as `MyException` or `PurchaseException`.  
* User-defined exception types can form an inheritance tree, and catch blocks can catch any object in this inheritance tree.
```apex
public class ExceptionExample {
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

    public static void testExtendedException() {
        try {
            Integer i=0;
            if (i < 5) throw new OtherException('This is bad');
        } catch (BaseException e) {
            // This catches the OtherException
            System.debug(e.getMessage());
        }
    }
}
```
#### 
* static method cannot be referenced from a non static context
* class should contain member variables (attributes) and accessor methods to access those attributes


## Cleaning Apex Code
* [Apex Code Analysis Tool using Tooling API and Canvas](https://github.com/afawcett/apex-codeanalysis)
* [Andy Fawcett - Spring Cleaning Apex Code](https://andyinthecloud.com/2013/02/02/spring-cleaning-apex-code-with-the-tooling-api/)
## Symbol Table
Symbol Table breaks down the code you write and gives you a kind of analytics over your code. Listing all the properties  methods defined and also references elsewhere being made. 
## Cyclomatic Complexity
Cyclomatic complexity is a software metric used to indicate the complexity of a program. It is a quantitative measure of the number of linearly independent paths through a program's source code.
