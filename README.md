# Salesforce_learning

Lightning Components

Lightning Components

Process Builder

Visualforce

Apx testing

@isTest static void testName() {
    // code_block
}

static testMethod void testName() {
    // code_block
}


@isTest
private class MyTestClass {
    @isTest static void myTest() {
        // code_block
    }
}


Test Apex Triggers


## day2

Apex Trigger
Visualforce
Distance Matrix
Google map API
mapquest API
openroute service 


#Mapqest

need post json data to service and get json data from the web, the API is : https://developer.mapquest.com/documentation/directions-api/route-matrix/post/

I am trying to use API to calculate the time and distance and deal with the multiple destination problem called route optimisation.




1. form ( customer input postcode)
2. website transform the postcode to latitude and longitude
3. generate the json then post to the mapquest and return the json(route matrix)
4. calculate the best fit with the location and vehcile
4. prisa the json file and return to the table on the HTML





Client - >

	Multiple contracts ->
				Multiple schedules ->
							Multiple visits

Matrix:

Join in frequency, fix visit, join different schedules
[0, 2792, 3035, 2996, 2713, 3044, 2713, 2960, 2970, 2937, 2861, 2912, 2695, 2713, 2912]
[2791, 0, 835, 568, 489, 963, 489, 773, 783, 877, 433, 483, 412, 489, 483]
[2991, 824, 0, 282, 637, 364, 637, 187, 217, 278, 512, 384, 645, 637, 384]
[2946, 541, 267, 0, 354, 394, 354, 298, 307, 308, 229, 102, 508, 354, 102]
[2737, 489, 654, 387, 0, 782, 0, 685, 695, 696, 216, 301, 456, 0, 301]
[3047, 956, 373, 414, 769, 0, 769, 267, 410, 235, 644, 516, 781, 769, 516]
[2737, 489, 653, 386, 0, 782, 0, 683, 693, 695, 215, 297, 455, 0, 297]
[2926, 775, 183, 295, 650, 271, 650, 0, 207, 275, 525, 397, 579, 650, 397]
[2930, 779, 213, 299, 654, 388, 654, 213, 0, 302, 529, 401, 583, 654, 401]
[2945, 855, 306, 313, 668, 263, 668, 298, 343, 0, 543, 415, 770, 668, 415]
[2813, 408, 519, 252, 216, 647, 216, 550, 560, 561, 0, 165, 375, 216, 165]
[2889, 485, 390, 123, 298, 517, 298, 421, 431, 431, 173, 0, 452, 298, 0]
[2743, 439, 659, 525, 446, 800, 446, 584, 593, 748, 389, 439, 0, 446, 439]
[2737, 489, 654, 387, 0, 782, 0, 685, 695, 696, 216, 301, 456, 0, 301]
[2889, 485, 390, 122, 298, 517, 298, 421, 430, 431, 173, 0, 452, 298, 0]


Consider fix time

Working time
Lunch break
Work in site
Traffic time

All:
Expiry date


Week:



Mon
Tues
Wed
Thurs
Friday


Today:


Lunch break + work in site + traffic time<= working time
Choose min


visit:

sforce.Xml
Id:null
STKR__Account_lkp__r:sforce.Xml {type: "Account", Id: null, STKR__location__Longitude__s: "-3.200273700000025", STKR__location__Latitude__s: "51.5316506"}
STKR__Fixed_Visit__c:"false"
STKR__ParentId__c:"0010N00004MEL3e"
STKR__Planned_Date__c:"2018-06-25T15:36:00.000Z"
STKR__Service__r:sforce.Xml {type: "STKR__Service__c", Id: "a0T0N00000k7df8UAA", STKR__Frequency__c: "Weekly", STKR__Service_Frequency__c: "Weekly"}
type:"STKR__Visit__c"

resource:

Id:"a0N0N00001KNcrUUAT"
Name:"Ian"
STKR__EndOfDay__c:null
STKR__Expiry_Date__c:"2019-06-05"
STKR__Lunch_Break_Minutes__c:"60.0"
STKR__Working_Hours__c:"8.0"
type:"STKR__Resource__c"



STKR__Service__c




Why not query schedule


STKR__Fix_all_Visits__c



STKR__Frequency__c



STKR__Contract_End_Date__c
STKR__Service_Interval__c


STKR__Service_Owner__c





Create the form:

SELECT Id, Name from STKR__Resource__c

SELECT Id,Name from STKR__Service_Territory__c

SELECT Id, Name,STKR__location__Latitude__s, STKR__location__Longitude__s from Account

Based on the Id,Name.




SELECT Id,Name,STKR__Account__c,STKR__Frequency__c, STKR__Contract_End_Date__c,STKR__Fix_all_Visits__c, STKR__Start_Date__c, STKR__Time_Allocation__c, STKR__Service_Owner__c from STKR__Service__c








