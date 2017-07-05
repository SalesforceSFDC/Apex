public class CalloutClass {
  @future(callout=true)
  public static void makeCallout() {
    HttpRequest request = new HttpRequest();
    // Set endpoint URL
    String endpoint = 'http://salesforce.com';
    request.setEndPoint(endpoint);
    // Set the HTTP verb to GET.
    request.setMethod('GET');
    // Set the HTTP request and get the response.
    HttpRequest response = new HTTP().send(request);
  }
}
    
