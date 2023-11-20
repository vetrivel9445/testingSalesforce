public class LeadApexBatch implements Database.Batchable<sObject>,Database.stateful{
    string message;
    string subject;
    string toAddress;
    string emailBody;
    //list<string> emailBodyLst=new list<string>();
    list<string> resultLst=new list<string>();
    public Database.QueryLocator start(DataBase.BatchableContext context){//'Closed - Not Converted'\'Open - Not Contacted\'
        string query=' SELECT Id,CreatedDate,Status FROM Lead WHERE Status=\'Closed - Not Converted\' AND CreatedDate=LAST_N_DAYS:2';
        return database.getQueryLocator(query);
    }
    public void execute(DataBase.BatchableContext context,list<sObject> scope){
        //LeadHandler.batchApexUpdateLeadStatus(scope);
        resultLst.add(LeadHandler.batchApexUpdateLeadStatus(scope));
        if(resultLst.size()>0){
            emailBody=string.join(resultLst, '\n');
        }
        system.debug('1 ::'+emailBody);
    }
    public void finish(DataBase.BatchableContext context){
        AsyncApexJob jobs=[
            SELECT
            Status,JobItemsProcessed,TotalJobItems,NumberOfErrors
            FROM
            AsyncApexJob
            WHERE Id=:context.getJobId()
        ];
        system.debug('2'+emailBody);
        message='ApexJob Status ::'+ jobs.Status+'\n';
        message+='Apex Job Items Processed ::'+jobs.JobItemsProcessed+'\n';
        message+='Apex Job Total Job Items ::'+jobs.TotalJobItems+'\n';
        message+='Apex Job Number of Errors ::'+jobs.NumberOfErrors+'\n';
        message+='Errors in Apex Job ::'+'\n';
        toAddress=userInfo.getUserEmail();
        subject='LeadApexBatch Job Status of Execution - '+context.getJobId();
        system.debug(Limits.getEmailInvocations()+','+Limits.getCpuTime());
        system.debug('3'+toAddress+subject+message);
        //EmailUtility.sendEmail(toAddress,subject,message);
    }
}