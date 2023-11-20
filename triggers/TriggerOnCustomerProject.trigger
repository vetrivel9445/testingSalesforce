trigger TriggerOnCustomerProject on Customer_Project__c (after insert,after update) {
    switch on Trigger.OperationType{
        when AFTER_INSERT{
            customerProjectTriggerHandler.createCustomerProject(Trigger.new);
        }
        when AFTER_UPDATE{
           customerProjectTriggerHandler.createCustomerProject(Trigger.new); 
        }
    }
}