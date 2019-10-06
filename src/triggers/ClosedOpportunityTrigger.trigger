/** 
The Apex trigger must be called 'ClosedOpportunityTrigger'

With 'ClosedOpportunityTrigger' active, if an opportunity is inserted or updated with a stage of 'Closed Won', 
it will have a task created with the subject 'Follow Up Test Task'.

To associate the task with the opportunity, fill the 'WhatId' field with the opportunity ID.
This challenge specifically tests 200 records in one operation.
*/
trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    
}