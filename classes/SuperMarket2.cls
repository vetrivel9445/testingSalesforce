public class SuperMarket2 {
    Map<Id,list<Opportunity>> oppMap=new Map<Id,list<Opportunity>>();
    
    public void display(){
        list<Opportunity> opplst=[
            SELECT
            Id,Name,AccountId
            FROM
            Opportunity
            WHERE AccountId!=NULL
        ];  
        for(Opportunity op : opplst)
        {
            if(!oppMap.containsKey(op.AccountId))
            {
                oppMap.put(op.AccountId,new list<Opportunity>{op});
            }
            else
            {
                oppMap.get(op.AccountId).add(op);
            }
        }
        for(Id lst:oppMap.keySet()){
            system.debug(lst);
            system.debug(oppMap.get(lst));
        }
    } 
}