public class EventBatchApex implements Database.Batchable<sObject>{
    string error;
    string message;
    string toAddress;
    string subject;
    
    public database.QueryLocator start(Database.BatchableContext context){
        string query='SELECT id,End_Date__c,Live__c FROM Event__c WHERE End_Date__c<LAST_N_DAYS:20 AND Live__c=False';
        return database.getQueryLocator(query);
    }
    public void execute(database.BatchableContext context,list<Event__c> scope){
        error=EventBatchHandler.deleteEvent(scope);
    }
    public void finish(database.BatchableContext context){
        AsyncApexJob jobs=[
            SELECT
            Status,JobItemsProcessed,TotalJobItems,NumberOfErrors
            FROM
            AsyncApexJob
            WHERE Id=:context.getJobId()
        ];
        message='ApexJob Status ::'+ jobs.Status+'\n';
        message+='Apex Job Items Processed ::'+jobs.JobItemsProcessed+'\n';
        message+='Apex Job Total Job Items ::'+jobs.TotalJobItems+'\n';
        message+='Apex Job Number of Errors ::'+jobs.NumberOfErrors+'\n';
        message+='Errors in Apex Job ::'+'\n';
        toAddress=userInfo.getUserEmail();
        subject='EventBatchApex Job Status of Execution - '+context.getJobId();
        EmailUtility.sendEmail(toAddress,subject,message);
    }
}