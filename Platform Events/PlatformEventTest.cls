@isTest
public class PlatformEventTest {
    @isTest static void test1() {
        // Create test event instance
        Cloud_News__e newsEvent = new Cloud_News__e(
            Location__c='Mountain City', 
            Urgent__c=true, 
            News_Content__c='Test message.');
        
        Test.startTest();
        // Call method to publish events
        Database.SaveResult sr = EventBus.publish(newsEvent);
        
        Test.stopTest();
        
        // Perform validation here
        // Verify that the publish was successful
        System.assertEquals(true, sr.isSuccess());
        // Check that the case that the trigger created is present.
        List<Case> cases = [SELECT Id FROM Case];
        // Validate that this case was found.
        // There is only one test case in test context.
        System.assertEquals(1, cases.size());
    }
}
