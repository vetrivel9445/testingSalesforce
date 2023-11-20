public class BatchZoneMarketHandler {
    public static string updateMarketZoneCode(list<Store__c> scope){
        system.debug(scope.size());
        list<Decimal> zoneNumberNotContainsLst=new list<Decimal>();
        list<Decimal> marketNumberNotContainsLst=new list<Decimal>();
        list<Decimal> zoneNumberLst=new list<Decimal>();
        list<Decimal> marketNumberLst=new list<Decimal>();
        list<String> errorLst=new list<string>();
        string errorMessages;
        for(Store__c storeRec:scope){
            zoneNumberLst.add(storeRec.Zone_Number__c);
            marketNumberLst.add(storeRec.Market_Number__c);
        }
        if(zoneNumberLst.size()>0){
            Zone__c[] zoneQueryLst=[
                SELECT
                Id,Zone_Number__c
                FROM
                Zone__c
                WHERE Zone_Number__c in:zoneNumberLst
            ];
            for(Decimal Rec:zoneNumberLst){
                for(Zone__c zRec:zoneQueryLst){
                    if(Rec!=zRec.Zone_Number__c){
                        zoneNumberNotContainsLst.add(Rec);
                        //system.debug(zoneNumberNotContainsLst);
                    }
                }
            }
            if(marketNumberLst.size()>0){
                Market__c[] marketQueryLst=[
                    SELECT
                    Id,Market_Number__c
                    FROM
                    Market__c
                    WHERE Market_Number__c in:marketNumberLst
                ];
                for(Decimal Rec:marketNumberLst){
                    for(Market__c zRec:marketQueryLst){
                        if(Rec!=zRec.Market_Number__c){
                            marketNumberNotContainsLst.add(Rec);
                            //system.debug(marketNumberNotContainsLst);
                        }
                    }
                }
                errorLst.add(ZoneCreationMappingService.zoneContainsNumberMapping(marketNumberLst,marketQueryLst,
                                                                                  zoneNumberLst,zoneQueryLst,scope));
                
                errorLst.add(ZoneCreationMappingService.zoneNotContainsNumberMapping(zoneNumberNotContainsLst,marketNumberNotContainsLst
                                                                                     ,marketQueryLst,zoneQueryLst,scope));
            }
        }
        if(errorLst.size()>0){
            errorMessages=string.join(errorLst, '\n');
        }
        return errorMessages;
    }
}