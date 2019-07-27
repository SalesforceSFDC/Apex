@isTest
public class ForceForecasting_TEST {
    static testMethod void insertNewUser() {
        User userToCreate = new User();

        userToCreate.FirstName = 'David';
        userToCreate.LastName  = 'Liu';
        userToCreate.Email     = 'dvdkliu+sfdc99@gmail.com';
        userToCreate.Username  = 'sfdc-dreamer@gmail.com';
        userToCreate.Alias     = 'fatty';
        userToCreate.ProfileId = '00ei0000000rTfp';
        userToCreate.TimeZoneSidKey    = 'America/Denver';
        userToCreate.LocaleSidKey      = 'en_US';
        userToCreate.EmailEncodingKey  = 'UTF-8';
        userToCreate.LanguageLocaleKey = 'en_US';

        insert userToCreate;
    }
}
