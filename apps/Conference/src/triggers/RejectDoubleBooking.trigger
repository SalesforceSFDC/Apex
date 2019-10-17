trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {
    // collect IDs in one list of a single SOQL query to reduce data calls 
    List<Id> speakerIds = new List<Id>();
    Map<Id, DateTime> requested_bookings = new Map<Id, DateTime>();
    // get all speakers related to the trigger 
    // set booking map with Ids to fill later
    for (Session_Speaker__c newItem :Trigger.New) {
        requested_bookings.put(newItem.Session__c, null);
        speakerIds.add(newItem.Speaker__c);
    }

    // fill out start date/time for the related sessions
    List<Session__c> related_sessions = [SELECT ID, Session_Date__c 
                                            FROM Session__c 
                                            WHERE ID
                                            IN :requested_bookings.keySet()];
    for (Session__c related_session : related_sessions) {
        requested_bookings.put(related_session.Id,related_session.Session_Date__c);
    }

    //get related speaker sessions to check against
    List<Session_Speaker__c> related_speakers = [SELECT ID, Speaker__c, Session__c, Session__r.Session_Date__c from Session_Speaker__c WHERE Speaker__c IN :speakerIds];
    //check one list against the other
    for(Session_Speaker__c requested_session_speaker : trigger.new) {
        DateTime booking_time = requested_bookings.get(requested_session_speaker.Session__c);
        for(Session_Speaker__c related_speaker : related_speakers) {
            if(related_speaker.Speaker__c == requested_session_speaker.Speaker__c &&
               related_speaker.Session__r.Session_Date__c == booking_time) {
                   requested_session_speaker.addError('The speaker is already booked at that time');
            }
        }
    }
}