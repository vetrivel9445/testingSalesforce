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
public class customerProjectTriggerHandler {
    //4.Casestudy when create the customer project record with status Active update opportunity checkbox istrue
    public static void createCustomerProject(list<Customer_Project__c> cpInput){
        string status;
        string aStatus='Active';
        string oppId;
        boolean checkbox=true;
        list<Opportunity> oppLst=new list<Opportunity>();
        for(Customer_Project__c cpIds:cpInput){
            status=cpIds.Status__c;
            oppId=cpIds.Opportunity__c;
            if(status==aStatus && oppId!=NULL){
                Opportunity oppObj=new Opportunity();
                oppObj.Id=oppId;
                oppObj.Active_Customer_Project__c=checkbox;
                oppLst.add(oppObj);
            }
        }
        if(oppLst.size()>0){
            upsert oppLst;
        }
    }
}