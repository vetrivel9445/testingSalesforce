public class ApexBatch implements Database.Batchable<sObject>,Database.stateful{
    string message;
    string subject;
    string toAddress;
    string emailBody;
    //list<Database.Error> emailBodyLst=new list<Database.Error>();
    public list<string> resultLst=new list<string>();
    public Database.QueryLocator start(DataBase.BatchableContext context){
        string query=' SELECT Id,Email FROM Contact WHERE Email=NULL';
        return database.getQueryLocator(query);
    }
    public void execute(DataBase.BatchableContext context,list<sObject> scope){
        //ContactBatchHandler.batchApexUpdateContactEmail(scope);
        resultLst.add(ContactBatchHandler.batchApexUpdateContactEmail(scope));
         emailBody=string.join(resultLst,'\n');
        system.debug(emailBody);
    }
    public void finish(DataBase.BatchableContext context){
        AsyncApexJob jobs=[
            SELECT
            Status,JobItemsProcessed,TotalJobItems,NumberOfErrors
            FROM
            AsyncApexJob
            WHERE Id=:context.getJobId()
        ];
        system.debug(resultLst);
        system.debug(emailBody);
        message='ApexJob Status ::'+ jobs.Status+'\n';
        message+='Apex Job Items Processed ::'+jobs.JobItemsProcessed+'\n';
        message+='Apex Job Total Job Items ::'+jobs.TotalJobItems+'\n';
        message+='Apex Job Number of Errors ::'+jobs.NumberOfErrors+'\n';
        if(resultLst.size()>0){
            message+='Errors in Contact Record ::'+resultLst.size()+'\n'+emailBody;
        }
        toAddress=userInfo.getUserEmail();
        subject='Apex Job Status of Execution';
        EmailUtility.sendEmail(toAddress,subject,message);
    }
}