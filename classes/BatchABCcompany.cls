public class BatchABCcompany implements database.Batchable<sobject>,DataBase.Stateful {
    list<string> errorLst=new list<string>();
    string errorEmailBody;
    string toAddress;
    string subject;
    string body;    
    public  Database.QueryLocator start(Database.BatchableContext context){
        string query='SELECT Id,Days_Since_Last_Activity__c,OwnerId'; 
        query+=' FROM Lead WHERE Days_Since_Last_Activity__c>5';
        system.debug(Database.query(query));
        return database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext context,list<sobject> scope){
        errorLst.add(ABCCompanyHandler.updateSalesRepToManager(scope));
        errorEmailBody=string.join(errorLst, '\n');
        system.debug(errorEmailBody);
    }
    public void finish(Database.BatchableContext context){
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
        //system.debug(toAddress);
        //system.debug(subject);
        system.debug(body);
        EmailUtility.sendEmail(toAddress,subject,body);
    }

}