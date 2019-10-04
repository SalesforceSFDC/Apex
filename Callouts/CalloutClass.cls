public class CalloutClass {
    @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL
        String endpoint = 'http://';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET
        request.setMethod('GET');
        // Send the HTTP request and get the response
        HttpRequest response = new HTTP().send(request);
    }
}