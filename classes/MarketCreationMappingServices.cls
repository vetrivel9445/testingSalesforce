public class MarketCreationMappingServices {
    public static Market__c marketCreation(decimal MarketNumber){
        Market__c mObj=new Market__c();
        mObj.Market_Name__c='Unknown Market';
        mObj.Market_Manager__c='peter';	 
        mObj.Market_Number__c=MarketNumber;
        mObj.Market_Description__c='There is no Market enter in the store Record';
        return mObj;
    }
    public static string MarketContainsNumberMapping(list<Decimal> marketNumberLst,list<Market__c> marketQueryLst,list<Store__c> scope){
        map<Decimal,string> marketMapContainsId=new map<Decimal,string>();
        list<String> errorLst=new list<string>();
        string errorMessages;
        if(marketQueryLst.size()>0){
            for(Market__c marketRec:marketQueryLst){
                if(marketNumberLst.contains(marketRec.Market_Number__c)){
                    marketMapContainsId.put(marketRec.Market_Number__c,marketRec.Id);
                }
            }
            for(Store__c Rec:scope){
                if(Rec.Zone__c!=NULL && Rec.Market__c==NULL && marketMapContainsId.containsKey(Rec.Market_Number__c)){
                    Rec.Market__c=marketMapContainsId.get(Rec.Market_Number__c);
                    system.debug('3.MarketContainsNumberMapping ::' +Rec);
                    system.debug('3.MarketContainsNumberMapping ::' +marketMapContainsId.get(Rec.Market_Number__c));
                }
            }
            database.SaveResult[] srResult=database.update(scope,False);
            for(database.SaveResult rslt:srResult){
                if(!rslt.isSuccess()){
                    for(Database.Error er:rslt.getErrors()){
                        errorLst.add(rslt.getId()+' - JobId ::Batch zoneMarket Job contains Error in MarketId::'+er.getMessage());
                    }
                }
            }
            errorMessages=string.join(errorLst,',');
        }return errorMessages;
    }
    public static string MarketNotContainsNumberMapping(list<Decimal> marketNumberNotContainsLst,
                                                        list<Market__c> marketQueryLst,list<Store__c> scope)
    {
        list<Market__c> marketInsertLst=new list<Market__c>();
        map<Decimal,string> marketMap=new map<Decimal,string>();
        list<String> errorLst=new list<string>();
        string errorMessages;
        if(marketNumberNotContainsLst.size()>0){
            for(Store__c storeRec:scope){
                if(storeRec.Zone__c!=NULL && storeRec.Market__c==NULL){
                    marketInsertLst.add(marketCreation(storeRec.Market_Number__c));
                }
            }
            if(marketInsertLst.size()>0){
                insert marketInsertLst;
                for(Market__c marketRec:marketInsertLst){
                    marketMap.put(marketRec.Market_Number__c,marketRec.Id);
                }
            }
            
            for(Store__c Rec:scope){
                if(Rec.Zone__c!=NULL && Rec.Market__c==NULL){
                    Rec.Market__c=marketMap.get(Rec.Market_Number__c);
                    system.debug('4.MarketNotContainsNumberMapping ::' +Rec);
                }
            }
            database.SaveResult[] srResult=database.update(scope,False);
            for(database.SaveResult rslt:srResult){
                if(!rslt.isSuccess()){
                    for(Database.Error er:rslt.getErrors()){
                        errorLst.add(rslt.getId()+' - JobId ::Batch zoneMarket Job contains Error in MarketId::'+er.getMessage());
                    }
                }
            }
        }
        errorMessages=string.join(errorLst,',');
        return errorMessages;
    }
}