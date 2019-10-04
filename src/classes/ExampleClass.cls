// Top-level (outer) class must be public or global (usually public unless they contain
// a Web Service, then they must be global)
public class ExampleClass {
    // static final variable (constant) - outer class level only
    private static final Integer MY_INT;

    // Non-final static variable - use this to communicate state across triggers
    // within a single request
    public static String sharedState;

    // Static method - outer class level-only
    public static Integer getInt() { return MY_INT; }

    // Static initialization (can be included where the variable is defined)
    static {
        MY_INT = 2;
    }

    // member variable for outer class
    private final String m;

    // Instance initialization block - can be done where the variable is declared,
    // or in a constructor
    {
        m = 'a';
    }

    // Because no constructor is explicitly defined in this outer class, an implicit,
    // no-argument, public constructor exists

    // Inner interface
    public virtual interface MyInterface {
        // No access modifier is necessary for interface methods - these are always
        // public or global depending on the interface visibility
        void myMethod();
    }

    // Interface extension
    interface MySecondInterface extends MyInterface {
        Integer method2(Integer i);
    }

    // Inner class - because it is virtual it can be extended.
    // This class implements an interface that, in turn, extends another interface.
    // Consequently the class must implement all methods.
    public virtual class InnerClass implements MySecondInterface {

        // Inner member variables
        private final String s;
        private final String s2;


         // Inner instance initialization block (this code could be located above)
        {
            this.s = 'x';
        }

         // Inline initialization (happens after the block above executes)
         
    }
}
