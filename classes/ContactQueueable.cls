public class ContactQueueable implements Queueable{
    //string successResult;
    string errorResult;
    string toAddress;
    string subject;
    string body;   
    list<string> errorRecLst=new list<string>();
    public void Execute(QueueableContext context){
        QueueableFinalizer qObj=new QueueableFinalizer();
        system.attachFinalizer(qObj);
        list<Contact> delConLst=new list<Contact>();
        DateTime Mydate=DateTime.now();
        list<Contact> conLst=[
            SELECT
            Id,CreatedDate
            FROM
            Contact
            WHERE CreatedDate <LAST_N_DAYS:10 
            ORDER BY CreatedDate 
            LIMIT 10
        ];
        system.debug(conLst);
        for(Contact conRec:conLst){
            delConLst.add(conRec);
        }
        if(delconLst.size()>0){
            system.debug('deleted records::' +delconLst.size());
            system.debug('Contact record deleted before a Day');
            system.debug(context.getJobId());
            //delete delConLst;
            list<Database.deleteResult> sresult= dataBase.delete(delConLst,false);
            for(Database.deleteResult rlt:sresult){
                if(rlt.isSuccess()){
                    system.debug('job deleted record'+rlt.getId());
                    //successResult='job deleted record'+rlt.getId();
                }
                else{
                    for(DataBase.Error er:rlt.errors){
                        errorRecLst.add(rlt.getId());
                        errorResult='jobId deleted with error ::'+rlt.getId()+ '<n/>' +'job deleted with error ::'+er.getMessage();
                    }        
                }
            }
        }
        system.enqueueJob(new AccountQueueable());
        //email();
    }
    /*
    public void email(){
        toAddress=userinfo.getUserEmail();
        subject='Error In AsyncJob';
        body=errorResult;
        EmailUtility.sendEmail(toAddress,subject,body);
    }*/
}