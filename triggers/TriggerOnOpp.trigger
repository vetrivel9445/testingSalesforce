/*
* @Name=Test Class
* @Author=vetrivel
* @Date=29-01-2023
* @Description= trigger case study day-(2,3.2).
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		29-01-2023	case study
* ----------------------------------------------------
*/
trigger TriggerOnOpp on Opportunity (after insert) {
    //Day -2,3.2 caseStudy [when opportunity is created ,update the highest opportunity value in the Account Record]
    Switch on trigger.OperationType{
        WHEN AFTER_INSERT{
            opportunityTriggerHandler.updateHighestValue(Trigger.new);
        }    
    }
}