trigger TriggerOnContact on Contact (before delete,after insert,after delete,after undelete) {
    Switch on Trigger.OperationType{
        when AFTER_INSERT{
            contactTriggerHandler.countOfContacts(Trigger.New);//trigger casestudy -*2(calling the method from TriggerHandler class to count contacts)
            contactTriggerHandler.contactRelationshipUpsert(Trigger.new);
            contactTriggerHandler.FutureCountContacts(Trigger.new);
        }
        when AFTER_UNDELETE{
            contactTriggerHandler.countOfContacts(Trigger.New);
            contactTriggerHandler.contactRelationshipUndelete(Trigger.New);
            contactTriggerHandler.FutureCountContacts(Trigger.new);
        }
        when AFTER_DELETE{
            contactTriggerHandler.countOfContacts(Trigger.old);//trigger casestudy -*2(calling the method from TriggerHandler class to count contacts)
        }
        when BEFORE_DELETE{
            contactTriggerHandler.contactRelationshipUndelete(Trigger.old);
        }
    }
}