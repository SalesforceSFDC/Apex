trigger ForceForecasting on User (before insert) {
    // for every user in our trigger, do everything inside the brackets
    for (user userInLoop : Trigger.new) {
        userInLoop.ForecastEnabled = true;
    }
}

// ForecastEnabled is a standard field on user object

/** 
userInLoop – this is the variable we created to represent each specific user in the 
loop as it iterates one by one across all users in Trigger.new. 
This variable only exists inside the brackets of the loop. 
We could’ve made it edit any field on the User object by adding another field API name 
after the period instead. 

Trigger.new – the special Salesforce variable that is a list of every User captured in our 
trigger. There will always only be one User unless you’re doing a bulk insert.
*/
