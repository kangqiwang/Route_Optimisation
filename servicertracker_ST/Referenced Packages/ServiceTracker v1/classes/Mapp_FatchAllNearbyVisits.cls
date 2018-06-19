/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/Mapp_FatchAllNearbyVisits/*')
global class Mapp_FatchAllNearbyVisits {
    global static Decimal valueLat {
        get;
        set;
    }
    global static Decimal valueLong {
        get;
        set;
    }
    global Mapp_FatchAllNearbyVisits() {

    }
    @HttpGet
    global static List<STKR__Visit__c> Mapp_FatchNotAssignVisitsWithin25Km() {
        return null;
    }
}
