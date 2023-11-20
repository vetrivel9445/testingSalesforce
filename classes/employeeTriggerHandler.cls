/*
* @Name=Test Class
* @Author=vetrivel
* @Date=29-01-2023
* @Description= trigger case study day.
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		29-01-2023	case study
* ----------------------------------------------------
*/
public class employeeTriggerHandler {
    public static void empDeleteSetFalse(list<Employee__c> empLstOld){
        list<Account> accUpsert=new list<Account>();
        list<AggregateResult> employeeList=[
            SELECT
            COUNT(Id) empIds,Account_Name__c
            FROM
            Employee__c
            WHERE Account_Name__c!=NULL AND Id in:empLstOld
            GROUP BY Account_Name__c
        ];
        if(employeeList.size()>0){
            for(AggregateResult empRecord:employeeList){
                if((integer)empRecord.get('empIds')==1){
                    Account objAcc=new Account();
                    objAcc.Id=(string)empRecord.get('Account_Name__c');
                    objAcc.Active__c='False';
                    accUpsert.add(objAcc);
                }
            } 
        }
        if(Trigger.isdelete && accUpsert.size()>0){
            upsert accUpsert;
        }
    }
}