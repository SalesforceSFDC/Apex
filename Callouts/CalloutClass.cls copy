/**
To make a from a trigger, call a class method that executes asynchronously.
This method is called a future method and is annotated with @future(callout=true).
**/

public class CalloutClass {
  @future(callout=true)
  public static void makeCallout() {
    HttpRequest request = new HttpRequest();
    // Set the endpoint URL.
    String endpoint = 'http://yourHost/yourSpace';
    request.setEndPoint(endpoint);
    // Set the HTTP verb to GET.
    request.setMethod('GET');
    // Send the HTTP request and get the response.
    HttpResponse response = new HTTP().send(request);
  }
}
