public with sharing class MapControllertest {
public STKR__nearestTechSettings__c mappingSettings {get;set;}

    public MapControllertest(){
    
        Decimal forecastDays = 0; //default protects against no settings
        
        try{
            mappingSettings = STKR__nearestTechSettings__c.getInstance();
            if(mappingSettings.STKR__Availability_Forecast_days__c != null){
            forecastDays = mappingSettings.STKR__Availability_Forecast_days__c.intValue();
            }
        }catch(exception e){
			if (forecastDays !==14){
            System.debug('should default to 14');
        	
            
        }
        
    }

}