/*
- Initialization = is the assignment of an initial value for a data object or variable.
- The complement of initialization is finalization, which is primarily used for objects, but not variables.
- Initialization is done either by statically embedding the value at compile time, or else by assignment at run time. 
- Initialization code may be part of a constructor (class method) or an initializer (instance method). 

- Declaration  = is a language construct that specifies properties of an identifier: it declares what a word (identifier) "means"
- Declarations are most commonly used for functions, variables, constants, and classes, but can also be used for other entities such as enumerations and type definitions.
- Declaration is used to announce the existence of the entity to the compiler

- Constructor is a special type of subroutine called to create an object.
- It prepares the new object for use, often accepting arguments that the constructor uses to set required member variables.
- A constructor resembles an instance method, but it differs from a method in that it has no explicit return type, it is not implicitly inherited and it usually has different rules for scope modifiers. 
- Constructors often have the same name as the declaring class.
- They have the task of initializing the object's data members and of establishing the invariant of the class, failing if the invariant is invalid. 
- A properly written constructor leaves the resulting object in a valid state. 
- Immutable objects must be initialized in a constructor.
*/


public class MyClass { // Class and its methods are implicitly final by default (no overridable)
  public final Integer FINAL_VAR1;
  public final Integer FINAL_VAR2; // A final class variable can be assogned only at declaration or in a constructor
  public final static Integer STATIC_FINAL_VAR3;
  public final static Integer STATIC_FINAL_VAR4 = 4; // Static final var can be assigned at declaration or in static initialization
  
  Static {
    STATIC_FINAL_VAR3 = 3; // Static final var can be assigned at declaration or in static initialization
  }
  
  Public MyClass() {
    FINAL_VAR1 = 1; // A final class variable can be assogned only at declaration or in a constructor
  }
}
