public class BatchStore implements database.Batchable<sObject>,database.stateful{
    string errorEmailBody;
    string toAddress;
    string subject;
    string body;   
    list<string> errorLst=new list<string>();
    public database.QueryLocator start(database.BatchableContext context){
        string query='SELECT Id,Name,Market__c,Zone__c,Market_Number__c,Zone_Number__c FROM Store__c WHERE ';
        query+='Market_Number__c!=NULL OR Zone_Number__c!=NULL';
        return database.getQueryLocator(query);   
    }
    public void execute(database.BatchableContext context,list<sObject> store){
        errorLst=BatchStoreHandler.updateZoneMarketMapping(store);
        errorEmailBody=string.join(errorLst, '\n');
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
        subject= context.getJobId()+' - Batch Store Job status';
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