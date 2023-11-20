/*
* @Name=Test Class
* @Author=vetrivel
* @Date=29-01-2023
* @Description= trigger case study day-(2,3.0,3.1).
* *************************************
* Modification log:-
* -----------------------------------------------------
* version       Developer       Date        Description
* 0.1           vetrivel        29-01-2023  case study
* ----------------------------------------------------
*/
trigger TriggerOnAccount on Account (before insert,before Delete,after insert,after update,after delete,after undelete) {
    
    Switch on trigger.OperationType{
        
        When BEFORE_INSERT{
            //Day -2 caseStudy [when Account is created with rating 'hot' and Annual revenue is blank update annual revenue as 200000]
            AccountTriggerHandler.updateAnnualRevenue(Trigger.new);
        }
        When AFTER_INSERT{
            //3.Casestudy create account which is equal to no.of.location in account field
            AccountTriggerHandler.createContactEqlToLocation(Trigger.newmap,Trigger.new);
           // AccountTriggerHandler.CreateContactInDescription(Trigger.new,Trigger.new);
            
        }
        When AFTER_UPDATE{
            AccountTriggerHandler.createContactEqlToLocation(Trigger.oldmap,Trigger.new);
           // AccountTriggerHandler.CreateContactInDescription(Trigger.old,Trigger.new);
        }
        when BEFORE_DELETE{
            //Day -3 caseStudy [prevent Account from deletion when it has parent record Associate with it]
            AccountTriggerHandler.preventDeletePatentAccount(Trigger.old);
            //trigger casestudy -*1(calling the method from TriggerHandler class to prevent delete)
            AccountTriggerHandler.userFrmDeleteAccount(Trigger.old);
            AccountTriggerHandler.relatedOpportunity(Trigger.old);
        }
        when AFTER_DELETE{
            system.debug(AccountTriggerHandler.relatedOpportunity(Trigger.old));
            AccountTriggerHandler.deleteRelatedOpportunity(AccountTriggerHandler.relatedOpportunity(Trigger.old));
        }
        //Day -3 DIY [whenever the the deleted Account is restored we need one set of excesting Account as 
        //'parentAccount'on the restored Account]
        when AFTER_UNDELETE{
            AccountTriggerHandler.restoreParentAccount(Trigger.new);
        }
    }
}