trigger SendEmailTrigger on Contact (after insert, after delete) {
  if (Trigger.isInsert) {
    Integer recordCount = Trigger.New.size();
    // Call a utility method from EmailManager class
    EmailManager.sendEmail('vuk@anablock.com', 'Subject: record update', recordCount + ' contact()s were inserted.');
  }
  else if (Trigger.isDelete) {
    // Process after delete
  }
}
