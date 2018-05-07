/*
The Apex testing framework utilizes this ‘mock’ response instead of making the actual callout to the REST API endpoint.
*/

@isTest
global class SMSCalloutMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"success"}');
        res.setStatusCode(200);
        return res; 
    }
}
