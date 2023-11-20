@isTest
public class BatchStore_Test {
    @TestSetup
    public static void loadData(){
        list<Market__c> MarketLst=new list<Market__c>();
        list<Store__c> storeLst=new list<Store__c>();
        list<Zone__c> zoneLst=new list<Zone__c>();
        for(integer i=0;i<=100;i++){
            if(i>50 && i<75){
                Zone__c zObj=new Zone__c();
                zObj.Zone_Name__c='TestDataZone:America'+i;
                zObj.Zone_Number__c=6100+i;
                zoneLst.add(zObj);
            }
            if(i<50){
                Market__c mObj=new Market__c();
                mObj.Market_Name__c='TestDataMarket:America'+i;
                mObj.Market_Number__c=1100+i;
                MarketLst.add(mObj);
            }
        }
        for(integer i=0;i<150;i++){
            Store__c obj=new Store__c();
            obj.Name='TestData'+i;
            obj.Market_Number__c=1100+i;
            obj.Zone_Number__c=6100+i;
            obj.Open_date__c=Date.newInstance(2023,01,01);
            storeLst.add(obj);
        }
        insert zoneLst;
        insert MarketLst;
        insert storeLst;
    }
    
    TestMethod
        public static void doTest(){
            system.Test.startTest();
            BatchStore batchable=new BatchStore();
            Id batchId=Database.executeBatch(batchable);
            system.Test.stopTest();
            AggregateResult noZoneMarketLst=[SELECT COUNT(Id) countIds FROM Store__c WHERE Zone__c=NULL AND Market__c=NULL];
            AggregateResult noMarketLst=[SELECT COUNT(Id) countIds FROM Store__c WHERE Zone__c!=NULL AND Market__c=NULL];
            AggregateResult noStoreLst=[SELECT COUNT(Id) countIds FROM Store__c WHERE Zone__c!=NULL AND Market__c!=NULL];
            system.assertEquals(noStoreLst.get('countIds'),150,'Error in Update');
            system.assertEquals(noZoneMarketLst.get('countIds'),0,'Error in Update of zoneId');
            system.assertEquals(noMarketLst.get('countIds'),0,'Error in Update of MarketId');
            
        }  
}