/**
* The Apex class must be called 'AnimalLocator', have a 'getAnimalNameById' method that accepts an Integer and returns a String.
The 'getAnimalNameById' method must call https://th-apex-http-callout.herokuapp.com/animals/:id, using the ID passed into the method. The method returns the value of the 'name' property (i.e., the animal name).
Create a test class named AnimalLocatorTest that uses a mock class called AnimalLocatorMock to mock the callout response.
The unit tests must cover all lines of code included in the AnimalLocator class, resulting in 100% code coverage.
Run your test class at least once (via 'Run All' tests the Developer Console) before attempting to verify this challenge.
*/

public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer Id) {
        
    }
}