public class MarketCreationService {
    public static void marketCreation(list<Decimal> withoutIdMarketNumberLst,list<Store__c> store){
        Map<Decimal,string> createdMarketMap=new Map<Decimal,string>();
        list<Market__c> marketLst=new list<Market__c>();
        if(withoutIdMarketNumberLst.size()>0){
            for(integer i=0;i<withoutIdMarketNumberLst.size();i++){
                Market__c mObj=new Market__c();
                mObj.Market_Name__c='Unknown Market'+i;
                mObj.Market_Manager__c='peter';	 
                mObj.Market_Number__c=withoutIdMarketNumberLst[i];
                mObj.Market_Description__c='There is no Market enter in the store Record';
                marketLst.add(mObj);
            }
            
            if(marketLst.size()>0){
                insert marketLst;
                for(Market__c mRec:marketLst){
                    createdMarketMap.put(mRec.Market_Number__c,mRec.Id);
                }
                system.debug('13:: market creation'+createdMarketMap);
            }
        }
        marketNumberMapping(createdMarketMap,store);
    }
    public static list<string>   marketNumberMapping(Map<Decimal,string> containsMarketNumberMap,list<Store__c> store){

        list<string> errorLst=new list<string>();
        for(Store__c sRec:store){
            if(containsMarketNumberMap.containsKey(sRec.Market_Number__c)&& sRec.Market__c==NULL &&sRec.Market_Number__c!=NULL&&sRec.Zone__c!=NULL){
                sRec.Market__c=containsMarketNumberMap.get(sRec.Market_Number__c);
                 system.debug('14:: market insert:'+sRec);
            }
        }
        database.SaveResult[] srResult=database.update(store, false);
        for(database.SaveResult rslt:srResult){
            for(database.Error er:rslt.getErrors()){
                errorLst.add(rslt.getId()+'Batch Store Job Market contains Error:: '+er.getMessage());
            }
        }
        return errorLst;
    }
}