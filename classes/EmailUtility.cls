public class EmailUtility {
    
    public static void sendEmail(string toAddress,string subject,string body){
        messaging.SingleEmailMessage message=new  messaging.SingleEmailMessage();
        message.toaddresses=new list<string>{toAddress};
        message.subject=subject;
        message.plaintextbody=body;
        list<messaging.SingleEmailMessage> messageLst=new list<messaging.SingleEmailMessage>{message};
        messaging.sendEmail(messageLst);
        
    }
}