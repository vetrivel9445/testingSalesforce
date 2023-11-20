public class EventAttendeeTriggerHandler {
    public static integer emailSent(list<Event_Attendee__c> newLst){
        list<string> idsLst=new list<string>();
        list<string> addressLst=new list<string>();
        for(Event_Attendee__c rec:newLst){
            idsLst.add(rec.Attendee__c);
        }
        list<Attendee__c> attendeeLst=[SELECT id,Email__c FROM Attendee__c WHERE id in:idsLst];
        for(Attendee__c rec:attendeeLst){
            addressLst.add(rec.Email__c);
        }
        string subject='Pass for the “ Event name Here”';
        string body='Dear Attendee Name,Thank you for registering for “ Event Name Here” which will be Organized on</n>';
        body=body+'“ Event Date Here ” & will be held in“Event Location Here”. We are excited to have you, see you in the event.</n>';
        body=body+'Find the Google Map Location for the Event Here.</n>';
        body=body+'Thanks,</n>“Organizer Name Here”';
        messaging.SingleEmailMessage message=new messaging.SingleEmailMessage();
        message.toaddresses=addressLst;
        message.subject=subject;
        message.plaintextbody=body;
       	list<messaging.SingleEmailMessage> messageLst=new list<messaging.SingleEmailMessage>{message};
        messaging.sendEmail(messageLst);
        return Limits.getEmailInvocations();
    }
}