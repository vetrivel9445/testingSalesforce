public class ZoneCreationMappingService {
    public static Zone__c zoneCreation(Decimal zoneNumber){
        Zone__c zObj=new Zone__c();
        zObj.Zone_Name__c='Unknown Zone';
        zObj.Zone_Leader__c='John';
        zObj.Zone_Number__c=zoneNumber;
        zObj.Zone_Description__c='There is no Zone enter in the store Record';
        return zObj;
    }
    public static string zoneContainsNumberMapping(list<Decimal> marketNumberLst,
                                                   list<Market__c> marketQueryLst,
                                                   list<decimal> zoneNumberLst,list<Zone__c> zoneQueryLst,list<Store__c> scope)
    {
        map<Decimal,string> zoneMapContainsId=new map<Decimal,string>();
        list<String> errorLst=new list<string>();
        string errorMessages;
        if(zoneQueryLst.size()>0){
            for(Zone__c rec:zoneQueryLst){
                if(zoneNumberLst.contains(rec.Zone_Number__c)){
                    zoneMapContainsId.put(rec.Zone_Number__c,rec.Id);
                }
            }
            for(Store__c storeRec:scope){
                if(storeRec.Zone__c==NULL && zoneMapContainsId.Containskey(storeRec.Zone_Number__c)){
                    storeRec.Zone__c=zoneMapContainsId.get(storeRec.Zone_Number__c);
                    system.debug('1.zoneContainsNumberMapping ::' +storeRec);
                }
            }
            if(zoneMapContainsId.values().size()>0){
                database.SaveResult[] srResult=database.update(scope,False);
                for(database.SaveResult rslt:srResult){
                    if(!rslt.isSuccess()){
                        for(Database.Error er:rslt.getErrors()){
                            errorLst.add(rslt.getId()+' - JobId ::Batch zoneMarket Job contains Error in ZoneId::'+er.getMessage());
                        }
                    }
                } 
            }
        }
        
        errorLst.add(MarketCreationMappingServices.MarketContainsNumberMapping(marketNumberLst,marketQueryLst,scope));
        errorMessages=string.join(errorLst,',');
        return errorMessages;
    }
    public static string zoneNotContainsNumberMapping(list<Decimal> zoneNumberNotContainsLst,list<Decimal> marketNumberNotContainsLst,
                                                      list<Market__c> marketQueryLst,list<Zone__c> zoneQueryLst,list<Store__c> scope)
    {
        map<Decimal,string> zoneMap=new map<Decimal,string>();
        list<Zone__c> zoneInsertLst=new list<Zone__c>();
        list<String> errorLst=new list<string>();
        string errorMessages;
        if(zoneNumberNotContainsLst.size()>0){
            for(Store__c storeRec:scope){
                if(storeRec.Zone__c==NULL){
                    zoneInsertLst.add(ZoneCreationMappingService.zoneCreation(storeRec.Zone_Number__c));
                }
            }
            if(zoneInsertLst.size()>0){
                insert zoneInsertLst;
                for(Zone__c rec:zoneInsertLst){
                    zoneMap.put(rec.Zone_Number__c,rec.Id);
                }
                
                for(Store__c storeRec:scope){
                    if(storeRec.Zone__c==NULL){
                        storeRec.Zone__c=zoneMap.get(storeRec.Zone_Number__c);
                        system.debug('2.zoneNotContainsNumberMapping ::' +storeRec);
                    }
                }
                database.SaveResult[] srResult=database.update(scope,False);
                for(database.SaveResult rslt:srResult){
                    if(!rslt.isSuccess()){
                        for(Database.Error er:rslt.getErrors()){
                            errorLst.add(rslt.getId()+' - JobId ::Batch zoneMarket Job contains Error in ZoneId::'+er.getMessage());
                        }
                    }
                }
            }
        }
        errorLst.add(MarketCreationMappingServices.MarketNotContainsNumberMapping(marketNumberNotContainsLst,marketQueryLst,scope));
        errorMessages=string.join(errorLst,',');
        return errorMessages;
    }
}