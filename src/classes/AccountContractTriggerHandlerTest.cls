@isTest
private class AccountContractTriggerHandlerTest {

    static final Id institutionalTopAccountRTId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Institutional Top Account').getRecordTypeId();

    @testSetup static void setup() {
        
        List<Account> accountList = new List<Account>();

        accountList.add(new Account(
            RecordTypeId = institutionalTopAccountRTId,
            Name = 'Account1',
            Customer_Segment__c = 'Brokerage',
            Industry = 'Retail'
        ));
         accountList.add(new Account(
            RecordTypeId = institutionalTopAccountRTId,
            Name = 'Account2',
            Customer_Segment__c = 'Brokerage',
            Industry = 'Retail'
        ));
        insert accountList;

        List<Contract__c> contractList = new List<Contract__c>();
        contractList.add(new Contract__c(
            // 'First active Contract'
            Contract_Active__c = false,
            Primary_Account__c = accountList[0].Id,
            Contract_Status__c = 'Countersigned by Coinbase',
            Effective_Start_Date__c = Date.today(),
            Effective_End_Date__c = Date.today() + 365,
            Contract_Type__c = 'Custodial',
            Number_Free_New_Addresses_Per_Year__c = 1
        ));
         contractList.add(new Contract__c(
            // 'Second active Contract'
            Contract_Active__c = false,
            Primary_Account__c = accountList[1].Id,
            Contract_Status__c = 'Countersigned by Coinbase',
            Effective_Start_Date__c = Date.today(),
            Effective_End_Date__c = Date.today() + 330,
            Contract_Type__c = 'Custodial',
            Number_Free_New_Addresses_Per_Year__c = 2
        ));
        insert contractList;

    }

    @IsTest
    static void testCreateOfNewActiveAccountContract() {

        Account myAcc = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        List<Contract__c> contrTwo = [SELECT
                                    Id,
                                    Contract_Active__c,
                                    Primary_Account__c,
                                    Primary_Related_Account_Contracts__c,
                                    Contract_Status__c,
                                    Effective_Start_Date__c,
                                    Effective_End_Date__c
                                    FROM Contract__c
                                    ];
        List<Account_Contract_Relationship__c> acs = [SELECT
                                    Id,
                                    Account__c,
                                    Account_Contract_Relationship_Type__c,
                                    Active__c,
                                    Contract__c,
                                    Primary_Account__c,
                                    Primary_Account_Custody_Org_Id__c
                                    FROM Account_Contract_Relationship__c
                                    WHERE Active__c = true
                                    ];
        System.assertEquals(acs[0].Active__c, true, 'First related Account Contract should be Active');
        System.assertEquals(acs[1].Active__c, true, 'Second related Account Contract should be Active');

        // Try creating a new Account Contract related to the account
        try {
            Account_Contract_Relationship__c newAccCont = new Account_Contract_Relationship__c(
                // New active Account Contract
                Active__c = true,
                Account__c = myAcc.Id,
                Contract__c = contrTwo[0].Id
            );
            insert newAccCont;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertEquals(expectedExceptionThrown, true, 'An error should be thrown if the new Account Contract is active');
        }

        // Try creating a new inactive Account Contract related to the account
        try {
            Account_Contract_Relationship__c newAccCont = new Account_Contract_Relationship__c(
                // New active Account Contract
                Active__c = false,
                Account__c = myAcc.Id,
                Contract__c = contrTwo[0].Id
            );
            insert newAccCont;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertNotEquals(expectedExceptionThrown, true, 'An error should not be thrown if the new Account Contract is inactive');
        }

        // Try creating a new Account Contract related to the account
        try {
            Account_Contract_Relationship__c newAccCont = new Account_Contract_Relationship__c(
                // New active Account Contract
                Active__c = true,
                Account__c = myAcc.Id,
                Contract__c = contrTwo[1].Id
            );
            insert newAccCont;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertEquals(expectedExceptionThrown, true, 'An error should be thrown if the new Account Contract is active');
        }

        // Try creating a new inactive Account Contract related to the account
        try {
            Account_Contract_Relationship__c newAccCont = new Account_Contract_Relationship__c(
                // New active Account Contract
                Active__c = false,
                Account__c = myAcc.Id,
                Contract__c = contrTwo[1].Id
            );
            insert newAccCont;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertNotEquals(expectedExceptionThrown, true, 'An error should not be thrown if the new Account Contract is inactive');
        }

        // Try creating another Active contract on the account
        try {
            Contract__c myNewContract = new Contract__c(
                // 'New active Contract'
                Contract_Active__c = true,
                Primary_Account__c = myAcc.Id,
                Contract_Status__c = 'Countersigned by Coinbase',
                Contract_Type__c = 'Custodial',
                Effective_Start_Date__c = Date.today() + 15,
                Effective_End_Date__c = Date.today() + 350
            );
            insert myNewContract;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertEquals(expectedExceptionThrown, true, 'An error should be thrown if the new Contract is active');
        }

        // Try creating another Inactive contract on the account
        try {
            Contract__c myNewContract = new Contract__c(
                // 'New inactive Contract'
                Contract_Active__c = false,
                Primary_Account__c = myAcc.Id,
                Effective_Start_Date__c = Date.today(),
                Effective_End_Date__c = Date.today() + 350
            );
            insert myNewContract;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertNotEquals(expectedExceptionThrown, true, 'An error should not be thrown if the new Contract is inactive');
        }

        // Try creating another active contract on the account with an overlapping start date
        try {
            Contract__c myNewContract = new Contract__c(
                // 'New inactive Contract'
                Contract_Active__c = true,
                Primary_Account__c = myAcc.Id,
                Effective_Start_Date__c = Date.today() + 20,
                Effective_End_Date__c = Date.today() + 350
            );
            insert myNewContract;
        }

        catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('This account already has an Active Contract');
            System.AssertEquals(expectedExceptionThrown, true, 'An error should be thrown if the new Contracts start date overlaps');
        }

        List<Account_Contract_Relationship__c> potentiallyActiveAccountContracts = [SELECT
                                                        Id
                                                        FROM Account_Contract_Relationship__c
                                                        WHERE Active__c = true
                                                        AND Account__c = :myAcc.Id
                                                        ];
        System.assertEquals(potentiallyActiveAccountContracts.size(), 1, 'There should still only be one Active account contracts');
        Test.stopTest();
    }
}