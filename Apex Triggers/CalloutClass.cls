public class CalloutClass {
  @future(callout=true)
  public static void makeCallout() {
    HttpRequest request = new HttpRequest();
    // Set the endpoint URL
    String endpoint = 'http://yourHost/yourService';
    request.setEndpoint(endpoint);
    // Set the HTTP verb to GET
    request.setMethod('GET');
    // Send the HTTP request and get the response
    HttpResponse respones = new HTTP().send(request);
  }
 }
