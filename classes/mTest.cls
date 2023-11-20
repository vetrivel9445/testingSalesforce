@istest
public class mTest {
    
    @istest
    public Static void someTest(){
        lead obj=new Lead();
        obj.LastName='Test';
        obj.Company='abc';
        obj.Status='Closed - Converted';
        obj.Phone='9875642310';
        insert obj;
        
        LeadHistory leadHist = new LeadHistory();
        leadHist.LeadId=obj.id;
        leadHist.Field='Status';
        insert leadHist;
        system.debug([SELECT Id,Field,NewValue,oldValue,LeadId FROM LeadHistory]);
        system.Test.startTest();
        obj.Status='Converted';
        update obj;
        system.Test.stopTest();
        system.debug([SELECT Id,Field,NewValue,oldValue,LeadId FROM LeadHistory]);
        Integer amount=0;
        Opportunity opp=new Opportunity();
        opp.Amount=amount;
    }
}