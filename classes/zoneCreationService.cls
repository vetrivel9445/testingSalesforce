public class zoneCreationService {
    public static void zoneCreation(set<decimal> marketNumberLst,list<Decimal> withoutIdZoneNumberLst,list<Store__c> store){
        Map<Decimal,string> createdZoneMap=new Map<Decimal,string>();
        list<Zone__c> zoneLst=new list<Zone__c>();
        if(withoutIdZoneNumberLst.size()>0){
            for(integer i=0;i<withoutIdZoneNumberLst.size();i++){
                Zone__c zObj=new Zone__c();
                zObj.Zone_Name__c='Unknown Zone'+i;
                zObj.Zone_Leader__c='John';
                zObj.Zone_Number__c=withoutIdZoneNumberLst[i];
                zObj.Zone_Description__c='There is no Zone enter in the store Record';
                zoneLst.add(zObj);
            }
            system.debug('6:: ZoneCreation size::'+zoneLst.size());
            if(zoneLst.size()>0){
                insert zoneLst;
                for(Zone__c zRec:zoneLst){
                    system.debug('6.1:: ZoneCreation'+zRec.Id);
                    createdZoneMap.put(zRec.Zone_Number__c,zRec.Id);
                }
            }
        }
        if(createdZoneMap.keyset().size()>0){
            system.debug('6.2:: ZoneCreation'+createdZoneMap.keyset().size());
            zoneNumberMapping (marketNumberLst,createdZoneMap,store);
        }
    }
    public static list<string> zoneNumberMapping(set<decimal> marketNumberLst,Map<Decimal,string> zoneMappingMap,list<Store__c> store){
        list<string> errorLst=new list<string>();
        for(Store__c sRec:store){
            if(zoneMappingMap.containskey(sRec.Zone_Number__c)){
                system.debug('7:: Zoneinsert'+zoneMappingMap.get(sRec.Zone_Number__c));
                sRec.Zone__c=zoneMappingMap.get(sRec.Zone_Number__c);
            }
        }
        database.SaveResult[] srResult=database.update(store, false);
        for(database.SaveResult rslt:srResult){
            for(database.Error er:rslt.getErrors()){
                errorLst.add(rslt.getId()+'Batch Store Job Zone contains Error:: '+er.getMessage());
            }
        }
        if(marketNumberLst.size()>0){
            system.debug('8:: market Class');
            errorLst=MarketCheckService.checkContainsMarketNumber(marketNumberLst,store);
        }
        return errorLst;
    }
}