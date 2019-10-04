/*
ApexTransactionExample.insertLeadAccount('Axis', 'Axis2', 'Axis3');
*/

public class ApexTransactionExample {
    public static void insertLeadandAccount (String accName, String LeadName, String CompanyName) {
        Account a = new Account(Name = accName);
        insert a;
        Lead l1 = new Lead(LastName = LeadName, Company = CompanyName);
        insert l1;
        Lead l2 = new Lead(LastName = LeadName, Company = 'MyTutorial');
        insert l2;
    }
}