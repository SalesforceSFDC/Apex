trigger SendConfirmatioEmail on Session_Speaker__c (after insert) {
    // collect IDs in one list of a single SOQL query
    List<Id> sessionSpeakerIds = new List<Id>();
    for (Session_Speaker__c newItem : Trigger.new) {
        sessionSpeakerIds.add(newItem.Id);
    }

    // Retrieve session name and time + speaker name and email address related to ID's
    // Retrieves only if speaker has email address
    List<Session_Speaker__c> sessionSpeakers =      
        [SELECT Session__r.Name,
                Session__r.Session_Date__c,
                Speaker__r.First_Name__c,
                Speaker__r.Last_Name__c,
                Speaker__r.Email__c
            FROM Session_Speaker__c WHERE Id IN :sessionSpeakerIds
            AND Speaker__r.Email__c <> NULL]; //If Speaker__r.Email__c is anything except equal to y
    if (sessionSpeakers.size() > 0) {
        // send confirmation email
        String[] addresses = new String[]{},
            	 subjects = new String[]{},
                 messages = new String[]{};
        for (Session_Speaker__c sessionSpeaker: sessionSpeakers){
            addresses.add(sessionSpeaker.Speaker__r.Email__c);
            subjects.add('Speaker Confirmation');
            messages.add('Dear ' + sessionSpeaker.Speaker__r.First_Name__c +
                    ',\nYour session "' + sessionSpeaker.Session__r.Name + '" on ' +
                    sessionSpeaker.Session__r.Session_Date__c + ' is confirmed.\n\n' +
                    'Thanks for speaking at the conference!');
        }

            EmailManager em = new EmailManager();
            em.sendEmail(addresses, subjects, messages);
    }
}