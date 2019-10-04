try {
    Lead d = new Lead();
    insert d;
} catch(Exception e) {
    System.debug('I am trying to catch this exception');
}
finally {
    System.debug('I am finally block');
}
System.debug('Hi how are you?')



public class Demo2 {
    public static void show() {
        String s = 'Vuk';
        System.debug('convert to lower case letter' + s.toLowerCase());
    }
}