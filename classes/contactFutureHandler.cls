public class contactFutureHandler {
    @future
    public static void countOfContactsFuture(string recIds){
        list<Id> accRecIds=recIds.split(',');
        list<Account> accUpdate=new list<Account>();
        list<AggregateResult> conLst=[
          SELECT
            COUNT(Id) conCount,AccountId
            FROM
            Contact
            WHERE AccountId in:accRecIds
            GROUP BY AccountId
        ];
        for(AggregateResult conRec:conLst){
            Account accobj=new Account();
            accObj.Id=(string)conRec.get('AccountId');
            accObj.Number_of_Contacts__c=(Decimal)conRec.get('conCount');
            accUpdate.add(accObj);
        }
        if(accUpdate.size()>0){
            upsert accUpdate;
        }
    }
}