## Using Relationship Queries
* Query child-to-parent relationships:
```apex
SELECT Id, Name, Account.Name
FROM Contact
WHERE Account.Industry = 'media'
```
This query returns the ID and name for only the contacts whose related account industry is media, and for each contact returned, the account name.

* Query parent-to-child:
```apex
SELECT Name,
  (
    SELECT LastName
    FROM Contacts
  )
FROM Account
```
Specify these relationships using a subquery (enclosed in parentheses), where the initial member of the FROM clause in the subquery is related to the initial member of the outer query FROM clause. Note that for standard object subqueries, you should specify the plural name of the object as that is the name of the relationship for each object.

### Write a Child-to-Parent Query
This relationship query uses "dot notation" to access data from the parent, that is, a period separates the relationship name from the name of the field being queried.
```sql
SELECT FirstName, LastName, Account.Name FROM Contact
```
* you can traverse five levels up with the dot notation.

### Writing Parent-to-Children Queries
```sql
SELECT Name, (Select FirstName, LastName FROM Contacts) FROM Account
```
* When working with relationship queries, the parent-to-child relationship name must be a plural name.
* When working with custom objects, the relationship name is not only plural, but it is appended with two underscores and an r. For example, the relationship name for the custom object `My_Object__c` is `My_Objects__r`.


### Aggregates
To get a record count:
```sql
SELECT COUNT(*) FROM Account
```

Returns the number of rows where the fieldName has a non-null value:
```sql
SELECT Count(fieldName) FROM Account
```

* In SOQL, you can only alias fields in aggregate queries that use the GROUP BY clause.

### Best Practices
#### Building Selective Queries
Anytime you use one of these indexed fields in your query’s WHERE clause, you’re increasing the chance that your query is considered selective and an index used as opposed to a full table scan. 

## For Loops
```apex
for(Integer i=0; i<5; i++) {}
```
#### Two reasons to use For-Loops instead of While and do-While Loops:
* `For` loops are used when you know how many times the loop should run.  If you want the loop to stop based on a condition other than the number of times it runs you should use the `while` loop.
* `For` loops are more concise because they keep the three parts - the variable, the condition, and the increment - together in one statement.

### List or Set Iteration For Loops
*  The iteration for loop, works through the items in a list or set.
* Because the list or set has a specific number of items, you don’t need to increment a variable or check a condition. The loop works through all of the items in the list or set, and then the loop ends.
* When you declare an iteration for loop, the data type of the variable must match the data type of the list or set. Here’s the syntax for an iteration for loop.
```apex
for (data_type variable_name : list_name or set_name) {}
```
* Example:
```apex
List <String> tea = new List<String>{'Black Tea', 'Green Tea', 'Chai Tea'};
for(String t : tea){
    System.debug('We have ' + t);
}
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
