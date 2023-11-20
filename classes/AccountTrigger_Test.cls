@isTest
public class AccountTrigger_Test {
    @TestSetup
    public static void loadData(){
        list<Account> accLst=new list<Account>();
        for(integer i=1;i<=250;i++){
            Account acc=new Account();
            acc.Name='testTgrAccount'+i;
            accLst.add(acc);
        }
        insert accLst;
        list<Account> accDelete=[SELECT Id FROM Account LIMIT 5];
        delete accDelete;
    }
    
    Testmethod
        public static void doTestCreateContactEqlToLocation(){
            list<Account> accLstQ=[SELECT Id,Number_of_Locations__c FROM Account LIMIT 210];
            for(Account accRec:accLstQ){
                accRec.Number_of_Locations__c=1;
            }
            upsert accLstQ;
           map<Id,Account> accMap=new map<Id,Account>([SELECT Id,Name,Number_of_Locations__c From Account where Number_of_Locations__c=1]);
           list<Contact> conLst=[SELECT Id,AccountId FROM Contact where AccountId in:accMap.keySet()];
            system.debug(accLstQ.size());
            system.debug(conLst.size());
            system.assertEquals(accLstQ.size(),conLst.size(),'error');
        }
    TestMethod
        public static void doTestrestoreParentAccount(){
            list<Account> accLstQ=[SELECT Id,IsDeleted FROM Account WHERE IsDeleted=True ALL ROWS ];
                 undelete accLstQ;
            list<Account> accunDelst=[SELECT Id,ParentId FROM Account WHERE ParentId!=NULL];
            system.assertEquals(accunDelst.size(),accLstQ.size(),'error');
        }
     TestMethod
         public static void doTestNegativeSenarioRestoreParentAccount(){
             list<Account> accLstQ=[SELECT Id,ParentId FROM Account WHERE ParentId!=NULL LIMIT 5 ];
             string er;
             try{
                 delete accLstQ;
             }
             catch(Exception e){
                 system.debug(e.getMessage());
                 er=e.getMessage();
                 //syste.assertEquals(er,)
             }
         }

}