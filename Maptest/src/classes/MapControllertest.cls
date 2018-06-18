public with sharing class MapControllertest {
    public list<STKR__Resource__c> objectResource {get; set;}
	public STKR__nearestTechSettings__c mappingSettings {get;set;}
    public list<STKR__Service_Territory__c> objectTerritory {get; set;}
    public MapControllertest(){
        Decimal forecastDays = 0; //default protects against no settings
        //get the resource.name and id
    	objectResource=new list<STKR__Resource__c>();
        objectResource.addAll([SELECT Id, Name from STKR__Resource__c]);
        //get the territory
        objectTerritory = new list<STKR__Service_Territory__c>();
        objectTerritory.addAll([SELECT Name from STKR__Service_Territory__c]);
        System.debug(objectResource);
        System.debug(objectTerritory);
      try{
     
          //override forecastDays if it's set up in the system. 
          mappingSettings = STKR__nearestTechSettings__c.getInstance();
          if(mappingSettings.STKR__Availability_Forecast_days__c != null){
          forecastDays = mappingSettings.STKR__Availability_Forecast_days__c.intValue();
          }


          } catch(exception e) {          //carry on, forecastDays should default to 14...
            if (forecastDays != 14){
            System.debug('should default to 14');
          }
          
          
      }
        
/*
        JSONGenerator gen = JSON.createGenerator(true);   
        List<String> locationlist = new List<String>();
        locationlist.add('51.4816, 3.1791');
        locationlist.add('51.5788, 3.2181');
        locationlist.add('51.5842, 2.9977');

                gen.writeStartObject();
        gen.writeObjectField('locations ', locationlist);
        gen.writeFieldName('options');
        gen.writeStartObject();
        gen.writeBooleanField('allToAll', true);
        gen.writeEndObject();
        gen.writeEndObject();

        String pretty=gen.getAsString();
        System.debug(pretty);
        
                String url='http://www.mapquestapi.com/directions/v2/routematrix?key=XFI9f8gkExRTk58rq7jyxDSMgkgt06KV';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody(pretty);
        req.setHeader('Content-Type', 'application/json');
        Http http =new Http();
        HTTPResponse response = http.send(req);
        System.debug(response.getBody());
*/
        
    
        
    }

}