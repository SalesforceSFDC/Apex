@IsTest
Private class EmailManager_Test {
    static string address;
    static string subject;
    static string body;
    static boolean sendResult;

    static void init() {
       address = 'noreply@email.com';
       subject = 'Test Email for Test Class';
       body = 'This is a Test Email for Test Class';
    }

    public static testMethod void Test_sendMail() {
        init();
        test.startTest();    
        EmailManager.sendMail(address, subject, body);
        test.StopTest(); 
    }
}
