@isTest
public class EventAttendeeTrigger_Test {
    @testSetup
    public static void loadData(){
        Event__c eObj=new Event__c();
        eObj.Name__c='TestTrigger1';
        eObj.Live__c=true;
        eObj.Max_Seats__c=10;
        eObj.Start_Date__c=dateTime.newInstance(2022, 03, 01);
        eObj.End_Date__c=dateTime.now();
        insert eObj;
        Attendee__c aObj=new Attendee__c();
        aObj.Name='TestAttendee1';
        aObj.Phone__c='1010101010';
        aObj.Email__c='kvetrivel919@gmail.com';
        insert aObj;
    }
    testMethod
        public static void doTest(){
            integer returnValue;
            list<Event__c> eventLst=[SELECT Id FROM Event__c];
            list<Attendee__c> attendeeLst=[SELECT Id FROM Attendee__c];
            
            Event_Attendee__c obj=new Event_Attendee__c();
            obj.Attendee__c=attendeeLst[0].id;
            obj.Event__c=eventLst[0].id;
            obj.Name='TestAttendee1';
            insert obj;
            
            returnValue=EventAttendeeTriggerHandler.emailSent(new List<Event_Attendee__c>{obj});
            list<Event_Attendee__c> eventAttendeeLst=[SELECT Id FROM Event_Attendee__c];
            system.assertEquals(1, eventAttendeeLst.size(), 'Error in Message');
            system.assertEquals(2, returnValue, 'Error in Message');
        }
}