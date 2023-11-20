public class ErrorLogUtility {
    public static void errorUpdate(String processName,string message){
        list<Error_Log__c> errorLst=new list<Error_Log__c>();
        Error_Log__c obj=new Error_Log__c();
        obj.Process_Name__c=processName;
        obj.Log_Date__c=datetime.now();
        obj.Log_Deatils__c=message;
        insert obj;
    }

}