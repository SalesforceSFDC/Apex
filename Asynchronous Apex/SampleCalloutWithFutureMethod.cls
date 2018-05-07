/*
To make a Web Service callout to an external service or API, create an Apex class with a future method
that is marked with (callout=true).
This class has both synchronous and asynchronous methods for making callouts (where permitted).
*/

public class SMSUtils {
  // Call async from triggers, etc, where callouts are not permitted.
  @future(callout=true)
  public static void sendSMSAsync(String fromNbr, String toNbr, String m) {
    String results = sendSMS(fromNbr, toNbr, m);
  }
}
