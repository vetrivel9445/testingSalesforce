trigger TriggerOnContactRelationship on Contact_Relationship__c (after Update) {
    switch on Trigger.OperationType{
        when AFTER_UPDATE{
            contactRelationshipTriggerHandler.contactRelationshipOwnerChaange(Trigger.new,Trigger.oldmap);
        }
    }
}