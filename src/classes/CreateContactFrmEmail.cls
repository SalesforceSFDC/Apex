/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 * https://www.jitendrazaa.com/blog/salesforce/email-services-in-salesforce-with-simple-example/
 */
global class CreateContactFrmEmail implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

		String subToCompare = 'Create Contact';

		if(email.subject.equalsIgnoreCase(subToCompare))
		{
			Contact c = new Contact();
			c.LastName = email.plainTextBody;
			insert c;

                // Save attachments, if any
        	for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
          	Attachment attachment = new Attachment();

          	attachment.Name = tAttachment.fileName;
          	attachment.Body = Blob.valueOf(tAttachment.body);
          	attachment.ParentId = c.Id;
          	insert attachment;
        	}

        	//Save any Binary Attachment
        	for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
          	Attachment attachment = new Attachment();

          	attachment.Name = bAttachment.fileName;
          	attachment.Body = bAttachment.body;
          	attachment.ParentId = c.Id;
          	insert attachment;
        	}
		}

	result.success = true;
        return result;
    }

    static testMethod void testCreateContactFrmEmail() {
    	Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();

        email.subject = 'Create Contact';
        email.plainTextBody = 'FromEmail';
        env.fromAddress = 'ilovenagpur@gmail.com';

        CreateContactFrmEmail creatC = new CreateContactFrmEmail();
        creatC.handleInboundEmail(email, env );
    }
}
