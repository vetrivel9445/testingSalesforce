public class BatchStoreHandler {
    public static list<string> updateZoneMarketMapping(list<Store__c> store){
        list<string> errorLst=new list<string>();
        set<decimal> zoneNumberLst=new set<decimal>();
        set<decimal> marketNumberLst=new set<Decimal>();
        for(Store__c sRec:store){
            zoneNumberLst.add(sRec.Zone_Number__c);//adding the zoneNumber in the set from For each store lst
            marketNumberLst.add(sRec.Market_Number__c);//adding the MarketNumber in the set from For each store lst
        }
        if(zoneNumberLst.size()>0){
            system.debug('1');
            errorLst=ZoneCheckService.checkContainsZoneNumber(marketNumberLst,zoneNumberLst,store);//calling the zone check service class
        }
        return errorLst;
    }
}