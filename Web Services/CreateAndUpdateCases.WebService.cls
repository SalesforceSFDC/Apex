@RestResource(urlMapping='/cs1case/*')
global class CSOneAPI_CreateCase
{
	@HttpPost
    global static CSOneAPI_ResponseOutput createCase()
    {
        CSOneAPI_Logger.addInfo('The Case API Service - Create Case was just invoked');
        //Use the request context to capture the request parameters from the URL
        Map<String,String> mapUriParam = RestContext.request.params; 
        //CSONE-6131 Nikita    12.6   2-dec-2015
        //calling function in Util_API to trim the field values.
        mapUriParam=(Map<String,String>)Util_API.trimInputFields(mapUriParam);
        String strRquestBody = RestContext.request.requestBody.toString();
        CSOneAPI_Logger.addDebug('Query String Check'+String.valueOf(mapUriParam));
        Map<String, Object> mapRequestParams = (Map<String, Object>)JSON.deserializeUntyped(strRquestBody);
        //CSONE-6131 Nikita    12.6   2-dec-2015
        //calling function in Util_API to trim the field values.
        mapRequestParams=Util_API.trimInputFields(mapRequestParams);
        CSOneAPI_Logger.addDebug('Requst Body Check'+String.valueOf(mapRequestParams));
        //Now assign request parameters and it's details to request instance constructor
        CSOneAPI_Request req = CSOneAPI_ResponseOutput.getInitialCSOneRequest(mapUriParam.get('sourcesystem'),
            'createCase','POST','INSERT',mapUriParam,'CallIn');
        CSOneAPI_Response res;
        CSOneAPI_ResponseOutput finalOutPut;
        try
        {
            // CSONE-6243 - added Content-Type validation - kvelury
            if (!Util_API.isValidContentType(RestContext.request)) {
                Util_API.addMessage(Util_API.INVALID_CONTENT_TYPE);
                res = new CSOneAPI_Response();
                finalOutPut = CSOneAPI_ResponseOutput.getCSOneRestFinalResponse(req, res);
            }
            else {
                CSOneAPI_CaseUtils.req = req;
                finalOutPut = CSOneAPI_CaseUtils.createNewCase(mapUriParam, mapRequestParams);
            }
        }
        catch (exception e)
        {
            Util_API.addException(e.getMessage(), e.getMessage());
            res = new CSOneAPI_Response(Util_API.getDefaultExceptionCode());
            finalOutPut = CSOneAPI_ResponseOutput.getCSOneRestFinalResponse(req,res);
        }
        return finalOutPut;
    }
}
