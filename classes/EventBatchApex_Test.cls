@isTest
public class EventBatchApex_Test {
    @testSetup
    public static void LoadTest(){
        list<Event__c> eventLst=new list<Event__c>();
        for(integer i=0;i<200;i++){
            Event__c obj=new Event__c();
            obj.Name__c='TestEventBatch'+i;
            obj.Start_Date__c=datetime.newInstance(2022, 2, 2);
            obj.End_Date__c=dateTime.newInstance(2022, 03, 01);
            obj.Max_Seats__c=10;
            obj.Live__c=false;
            eventLst.add(obj);
        }
        if(eventLst.size()>0){
            insert eventLst;
        }
    }
    testMethod
        public static void doTest(){
            EventBatchApex batch=new EventBatchApex();
            Id batchId=dataBase.executeBatch(batch);
            list<Event__c> eventLst=[SELECT id FROM Event__c];
            system.assertEquals(200,eventLst.size() ,'Error in Deletion');
        }
}