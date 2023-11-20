trigger EventSpeakerTrigger on Event_Speaker__c (before insert,before Update) {
    Switch on Trigger.operationType{
        When BEFORE_INSERT{
            EventSpeakerTriggerHandler.preventEvent(Trigger.new);
        }
        when BEFORE_UPDATE{
            EventSpeakerTriggerHandler.preventEvent(Trigger.new);
        }
    }
}