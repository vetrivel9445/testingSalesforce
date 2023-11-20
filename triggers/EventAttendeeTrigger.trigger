trigger EventAttendeeTrigger on Event_Attendee__c (before insert) {
    Switch on Trigger.operationType{
        when BEFORE_INSERT{
            EventAttendeeTriggerHandler.emailSent(Trigger.new);
        }
    }
}