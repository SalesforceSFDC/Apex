- The map methods are all instance methods.  They operate on a particular instance of a map.

- Top-level classes = outer classes
- Inner classes can be one level deep

public class myOuterClass {
  // Additional myOuterClass code
  class myInnerClass {
    // myInnerClass code
  }
}

To define a class:
1. Access modifiers:
    * You must use one of the access modifiers in the declaraiton of a top-level class.
    * You do not have to use an access modifier in the declaration of an inner class.
2. Optional definition modifiers (such as virtual, abstract,...)
3. Required: The keyword class followed by name of the class.
4. Optional extensions and/or implementations.

private | public | global
[virtual | abstract | with sharing | without sharing]
class Classname [implements InterfaceNameList] [extends ClassName]
{
  // the body of the class
}

- The private access modifier declares that this class is only known locally, that is, only by this section of the code. This is the default access for an inner class.
- The public access modifier declares that this class is visible in your app or namespace.
- The global access modifier declares that this class is known by all Apex code everywhere.  All classes that contain methods defined with the webService keyword must be declared as global.  If a method or inner class is declared global, the outer, top-level class must also be defined as global.
- The with sharing and without sharing keuwords specify the sharing mode for this class.
- The virtual definition modifier declares that this class allows extension and overrides.
- The abstract defintiion modifier declares that this class contains abstract methods, that is, methods that only have their signature declared and no body defined.

- Apex does not support multiple inheritance.
- Apex code runs in system context.  In system context, Apex code has access to all objects and fields - object permissions, field-level security, sharing rules arent applied for the current user.  This is to ensure that code wont fail to run because of hidden fields or objects for a user.  The only exceptions to this rule are Apex code that is executed with the executeAnonymous call and Chatter in Apex.  executeAnonymous always executes using the full permissions of the current user.

----------
// Use the `with Sharing` keywords when declaring a class to enforcce the sharing rules that apply to the current user.

public with sharing class sharingClass {

 // code
}
------------

// Use the without sharing keywords when declaring a class to ensure that the sharing rules for the current user are not enforced.

public without sharing class noSharing {

  // code
}

Some things to note about sharing keywords:
The sharing setting of the class where the method is defined is applied, not of the class where the method is called. For example, if a method is defined in a class declared with with sharing is called by a class declared with without sharing, the method will execute with sharing rules enforced.
If a class isn’t declared as either with or without sharing, the current sharing rules remain in effect. This means that the class doesn’t enforce sharing rules except if it acquires sharing rules from another class. For example, if the class is called by another class that has sharing enforced, then sharing is enforced for the called class.
Both inner classes and outer classes can be declared as with sharing. The sharing setting applies to all code contained in the class, including initialization code, constructors, and methods.
Inner classes do not inherit the sharing setting from their container class.
Classes inherit this setting from a parent class when one class extends or implements another.


The `with sharing` keyword allows you to specify that the sharing rules for the current user be taken into account for a class.
