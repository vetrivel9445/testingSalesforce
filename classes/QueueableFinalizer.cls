public class QueueableFinalizer implements Finalizer {
    string toAddress;
    string subject;
    string body;
    string errorMessage;
    string errorJobId;
    public void execute(FinalizerContext context){
        switch on context.getResult(){
            when SUCCESS{
                system.debug('ApexJob Done :' +context.getAsyncApexJobId());
            }
            when UNHANDLED_EXCEPTION{
                system.debug('Error in ApexJob :' +context.getAsyncApexJobId());
                system.debug('Error of ApexJob :' +context.getException());
                errorMessage=context.getException()+':'+context.getResult()+','+context.getResult();
                errorJobId=context.getAsyncApexJobId();
           
                
                email();
            }
        }
    }
    public void email(){
        toAddress=userinfo.getUserEmail();
        subject='Error In Job';
        body='error on job::'+errorMessage;
        EmailUtility.sendEmail(toAddress,subject,body);
    }

}