public class OpportunityTriggerHandler {
    
    public static void validateOpportunitiesContactRoles(Map<Id, Opportunity> opportunityMapOld, List<Opportunity> opportunityListNew) {
        for (Opportunity opportunity : opportunityListNew) {
            Opportunity oldOpportunity = opportunityMapOld.get(opportunity.Id);
            
            if (opportunity.StageName != oldOpportunity.StageName) {
                Set<String> allContactRoles = getContactRoles();
                Set<String> contactRolesInOpportunity = new Set<String>();
                
                List<OpportunityContactRole> contactRolesForOpportunityList = [SELECT Id, Role FROM OpportunityContactRole WHERE OpportunityId = :opportunity.Id];
                if (contactRolesForOpportunityList != null && !contactRolesForOpportunityList.isEmpty()) {
                    for (OpportunityContactRole cr : contactRolesForOpportunityList) {
                        contactRolesInOpportunity.add(cr.Role);
                    }
                }
                
                if(!contactRolesInOpportunity.containsAll(allContactRoles)) {
                    opportunity.addError('All Specified Opportunity Contact Roles must be present for each stage to be selected');
                }
                
            }
        }
    }
    
    public static Set<String> getContactRoles() {
        Set<String> contactRoleSet = new Set<String>();
        
        Schema.DescribeFieldResult fieldContactRoleNames = OpportunityContactRole.Role.getDescribe();
        List<Schema.PicklistEntry> ple = fieldContactRoleNames.getPicklistValues();
        
        for(Schema.PicklistEntry p : ple) {
            contactRoleSet.add(p.getValue());
        }       
        return contactRoleSet;
    }
    
}