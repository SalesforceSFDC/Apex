({
    loadRecord : function(component, recordId) {
        // Create the action
        var action = component.get("c.getStudet");

        if(studentID == null) return;

        action.setParams({"studentID": studentID});

        // Add callback behavior for when response is received
        // first parameter: this is reference to the current object
        // second parameter is a function and it accepts a single parameter: response
        // function(response) will be called by the framework when the apex call is complete
        // at that time the getState() method will return the status of the operation.
        // when SUCCESS, we use the components set method to update the student attribute 
        //  with the value returned from the Apex call

        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state==="SUCCESS") {
                component.set("v.student", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });

        // The action is queued up for execution by the Aura framework
        // $A is a reference to the Aura framework object that exposes a variety of 
        // framework level methods and properties.
        $A.enqueueAction(action);
    }
})