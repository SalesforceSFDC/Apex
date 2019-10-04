@isTest public with sharing class AccountServiceTest {

    /* Given  : An instance of WebServices.MonorailUser create new Account and Contact corresponding
     *          to the user
     *
     * Expect : A new Account and Contact
     */
    @isTest static void createAccountAndContact() {

        /* not expecting any @testSetup Accounts/Contacts
        */
        System.assertEquals(0, [SELECT count() from Contact]);  
        System.assertEquals(0, [SELECT count() from Account]);

        /* create a successful search return value
        */
        WebServices.MonorailUser muser = new WebServices.MonorailUser();

        muser.UUID = 'abc';
        muser.userId = '123a';
        muser.phone = '14155551212';
        muser.name = 'Jane Doe';
        muser.firstName = 'Jane';
        muser.lastName = 'Doe';
        muser.email = 'jane@doe.org';
        muser.countryCode = 'US';
        muser.errorMessage = null;

        AccountService.AccountContact ac = AccountService.accountAndContact(muser);

        Contact janeContact = [
            SELECT Name, FirstName, LastName, Email, Phone, Country_Code__c, Customer_Search_ID__c, Customer_User_ID__c
            FROM Contact
        ];

        System.assertEquals( muser.name, janeContact.Name );
        System.assertEquals( muser.firstName, janeContact.FirstName );
        System.assertEquals( muser.lastName, janeContact.LastName );
        System.assertEquals( muser.phone, janeContact.Phone );
        System.assertEquals( muser.countryCode, janeContact.Country_Code__c );
        System.assertEquals( muser.UUID ,janeContact.Customer_Search_ID__c );
        System.assertEquals( muser.userId, janeContact.Customer_User_ID__c );

        Account janeAccount = [
            SELECT Name, Monorail_UUID__c, Monorail_User_Id__c
            FROM Account
        ];

        System.assertEquals( muser.name + ' Account', janeAccount.Name );
        System.assertEquals( muser.UUID, janeAccount.Monorail_UUID__c );
        System.assertEquals( muser.userId, janeAccount.Monorail_User_Id__c );

    }

}