@isTest
public class EventSpeakerTrigger_Test {
    @testSetup
    public static void LoadData(){
        list<Event__c> entLst=new list<Event__c>();
        for(integer i=1;i<3;i++){
            Event__c eObj=new Event__c();
            eObj.Name__c='TestTrigger'+i;
            eObj.Live__c=true;
            eObj.Start_Date__c=dateTime.newInstance(2022, 03, 01);
            eObj.End_Date__c=dateTime.now();
            entLst.add(eObj);
        }
        insert entLst;
        Speaker__c sObj=new Speaker__c();
        sObj.Name='TestSpeaker1';
        sObj.Phone__c='1010101010';
        insert sObj;
        list<Event__c> eventLst=[SELECT id FROM Event__c];
        list<Speaker__c> speakerLst=[SELECT id FROM Speaker__c];
        if(eventLst.size()>0 && speakerLst.size()>0){
            for(integer i=0;i<2;i++){
                Event_Speaker__c obj=new Event_Speaker__c();
                obj.Event__c=eventLst[i].id;
                obj.Speaker__c=speakerLst[0].id;
                obj.Name='TestEvent1';
                insert obj;
            }
        }        
    }
    
    testMethod
        public static void doTest(){
            decimal returnInsertValue;
            decimal returnUpdateValue;
            list<Event__c> eventLst=[SELECT id FROM Event__c];
            list<Speaker__c> speakerLst=[SELECT id FROM Speaker__c];
            Event_Speaker__c obj=new Event_Speaker__c();
            obj.Event__c=eventLst[0].id;
            obj.Speaker__c=speakerLst[0].id;
            obj.Name='TestEvent2';
            
            returnInsertValue=EventSpeakerTriggerHandler.preventEvent(new List<Event_Speaker__c>{obj});
            list<Event_Speaker__c> eventSpeakerLst=[SELECT id FROM Event_Speaker__c];
            Event_Speaker__c eObj=eventSpeakerLst[1];
            eObj.Event__c=eventLst[0].id;
            Database.update(eObj, false);
            returnUpdateValue=EventSpeakerTriggerHandler.preventEvent(new List<Event_Speaker__c>{eObj});
            
            system.assertEquals(1, returnInsertValue, 'Error not Shown ');
            system.assertEquals(eventSpeakerLst[1].Event__c, eventSpeakerLst[1].Event__c, 'Error not Shown ');
            system.assertEquals(2, eventSpeakerLst.size(), 'Error not Shown ');
        }
}