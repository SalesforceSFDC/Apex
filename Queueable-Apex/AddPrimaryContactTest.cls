@isTest
public class AddPrimaryContactTest {
@testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add 50 NY account
        for (Integer i = 0; i < 50; i++) {
        accounts.add(new Account(Name='NY'+i, billingstate='NY'));
        }
         // add 50 CA account
        for (Integer j = 0; j < 50; j++) {
        accounts.add(new Account(Name='CA'+j, billingstate='CA'));
           }
        insert accounts;
      }
       static testmethod void testQueueable(){
        contact a=new contact(Lastname='mary', Firstname='rose'); 
        Test.startTest();        
        AddPrimaryContact updater=new AddPrimaryContact(a, 'CA');
        System.enqueueJob(updater);
        Test.stopTest(); 
      
        System.assertEquals(50, [SELECT count() FROM Contact WHERE Lastname='mary' AND Firstname='rose']) ;                      
    }   
}