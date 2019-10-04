public class AccountService {

    public class AccountContact {
        public Id accountId;
        public Id contactId;

        public AccountContact(Id accountId, Id contactId) {
            this.accountId = accountId;
            this.contactId = contactId;
        }
    }

    public static AccountContact accountAndContact(WebServices.MonorailUser muser) {

        Database.DMLOptions options = new Database.DMLOptions();
        options.DuplicateRuleHeader.AllowSave = true;

        Id accountId = insertOrUpdateAccount(muser, options);
        Id contactId = insertOrUpdateContact(muser, options, accountId);

        return new AccountContact(accountId, contactId);
       
    }

    private static Id insertOrUpdateAccount(WebServices.MonorailUser muser, Database.DMLOptions options) {

        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual').getRecordTypeId();

        Account a = new Account(
            RecordTypeId = accountRecordTypeId,
            Name = muser.name + ' Account',
            Monorail_UUID__c = muser.UUID,
            Monorail_User_Id__c = muser.userId
        );

        List<Account> accounts = [SELECT Id from Account WHERE Monorail_UUID__c = :muser.UUID];

        if (accounts.size() == 0) {
            insertSO(a, options);
        } else {
            a.Id = accounts[0].Id;
            updateSO(a, options);
        }

        return a.Id;
    }

    private static Id insertOrUpdateContact(WebServices.MonorailUser muser, Database.DMLOptions options, Id accountId) {

        Id contactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();

        Contact c = new Contact(
            RecordTypeId = contactRecordTypeId,
            FirstName = muser.firstName,
            LastName = muser.LastName,
            Email = muser.email,
            Phone = muser.phone,
            AccountId = accountId,
            Country_Code__c = muser.countryCode,
            Customer_Search_ID__c = muser.UUID,
            Customer_User_ID__c = muser.userId
        );

        List<Contact> contacts = [SELECT Id from Contact WHERE Customer_Search_ID__c = :muser.UUID];

        if (contacts.size() == 0) {
            insertSO(c, options);
        } else {
            c.Id = contacts[0].Id;
            updateSO(c, options);
        }

        return c.id;

    }

    private static void insertSO(Sobject s, Database.DMLOptions options) {
        
        Database.saveResult sr = Database.insert(s, options);

        if (!sr.isSuccess()) {
            throw new AccountServiceException(sr.getErrors()[0].getMessage());
        }

    }
    
    private static void updateSO(Sobject s, Database.DMLOptions options) {
        
        Database.saveResult sr = Database.update(s, options);

        if (!sr.isSuccess()) {
            throw new AccountServiceException(sr.getErrors()[0].getMessage());
        }

    }

    public class AccountServiceException extends Exception {}

}