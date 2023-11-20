public class EventSpeakerTriggerHandler {
    public static decimal preventEvent(list<Event_Speaker__c> newLst){
        list<string> eventIds=new list<string>();
        for(Event_Speaker__c  rec:newLst){
            eventIds.add(rec.Event__c);
        }
        list<Event_Speaker__c> eventSpeakerLst=[SELECT id,Event__c FROM Event_Speaker__c WHERE Event__c in:eventIds];
        system.debug(eventSpeakerLst);
        if(eventSpeakerLst.size()>0){
            for(Event_Speaker__c  rec:newLst){
                rec.Event__c.addError('Cant Select The Existing Event,Please Try Another Event');
            }
        }
        return eventSpeakerLst.size();
    }
}