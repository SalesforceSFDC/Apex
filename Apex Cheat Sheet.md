* `Constants` - variables whose values don't change after being initialized once.  It can be defined using `final` keyword.
* `final` - means that the variable can be assigned at most once, either in the declaration itself, or with a static method in in class.
* `class` - a template from which objects are created.
* `object` - instance of a class, instaniate the object.  All objects have a state and behavior.  Things that an object knows about itself and that it can do.
  * A `class` can contain `variables` and `methods`.  
  * `Variables` are used to specify the state and `methods` are used to control behavior.
* `Interface` is like a class in which none of the methods have been implemented - the method signatures are there, but the body of each method is empty.  To use an interface, another class must implement it by providing a body for all of the methods contained in the interface.
* `void` - method does not return a value.
## Static Methods
* Apex classes cannot be static.  
* Static methods, member variables and initialization code have these characteristics:
  * They are associated with a class
  * They are allowed only in outer classes
  * They are initialized only when a class is loaded.
  * They are not transmitted as part of the view state for a Visualforce page.

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
