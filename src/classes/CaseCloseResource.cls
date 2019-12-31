@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {

    @HttpPost
    global static void closeCases(String casesBeingClosed) {
        // Parse context
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        // Call the service
        CaseService.closeCases(
            new Set<ID> { caseId }, casesBeingClosed);
    }

}
