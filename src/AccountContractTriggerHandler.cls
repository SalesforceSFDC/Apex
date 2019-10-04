public with sharing class AccountContractTriggerHandler {

    public static void deactivateOldActiveContracts(List<Account_Contract_Relationship__c> accountContracts) {
        List<Account_Contract_Relationship__c> allActiveContracts = [SELECT
                                                        Id,
                                                        Account__c,
                                                        Account_Contract_Relationship_Type__c,
                                                        Active__c,
                                                        Contract__c,
                                                        Effective_Start_Date__c,
                                                        Effective_End_Date__c,
                                                        Contract_Type__c,
                                                        Primary_Account__c,
                                                        Primary_Account_Custody_Org_Id__c,
                                                        Account__r.Id
                                                        FROM Account_Contract_Relationship__c
                                                        WHERE Active__c = true
                                                        ];
        Map<Id, Account_Contract_Relationship__c> allActiveContractsToAccounts = new Map<Id, Account_Contract_Relationship__c>();
        List<Account_Contract_Relationship__c> accountContractsToUpdate = new List<Account_Contract_Relationship__c>();
        for (Account_Contract_Relationship__c actCont : allActiveContracts) {
            allActiveContractsToAccounts.put(actCont.Account__r.Id, actCont);
        }
        for (Account_Contract_Relationship__c accCont : accountContracts) {
            if (accCont.Active__c == true) {
                // if there are any other active Account Contracts related to the same Account
                if (allActiveContractsToAccounts.get(accCont.Account__c) != null) {
                    // check if they meet our criteria for denying a new active Account Contract
                    if (accCont.Effective_Start_Date__c <= allActiveContractsToAccounts.get(accCont.Account__c).Effective_End_Date__c &&
                    accCont.Contract_Type__c == allActiveContractsToAccounts.get(accCont.Account__c).Contract_Type__c
                    ) {
                        accCont.addError('This account already has an Active Contract');
                    }
                }   
            }
        }
    }
}