public with sharing class EventController {

    @AuraEnabled(Cacheable=true)
    public static List<List<SObject>> searchEventRecord(string Name){
        List<List<SObject>> eventLst= [FIND :Name IN ALL FIELDS RETURNING Event__c(Name__c)];
        return eventLst;
    }

    @AuraEnabled(Cacheable=true)
    public static list<Event__C> getEventRecord(){
        list<Event__c> eventLst=[SELECT  Name__c FROM Event__c];
        return eventLst;
    }

    @AuraEnabled(Cacheable=true)
    public static list<Event__C> getEventDetailRecord(string eventId){
        list<Event__c> eventLst=[SELECT  Name__c,Status__c,Start_Date__c,End_Date__c,Event_Type__c,
                                Max_Seats__c,People_Attending__c,Live__c FROM Event__c WHERE Id=:eventId];
        return eventLst;
    }

    @AuraEnabled(Cacheable=true)
    public static list<Event__C> getEventRecordForEventComp(){
        list<Event__c> eventLst=[SELECT  Name__c,Start_Date__c,End_Date__c,Event_Type__c,
                                Max_Seats__c,People_Attending__c,Live__c
                                 FROM Event__c WHERE Start_Date__c >=TODAY AND Live__c=true ];
        return eventLst;
    }

}