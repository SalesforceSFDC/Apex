public global with sharing class EmailManagerNew {
    // public method
    public void sendEmail(String address, String subject, String body) {
        // create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddress = new List<String>(){ email };
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        // Pass this email message to the built-in sendEmail method of the Messaging class
        List<Messaging.SingleEmailMessage> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });

        // Call a helper method to inspect the results
        inspectResults(results);
    }

    // Helper method
    private static Boolean inspectResults(List<Messaging.SingleEmailMessage> results) {
        Boolean sendResult = true;

        // sendEmail returns a List of result objects
        // Iterate through the list to inspect results.
        // In this class, the methods send only one email,
        // so we should have only one result.
        for (Messaging.SendEmaiResult res : results) {
            f (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());
            }
        }

        return sendResult;
    }

}


// Create a list and add elements to it in one step
List<String> colors = new List<String> { 'red', 'green', 'blue' };
// Add elements to a list after it has been created
List<String> moreColors = new List<String>();
moreColors.add('orange');
moreColors.add('purple');
// Get elements from a list
String color1 = moreColors.get(0);
String color2 = moreColors[0];
System.assertEquals(color1, color2);
// Iterate over a list to read elements
for(Integer i=0;i<colors.size();i++) {
    // Write value to the debug log
    System.debug(colors[i]);
}


// instance methods access class member variables
// instance methods are called on the instance of a class
// static methods are called directly on the class name
