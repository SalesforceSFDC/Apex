/*
Dog d1 = new Dog();
d1.name = 'Scooby';
d1.age = 12;
d1.disp();

Dog d2 = new Dog();
d2.name = 'Tiger';
d2.age = 11;
d2.disp();
*/

public class Dog {
    public String name;
    public Integer age;

    public void disp() {
        System.debug('Name of my dog '+name);
        System.debug('Age of my dog '+age);
    }
}