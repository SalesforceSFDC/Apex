public with sharing class EmailManagerConf {
    public void sendEmail (String[] addresses, String[] subjects, String[] messages) {
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
        Integer totalEmails = addresses.size();
        for(Integer i=0; i < totalEmails; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject(subjects[i]);
            email.setToAddresses(new List<String> {addresses});
            email.setPlainTextBody(messages[i]);
            emails.add(email);
        }

        Messaging.sendEmail(emails);
    }
}