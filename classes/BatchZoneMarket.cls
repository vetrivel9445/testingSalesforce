public class BatchZoneMarket implements Database.Batchable<sObject>,Database.Stateful{
    string errorEmailBody;
    string toAddress;
    string subject;
    string body;   
    list<string> errorLst=new list<string>();
    public DataBase.QueryLocator start(database.BatchableContext context){
        string query='SELECT Id,Name,Market__c,Zone__c,Market_Number__c,Zone_Number__c FROM Store__c';
        query+=' WHERE Market_Number__c!=NULL AND Zone_Number__c!=NULL';
        system.debug(query);
        return database.getQueryLocator(query);
    }
    public void execute(database.BatchableContext context,list<sObject> scope){
        errorLst.add(BatchZoneMarketHandler.updateMarketZoneCode(scope));
        errorEmailBody=string.join(errorLst,'\n');
    }
    public void finish(database.BatchableContext context){
        AsyncApexJob jobLst=[
            SELECT
            Id,Status,TotalJobItems,JobItemsProcessed,NumberOfErrors
            FROM
            AsyncApexJob
            WHERE id=:context.getJobId()
        ];
        
        toAddress=userInfo.getUserEmail();
        subject= context.getJobId()+' - Scheduled Batch Abc company Job status';
        body='Scheduled Batch Abc company Job status :: '+jobLst.Status+'\n';
        body+='Total Job Items Runs :: '+jobLst.TotalJobItems+'\n';
        body+='Total Job Items Processed :: '+jobLst.JobItemsProcessed+'\n';
        body+='Total Number Of Errors in Job :: '+jobLst.NumberOfErrors+'\n';
        if(errorEmailBody!=NULL){
            body+=errorEmailBody;
        }
        system.debug(toAddress);
        system.debug(subject);
        system.debug(body);
        EmailUtility.sendEmail(toAddress,subject,body);
    }
}