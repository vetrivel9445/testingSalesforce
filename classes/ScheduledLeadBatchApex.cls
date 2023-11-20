public class ScheduledLeadBatchApex implements Schedulable{
    public void Execute(SchedulableContext context){
        Database.executeBatch(new LeadBatchApex());
    }
}