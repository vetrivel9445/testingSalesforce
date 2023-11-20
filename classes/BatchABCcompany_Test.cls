@isTest
public class BatchABCcompany_Test {
    @isTest
    public static void TestBatch(){
        list<Lead> leadLst=new list<Lead>();
        for(integer i=0;i<=200;i++){
            if(i<20){
                lead ldObj=new lead();
                ldobj.LastName='test1'+i;
                ldObj.Company='abc';
                ldObj.Status='Open - Not Contacted';
                ldObj.Created_Dates__c=date.newInstance(2022,01,01);
                ldObj.Last_Modified_Dates__c=date.newInstance(2022,01,01); 
                leadLst.add(ldObj);
            }
            if(i>=20){
                lead ldObj1=new lead();
                ldobj1.LastName='test12'+i;
                ldObj1.Company='kvb';
                ldObj1.Status='Open - Not Contacted';
                ldObj1.Created_Dates__c=date.newInstance(2022,01,01);
                ldObj1.Last_Modified_Dates__c=date.newInstance(2022,05,01); 
                leadLst.add(ldObj1);
            }
        }
        insert leadLst;
        
        system.test.startTest();
        ScheduledBatchABCCompany schedulable=new ScheduledBatchABCCompany();
        string jobName='Scheduled Batch ABC Company Job';
        string cronExp='0 0 23 * * ? *';
        system.schedule(jobName, cronExp, schedulable);
        system.test.stopTest();
        
        User CheckUser=[SELECT Id,ManagerId FROM User WHERE Id=:UserInfo.getUserId()];
        lead[] compareLst=[SELECT Id,OwnerId FROM Lead WHERE OwnerId=:checkUser.ManagerId];
        AggregateResult taskCreated=[SELECT COUNT(Id) countId FROM Task WHERE OwnerId=:checkUser.ManagerId];
        
        system.assertEquals(taskCreated.get('countId'), compareLst.size(),'Error in OwnerChange');
        
    }
}