public class MarketCheckService {
    public static list<string> checkContainsMarketNumber(set<decimal> marketNumberLst,list<Store__c> store){
        list<string> errorLst=new list<string>();
        Map<Decimal,string> containsMarketNumberMap=new Map<Decimal,string>();
        list<Decimal> notContainsMarketNumberLst=new list<Decimal>();
        list<Market__c> marketQueryLst=[SELECT
                                        id,Market_Number__c
                                        FROM
                                        Market__c
                                        WHERE Market_Number__c in:marketNumberLst];
        for(Market__c mRec:marketQueryLst){
            containsMarketNumberMap.put(mRec.Market_Number__c,mRec.Id);
        }
        for(Decimal mRec:marketNumberLst){
            if(!containsMarketNumberMap.containsKey(mRec)){
                notContainsMarketNumberLst.add(mRec);
            }
        }
        system.debug('9:: market Class'+notContainsMarketNumberLst.Size());
        if(notContainsMarketNumberLst.size()>0){
            system.debug('11:: market Class notContainsMarketNumberLst');
            MarketCreationService.marketCreation(notContainsMarketNumberLst,store);
        }
        if(containsMarketNumberMap.size()>0){
            system.debug('12:: market Class containsMarketNumberMap');
            errorLst=MarketCreationService.marketNumberMapping(containsMarketNumberMap,store);
        }
        return errorLst;
    }
}