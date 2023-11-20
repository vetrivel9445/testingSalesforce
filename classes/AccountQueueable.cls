public class AccountQueueable implements Queueable{
    public void execute(QueueableContext context){
        QueueableFinalizer qObj=new QueueableFinalizer();
        system.attachFinalizer(qObj);
        list<Account> delaccLst=new list<Account>();
        DateTime Mydate=DateTime.now();
        list<Account> accLst=[
            SELECT
            Id
            FROM
            Account
            WHERE CreatedDate <:Mydate.addDays(-10)
            ORDER BY CreatedDate DESC
            LIMIT 10
        ];
        for(Account accRec:accLst){
            delaccLst.add(accRec);
        }
        if(delaccLst.size()>0){
            system.debug('deleted records::' +delaccLst.size());
            system.debug('Account record deleted before a day');
            system.debug(context.getJobId());
            delete delaccLst;
        }
    }
}