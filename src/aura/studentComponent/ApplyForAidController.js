({
	doInit : function(component, event, helper) {
		
        var recordId = component.get("v.recordId");
        if(recordId == null) return;
        
        helper.loadRecord(component, recordId);
    },
    
    applyForAid : function(component, event, helper) {
        
        // create the action
        var action = component.get("c.applyForAidAction");

        var recordId = component.get("v.recordId");
        if(recordId == null) return;

        action.setParams({
            "studentID": recordId
        });

        // e. - indicates an event
        // Add callback behavior for when reponse is received
        // get the event and fire it immediately
        // call the loadRecord.loadRecord class to reload the record from the database to get the latest copy
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                helper.loadRecord(component, recordId); 
            } else {
                console.log('Failed with state: ' + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);
    }
})