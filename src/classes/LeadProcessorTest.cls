@isTest 
public class LeadProcessorTest {
    static testMethod void testMethod1() {
        List<Lead> lstLead = new List<Lead>();
        for(Integer i=0 ;i <200;i++) {
            Lead led = new Lead();
            led.FirstName ='FirstName';
            led.LastName ='LastName'+i;
            led.Company ='demo'+i;
            lstLead.add(led);
        }
        insert lstLead;
        
        Test.startTest();
            LeadProcessor obj = new LeadProcessor();
            DataBase.executeBatch(obj); 
        Test.stopTest();
    }
}