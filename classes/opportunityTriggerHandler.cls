public class opportunityTriggerHandler {
    //Day -2,3.2 caseStudy [when opportunity is created ,update the highest opportunity value in the Account Record]
    public static void updateHighestValue(list<Opportunity> oppLstnew){
        string oldId;
        string accId;
        decimal maxAmount;
        for(Opportunity oppId:oppLstnew){
            oldId=oppId.AccountId;
        }
        list<Account> accUpdate=new list<Account>();
        list<AggregateResult> oppLst=[
            SELECT
            max(Amount) mAmount,AccountId
            FROM
            Opportunity
            WHERE AccountId=:oldId
            GROUP BY AccountId
        ];
        if(oppLst.size()>0){
            for(AggregateResult opRec:oppLst){
                Account accobj=new Account();
                accobj.Id=(string)opRec.get('AccountId');
                accobj.AnnualRevenue=(Decimal)opRec.get('mAmount');
                accUpdate.add(accobj);
            }
            upsert accUpdate;
        }
    }
    
}