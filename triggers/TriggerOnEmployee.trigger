/*
* @Name=Test Class
* @Author=vetrivel
* @Date=29-01-2023
* @Description= trigger case study day-(3.3).
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		29-01-2023	case study
* ----------------------------------------------------
*/
trigger TriggerOnEmployee on Employee__c (before delete) {
    //Day -3.3 caseStudy [when All employee record is deleted set Account active As False]
    Switch on trigger.OperationType{
        WHEN BEFORE_DELETE{
            employeeTriggerHandler.empDeleteSetFalse(Trigger.old);
        }
    }
}