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
