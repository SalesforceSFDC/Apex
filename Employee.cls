/*
Employee e1 = new Employee();
Emplpyee e2 = new Emplpyee();
e1.name = 'John';
e1.designation = 'Senior Manager';

e2.name = 'Steve';
e2.designation = 'manager';

e1.show();
e2.show();
*/

public class Employee {
    public String name;
    public String designation;
    
    public void show() {
        System.debug('Name of the employee :'+name);

    }
}