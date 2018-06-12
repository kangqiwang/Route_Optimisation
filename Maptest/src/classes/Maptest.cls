public with sharing class Maptest {

public String visits { get; set; }
public String acc = null;
public Account Account;
public String templist {get; set;}
public list<STKR__Resource__c> objAccounts {get;set;}
public list<STKR__Resource__c> objResources {get;set;}
public list<Summary> scheduleData {get;set;}
public list<Summary> eventData {get;set;}
public list<STKR__Visit__c> objAllVisits {get;set;}
public list<STKR__Visit__c> objJVisits {get;set;}
public list<STKR__Visit__c> objCVisits {get;set;}
public list<STKR__Visit__c> objFVisits {get;set;}
public list<STKR__Service__c> objConVisits {get;set;}
public STKR__nearestTechSettings__c mappingSettings {get;set;}

    public Maptest(){
    
    Decimal forecastDays = 0; //default protects against no settings
    
      try{
     
          //override forecastDays if it's set up in the system. 
          mappingSettings = STKR__nearestTechSettings__c.getInstance();
          if(mappingSettings.STKR__Availability_Forecast_days__c != null){
          forecastDays = mappingSettings.STKR__Availability_Forecast_days__c.intValue();
          }


          } catch(exception e) {
          //carry on, forecastDays should default to 14...
      }
    

      try{
            
          objAccounts = new list<STKR__Resource__c>();  
          objAccounts.addAll([SELECT Id,Name,LastModifiedDate,STKR__Location__Latitude__s,STKR__Location__Longitude__s,STKR__Territory__r.Name FROM STKR__Resource__c where STKR__Location__Latitude__s <> null AND STKR__Status__c != 'Inactive' limit 1000]);

          objResources = new list<STKR__Resource__c>();  
          objResources.addAll([SELECT Id,Name,STKR__Working_Hours__c,LastModifiedDate,STKR__Fixed_Location__Latitude__s, STKR__Fixed_Location__Longitude__s, STKR__Location__Latitude__s,STKR__Location__Longitude__s,STKR__Territory__r.Name FROM STKR__Resource__c where STKR__Location__Latitude__s <> null AND STKR__Status__c != 'Inactive' AND (NOT STKR__User__r.profile.name like '%admin%') limit 1000]);

          objAllVisits = new list<STKR__Visit__c>();  
          objAllVisits.addAll([SELECT Id,
                                  Name,
                                  STKR__Fixed_Visit__c,
                                  STKR__Resource__c,
                                  STKR__Resource_Name__c,
                                  STKR__time_allocation__c,
                                  STKR__Status__c,
                                  STKR__Address__c,
                                  STKR__Account_Lkp__r.Name,
                                  STKR__Account_lkp__r.STKR__Location__Latitude__s,
                                  STKR__Account_lkp__r.STKR__Location__Longitude__s,
                                  STKR__Due_Date__c 
                              FROM STKR__Visit__c where STKR__Account_lkp__r.STKR__Location__Latitude__s <> null AND STKR__Status__c != 'Complete' and STKR__Due_Date__c < NEXT_N_DAYS:7 AND STKR__Due_Date__c >= TODAY ORDER BY STKR__Due_Date__c Asc limit 1000]);
                              
          //get the sum total of visit hours by resource, by day   
          AggregateResult[] results = database.query('Select STKR__Resource__c resourceID, day_Only(STKR__Due_date__c) dueDate, Sum(STKR__time_allocation__c) quantity FROM STKR__Visit__c WHERE STKR__Due_date__c= NEXT_N_DAYS:' + forecastDays +  ' GROUP BY STKR__Resource__c, day_Only(STKR__Due_date__c) ORDER BY day_Only(STKR__Due_date__c)');

          scheduleData = new List<Summary>();
          for (AggregateResult ar : results) {    
                          
                  scheduleData.add(new Summary(ar));
          }
          
          
          //get the sum total of event time by resource by day
          AggregateResult[] eventResults = database.query('Select What.id resourceID, day_Only(StartDateTime) dueDate, Sum(DurationInMinutes) quantity FROM Event WHERE StartDateTime = NEXT_N_DAYS:' + forecastDays  + ' GROUP BY what.id, day_Only(StartDateTime)');

          eventData= new List<Summary>();
          for (AggregateResult ar : eventResults ) {    
                  eventData.add(new Summary(ar));
          }          

          objCVisits = new list<STKR__Visit__c>();  
          objCVisits.addAll([SELECT Id,Name,STKR__Address__c,STKR__Account_lkp__r.STKR__Location__Latitude__s,STKR__Account_Lkp__r.Name,STKR__Account_lkp__r.STKR__Location__Longitude__s FROM STKR__Visit__c where STKR__Account_lkp__r.STKR__Location__Latitude__s <> null AND STKR__Visit_Type__c = 'Call Out'  AND STKR__Status__c != 'Complete' ORDER BY STKR__Due_Date__c Asc limit 1000]);

          objJVisits = new list<STKR__Visit__c>();  
          objJVisits.addAll([SELECT Id,Name,STKR__Address__c,STKR__Account_lkp__r.STKR__Location__Latitude__s,STKR__Account_Lkp__r.Name,STKR__Account_lkp__r.STKR__Location__Longitude__s FROM STKR__Visit__c where STKR__Account_lkp__r.STKR__Location__Latitude__s <> null AND STKR__Visit_Type__c = 'Job Visit' AND STKR__Status__c != 'Complete' ORDER BY STKR__Due_Date__c Asc limit 1000]);

          objFVisits = new list<STKR__Visit__c>();  
          objFVisits.addAll([SELECT Id,Name,STKR__Address__c,STKR__Account_lkp__r.STKR__Location__Latitude__s,STKR__Account_Lkp__r.Name,STKR__Account_lkp__r.STKR__Location__Longitude__s FROM STKR__Visit__c where STKR__Account_lkp__r.STKR__Location__Latitude__s <> null AND STKR__Visit_Type__c = 'Follow-Up' AND STKR__Status__c != 'Complete' ORDER BY STKR__Due_Date__c Asc limit 1000]);
                        
          objConVisits = new list<STKR__Service__c>();  
          objConVisits.addAll([SELECT Id,Name,STKR__Address__c,STKR__Next_Visit_Date__c,STKR__Current_Visit_Number__c,STKR__Number_of_Visit_Per_Year__c, STKR__Account__r.STKR__Location__Latitude__s,STKR__Account__r.Name,STKR__Account__r.STKR__Location__Longitude__s FROM STKR__Service__c where STKR__Account__r.STKR__Location__Latitude__s <> null AND STKR__Service_Type__c = 'Contract Schedule' AND STKR__Status__c = 'Active' ORDER BY STKR__Next_Visit_Date__c Asc limit 1000]);

        }catch(Exception ex){} 
      }
    
    
    public Account getAccount() {
        if(Apexpages.currentPage().getParameters().get('Accid') != null){
          acc = Apexpages.currentPage().getParameters().get('Accid');
          try{      
          account = [SELECT Id,Name,STKR__Location__Latitude__s,STKR__Location__Longitude__s FROM Account
                WHERE Id = :acc AND STKR__Location__Latitude__s <> null]; 
          } catch (exception e){}      
        } else {
        
       account = null;          
        
        }   
        
    Return account;   
             
  }    
  
    // wrapper class to hold aggregate data
    public class Summary {
        public Decimal Quantity { get; private set; }
        public String Name { get; private set; }
        public DateTime EventDate  { get; private set; }

        public Summary(AggregateResult ar) {
            
            //cast data to DateTime to enable formatting later. 
            EventDate = (DateTime) ar.get('dueDate');
        
            Quantity = (Decimal) ar.get('quantity');
            Name = (String) ar.get('resourceID') + EventDate.format('yyyy-MM-dd');
        }
        
    }
    
    

}