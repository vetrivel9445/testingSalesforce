trigger TriggerOnOpportunityLineItem on OpportunityLineItem (after insert,after update,after delete) {
    Switch on Trigger.OperationType{
        WHEN AFTER_INSERT{
            opportunityLineItemTriggerHandler.opportunityLineItemFunction(Trigger.new);
        }
        WHEN AFTER_UPDATE{
            opportunityLineItemTriggerHandler.opportunityLineItemFunction(Trigger.new);
        }
        WHEN AFTER_DELETE{
            opportunityLineItemTriggerHandler.opportunityLineItemFunction(Trigger.old);
        }
    }
}