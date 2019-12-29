public class AddPrimaryContact implements Queueable {
    
    private String st;
    private Contact primecontact;
    
    public AddPrimaryContact(Contact aContact, String aState) {
        this.st=aState;
        this.primecontact = aContact;
    }
    public void execute(QueueableContext context) {
        List<Account> accounts = [select name from account where billingstate=:st LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
           contact con=primecontact.clone(false,false,false,false);
           contacts.add(con);
        }
        insert contacts;
}
}