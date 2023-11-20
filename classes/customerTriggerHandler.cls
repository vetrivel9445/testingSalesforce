public class customerTriggerHandler {
    //6.Casestudy when create customer record for account record will add to Account team
    public static void customerFunction(list<Customer__c> customerLst){
        list<string> teamRoleLst=new list<string>();
        set<Id> UserIds=new set<Id>();
        for(Customer__c cstmRec:customerLst){
            UserIds.add(cstmRec.Account_Manager__c);
        }
        Map<Id,User> userLst=new Map<Id,User>([SELECT Id,UserRole.Name
                                               FROM User
                                               WHERE Id in:UserIds]);
        list<AccountTeamMember> atmUpdate=new list<AccountTeamMember>();
        for(Customer__c rec:customerLst){
            teamRoleLst.add(rec.Account_Manager__c);
            AccountTeamMember obj=new AccountTeamMember(); 
            obj.AccountId=rec.Account__c;
            obj.UserId=rec.Account_Manager__c;
            obj.TeamMemberRole=userLst.get(rec.Account_Manager__c).UserRole.Name;
            atmUpdate.add(obj);
        }
        
        if(atmUpdate.size()>0){
            upsert atmUpdate;
        }
    }
}