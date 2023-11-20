public class ZoneCheckService {
    public static list<string> checkContainsZoneNumber(set<decimal> marketNumberLst,set<decimal> zoneNumberLst,list<Store__c> store){
        list<string> errorLst=new list<string>();
        Map<Decimal,string> containsZoneNumberMap=new Map<Decimal,string>();
        list<Decimal> notContainsZoneNumberLst=new list<Decimal>();
        list<Zone__c> zoneQueryLst=[SELECT
                                    id,Zone_Number__c
                                    FROM
                                    Zone__c
                                    WHERE Zone_Number__c in:zoneNumberLst];
       
        for(Zone__c sRec:zoneQueryLst){
            containsZoneNumberMap.put(sRec.Zone_Number__c,sRec.Id);//containsZoneNumberMap contains zone number with zone Id
        }
        for(Decimal Rec:zoneNumberLst){
            if(!containsZoneNumberMap.containskey(Rec)){//zoneQueryLst not contains zoneNumberLst will add to notContainsZoneNumberLst
                notContainsZoneNumberLst.add(Rec);
                system.debug('2::'+notContainsZoneNumberLst.Size());
            }
        }
        system.debug('4:: ZoneCreation'+notContainsZoneNumberLst.size());
        if(notContainsZoneNumberLst.size()>0){
            system.debug('4:: ZoneCreation'+notContainsZoneNumberLst.size());
            zoneCreationService.zoneCreation(marketNumberLst,notContainsZoneNumberLst,store);//call zoneCreationservice class if zoneId not conatin
        }
        if(containsZoneNumberMap.size()>0){
            system.debug('5:: ZoneCreation'+containsZoneNumberMap.size());//call zoneCreationservice class if zoneId conatin
            errorLst=zoneCreationService.zoneNumberMapping(marketNumberLst,containsZoneNumberMap,store);
        }
        return errorLst;
    }
}