@isTest
public class AcceptCaseControllerTest {
	public static testMethod void testAcceptCaseController1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Id queueId = [select Id from Group where Type = 'Queue' and DeveloperName='T1_Support_General' limit 1].Id;
        Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Support').getRecordTypeId();
        Case c = new Case();
		c.SuppliedEmail = 'email2@test.com';
		c.RecordTypeId = recTypeId;
		c.Origin = 'Web';
		c.s_Product__c = 'Coinbase';
        c.OwnerId = queueId;
		insert c;
        AcceptCaseController.validateCurrentOwner(c.Id);
        c.OwnerId = UserInfo.getUserId();
        AcceptCaseController.updateStatus(c, c.Id);
        AcceptCaseController.validateCurrentOwner(c.Id);
    }
}