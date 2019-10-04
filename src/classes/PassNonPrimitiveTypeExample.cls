// List argument is passed by reference into the reference() method and is modified
// in the referenceNew() method, that the List argument can’t be changed to point to another List object.
public class PassNonPrimitiveTypeExample {
    // createTemperatureHistory method creates a variable, fillMe, that is a List of Integers and passes it to a method.
    public static void createTemperatureHistory() {
        List<Integer> fillMe = new List<Integer>();
        // The called method fills this list with Integer values representing rounded temperature values. 
        reference(fillMe);
        // The list is modified and contains five items
        // as expected.
        // When the method returns, an assert statement verifies that the contents of the original
        // List variable has changed and now contains five values.
        System.assertEquals(fillMe.size(), 5);

        List<Integer> createMe = new List<Integer>();
        // The called method assigns the passed-in argument to a newly created List that contains new Integer values.
        referenceNew(createMe);
        // When the method returns, the original createMe variable doesn’t
        // point to the new List but still points to the original List, which is empty.
        // The list is not modified because it still points
        // to the original list, not the new list
        // that the method created.
        // An assert statement verifies that createMe contains no values.
        System.assertEquals(createMe.size(), 0)
    }
    
    // The called method fills this list with Integer values representing rounded temperature values. 
    public static void reference(List<Integer> m) {
        // Add rounded temperatures for the last five days.
        m.add(70);
        m.add(68);
        m.add(75);
        m.add(80);
        m.add(82);
    }

    public static void referenceNew(List<Integer> m) {
        // Assign argument to a new List of
        // five temperature values.
        m = new List<Integer>{5, 59, 62, 60, 63};
    }
}
