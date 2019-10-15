trigger OpportunityTrigger on Opportunity (before update) {
    if(trigger.isBefore && trigger.isUpdate) {
    	OpportunityTriggerHandler.validateOpportunitiesContactRoles(Trigger.oldMap, Trigger.new);
    }    
}