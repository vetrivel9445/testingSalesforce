public with sharing class CustomObjectController {

    @AuraEnabled(cacheable=true)
    public static list<Event_Speaker__c> getEventSpeaker(string eventId){
        list<Event_Speaker__c> eventSpeakerLst=[SELECT 
                                                Id,Name,Speaker__r.Name,Speaker__r.Company__c,Event__c
                                                FROM 
                                                Event_Speaker__c
                                                WHERE
                                                Event__c=:eventId];
        return eventSpeakerLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Event_Attendee__c> getEventAttendees(string eventId){
        list<Event_Attendee__c> eventAttendeeLst=[SELECT
                                                Id,Event__c,Attendee__r.Name,Attendee__r.Address__c,Attendee__r.Company_Name__c
                                                FROM
                                                Event_Attendee__c
                                                WHERE
                                                Event__c =:eventId
                                                ];
        return eventAttendeeLst;
                                                
    }

    @AuraEnabled(cacheable=true)
    public static list<Event__c> getLocation(string eventId){
        list<Event__c> locationLst=[SELECT
                                    Id,Location__r.Name,Location__r.Street__c,Location__r.State__c,Location__r.City__c,
                                    Location__r.Country__c,Location__r.Landmark__c
                                    FROM
                                    Event__c
                                    WHERE
                                    Id=:eventId
                                    ];
                                    return locationLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Event_Attendee__c> getAttendeesForUpcoming(string attendeeId){
        list<Event_Attendee__c> eventAttendeeLst=[SELECT
                                                 Name,Event__c,Event__r.Name,Event__r.Name__c,Event__r.Live__c,
                                                 Event__r.Start_Date__c,Event__r.Event_Type__c,Event__r.Location__c,
                                                 Event__r.Location__r.Name,Event__r.Organizer__r.Name,
                                                 Attendee__c
                                                 FROM Event_Attendee__c
                                                 WHERE Attendee__c = :attendeeId
                                                 AND Event__r.Start_Date__c >= today
                                                 AND Event__r.Live__c = true
                                                ];
        return eventAttendeeLst;
                                                
    }
    @AuraEnabled(cacheable=true)
    public static list<Event_Attendee__c> getAttendeesForPastEvent(string attendeeId){
                                                list<Event_Attendee__c> eventAttendeeLst=[SELECT
                                                Name,Event__c,Event__r.Name,Event__r.Name__c,Event__r.Live__c,
                                                Event__r.Start_Date__c,Event__r.Event_Type__c,Event__r.Location__c,
                                                Event__r.Location__r.Name,Event__r.Organizer__r.Name,
                                                Attendee__c
                                                FROM Event_Attendee__c
                                                WHERE
                                                Attendee__c = :attendeeId AND Event__r.Start_Date__c < today
                                                ];
        return eventAttendeeLst;
                                                
    }
}