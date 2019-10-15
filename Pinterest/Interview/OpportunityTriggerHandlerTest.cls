@isTest
private class OpportunityTriggerHandlerTest {
    
    @isTest
    static void successfulStageChangedTest() {
        Opportunity opportunity = createSomeOpportunity();
        Set<String> allContactRoles = OpportunityTriggerHandler.getContactRoles();
        
        for (String roleName : allContactRoles) {
            OpportunityContactRole contactRole = createOpportunityContactRole(createContact(), opportunity, roleName);
        }
        
        opportunity.StageName = 'Qualification';
        update opportunity;
        
        Test.startTest();
        opportunity = [SELECT Id, StageName FROM Opportunity WHERE Id = :opportunity.Id];
        System.assertEquals('Qualification', opportunity.StageName);
        Test.stopTest();
    }
    
    @isTest
    static void validationErrorAppiredTest() {
        Opportunity opportunity = createSomeOpportunity();
        Set<String> allContactRoles = OpportunityTriggerHandler.getContactRoles();
        
        for (String roleName : allContactRoles) {
            OpportunityContactRole contactRole = createOpportunityContactRole(createContact(), opportunity, null);
        }
        
        try{
        Test.startTest();
        opportunity.StageName = 'Qualification';
        update opportunity;
        Test.stopTest();
        
        } catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('All Specified Opportunity Contact Roles must be present for each stage to be selected') ? true : false;
            system.assertEquals(expectedExceptionThrown, true);       
        } 
        
    } 
    
    static Opportunity createSomeOpportunity() {
        Opportunity opportunity = new Opportunity(
            Name = 'Test Opportunity',
            CloseDate = Date.today() + 1,
            StageName = 'Prospecting'
        );
        insert opportunity;
        return opportunity;
    }
    
    static Contact createContact() {
        Contact contact = new Contact(
            FirstName = 'First Name',
            LastName = 'Last Name ' + System.now()
        );
        insert contact;
        return contact;
    }
    
    static OpportunityContactRole createOpportunityContactRole(Contact contact, Opportunity opportunity, String roleName) { 
        OpportunityContactRole opportunityContactRole = new OpportunityContactRole(
            ContactId = contact.Id,
            OpportunityId = opportunity.Id,
            Role = roleName
        );
        insert opportunityContactRole;
        return opportunityContactRole;
    }
    
}