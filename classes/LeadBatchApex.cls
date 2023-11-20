public class LeadBatchApex implements DataBase.Batchable<sobject>,Database.stateful{
    string message;
    string subject;
    string toAddress;
    string body;
    list<string> lst=new list<string>();
    public Database.QueryLocator start(Database.BatchableContext context){
        string qurey='SELECT Name,CreatedDate,Status FROM Lead WHERE Status=\'Open - Not Contacted\' AND CreatedDate=TODAY';
        return database.getQueryLocator(qurey);
    }
    public void execute(Database.BatchableContext context,list<sobject> scope){
        lst.add(LeadScheduledHandler.scheduledBatchUpdateLead(scope));
        body=string.join(lst,'\n');
    }
    public void finish(Database.batchableContext context){
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
        if(lst.size()>0){
            message+=body;
        }
        toAddress=userInfo.getUserEmail();
        subject='Apex Job Status of Execution';
        EmailUtility.sendEmail(toAddress,subject,message);
    }
}