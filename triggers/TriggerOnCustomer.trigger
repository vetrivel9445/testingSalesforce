trigger TriggerOnCustomer on Customer__c (after insert) {
    switch on Trigger.OperationType{
        when AFTER_INSERT{
            customerTriggerHandler.customerFunction(Trigger.new);
        }
    }
}