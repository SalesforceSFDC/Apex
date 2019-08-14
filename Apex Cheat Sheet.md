## For Loops
```apex
for(Integer i=0; i<5; i++) {}
```

#
* `Constants` - variables whose values don't change after being initialized once.  It can be defined using `final` keyword.
* `final` - means that the variable can be assigned at most once, either in the declaration itself, or with a static method in in class.
* `class` - a template from which objects are created.
* `object` - instance of a class, instaniate the object.  All objects have a state and behavior.  Things that an object knows about itself and that it can do.
  * A `class` can contain `variables` and `methods`.  
  * `Variables` are used to specify the state and `methods` are used to control behavior.
* `Interface` is like a class in which none of the methods have been implemented - the method signatures are there, but the body of each method is empty.  To use an interface, another class must implement it by providing a body for all of the methods contained in the interface.
* `void` - method does not return a value.
## Static Methods
[Static and Instance Methods, Variables, and Initialization Code](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_static.htm?search_text=static)
* Apex classes cannot be static.  
* Static methods, member variables and initialization code have these characteristics:
  * They are associated with a class
  * They are allowed only in outer classes
  * They are initialized only when a class is loaded.
  * They are not transmitted as part of the view state for a Visualforce page.
  * Inner classes have no static methods or variables.
  * Before an object of a class is created, all static member variables in a class are initialized, and all static initialization code blocks are executed.
  * A static method is used as a utility method, and it never depends on the value of an instance member variable. 
  * Because a static method is only associated with a class, it can’t access the instance member variable values of its class.
  * A static variable is static only within the scope of the Apex transaction. It’s not static across the server or the entire organization. 
  * The value of a static variable persists within the context of a single transaction and is reset across transaction boundaries. 
  * To store information that is shared across instances of a class, use a static variable.
  * All instances of the same class share a single copy of the static variable. 
  * Local variable names are evaluated before class names.

## Instance Methods and Variables
* Instance methods and member variables are used by an instance of a class, that is, by an object. 
* An instance member variable is declared inside a class, but not within a method. 
* Instance methods usually use instance member variables to affect the behavior of the method.
## Important Reserved Keywords
| Keyword | Description | Example |
|------|-----|---|
|abstract| Declares a class that contains abstract methods that only have their signature and no body defined.  Can also define method. | `public abstract class Foo { protected void method1() { /*... */ } abstract Integer abstractMethod();}` |
| break | Exits the entire loop | `while(reader.hasNExt()) {if (reader.getEventType() == END) {break;};reader.next();}` |

### catch
Identifies a block of code that can handle a particular type of exception.
```apex
try {
  // code
} catch (ListException e) {
  //List exception handling code
}
```
### class
Defines a class.
```apex 
private class Foo {
  private Integer x;
  public Integer getX() { return x; }
}
```
