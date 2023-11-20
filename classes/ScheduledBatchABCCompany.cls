public class ScheduledBatchABCCompany implements Schedulable {
    public void Execute(schedulableContext context){
        database.executeBatch(new BatchABCcompany());
    }
}