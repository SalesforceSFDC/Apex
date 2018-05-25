@RestResource(urlMapping='/getEventDetails/*')
global class CSOneAPI_GetEventDetail{
    
    private static List<CS1_API_Field_Mappings__c> listResponseFields = Util_API.getAPIFieldsMapping('getEventDetails');
    private static string eventID = null;
    private static Datetime startDateTime;
    private static boolean externalUser=true;
    
    //get method to make a callout and retrieve event details w.r.t event ID
    @HttpGet
    global static CSOneAPI_ResponseOutput get(){
        CSOneAPI_Request request;
        CSOneAPI_Response response;
        CSOneAPI_Logger.addInfo(' listResponseFields -->   ' + listResponseFields);
        Map<String,String> fieldMap = RestContext.request.params;
        fieldMap=(Map<String, String>)Util_API.trimInputFields(fieldMap);
        try{
            request = CSOneAPI_ResponseOutput.getInitialCSOneRequest(
                        fieldMap.get('sourceSystem'),
                        'getEventDetails',
                        'GET',
                        'RETRIEVE',
                        fieldMap,
                        'CallIn');
            validateRequest(fieldMap);
            if(!Util_API.g_mapErroMessages.isEmpty()){
                response = new CSOneAPI_Response(Util_API.g_mapErroMessages);
            } 
            else {
                      
                List<TA_Events__c> listEvents = fetchEventDetails(fieldMap);
                if(listEvents == null ){
                    Util_API.addMessage('EVENT_EMPTY');
                }
                Map<String, String> mapEvent; 
                mapEvent= formatResponse(listEvents, fieldMap);  
                response = new CSOneAPI_Response(new EventDetailAPIWrapper(mapEvent), listEvents.size());
            }
        }
        catch(Exception e){  
            CSOneAPI_Logger.addDebug(' Exception -->   ' + e.getmessage() +' == '+ e.getLineNumber());      
            Util_API.addMessage('SYSTEM_ERROR');        
            CSOneAPI_Logger.addFinest(e.getMessage());
            response = new CSOneAPI_Response(Util_API.g_mapErroMessages);
        } 
        return CSOneAPI_ResponseOutput.getCSOneRestFinalResponse(request, response);
    }
    
    //a method to validate the request URI params
    private static void validateRequest(Map<String,String> fieldMap){
       CSOneAPI_Logger.addInfo('Validating request'); 
       eventID = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1); 
       CSOneAPI_Logger.addInfo('eventID ---> '+ eventID);
       if(Util_API.isEmptyData(eventID)){
           Util_API.addMessage('EVENT_EMPTY');         
         }  
    }
    
    //fetching all event fields to show it in response
    private static List<TA_Events__c> fetchEventDetails(Map<String,String> fieldMap){
        
        CSOneAPI_Logger.addDebug('Fetching Event details'); 
        eventID = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1); 
        List<TA_Events__c> listEvent;        
        String query = Util_API.getQueryString('TA_Events__c', listResponseFields, fieldMap.get('fields'));
        query += ' WHERE Name=:eventID ';
        CSOneAPI_Logger.addInfo('query  -- '+query );
        startDateTime = System.now();
        listEvent= Database.query(query);
        if(listEvent.size() == 0 ){
           return null;
        }
        CSOneAPI_Logger.addLogEntry(CSOneAPI_Logger.Type.QUERY , LoggingLevel.DEBUG,'SOQL :'+query,null,null,startDateTime,null,null);      
        
        return listEvent;
    
    }
    
    //constructing the response with the queried result
    private static Map<String, String> formatResponse(List<TA_Events__c> listEvent, Map<String,String> fieldMap){
        CSOneAPI_Logger.addDebug('Formatting response'); 
        Map<String, String> caseDataMap = new Map<String, String>();
        String fieldsStr = fieldMap.get('fields');
            
        for(Sobject caseRec: listEvent){
            caseDataMap = Util_API.getResponseMap(caseRec, listResponseFields, fieldsStr);
            startDateTime = System.now();
        }
          
          return caseDataMap;
    }
    
    // wrapper class for response
    private class EventDetailAPIWrapper implements CSOneAPI_ResponseInterface{
      
        public Map<String, String> eventDetail = new Map<String, String>();
            
        public EventDetailAPIWrapper(Map<String, String> eventsMap){
            this.eventDetail = eventsMap;
        }
            
    }
}
