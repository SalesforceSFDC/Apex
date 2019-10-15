trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {
    // collect IDs to reduce data calls
}