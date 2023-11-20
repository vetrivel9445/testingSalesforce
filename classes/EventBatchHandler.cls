public class EventBatchHandler {
    public static string deleteEvent(list<Event__c> eventLst){
        string message;
        list<database.DeleteResult> dResult=dataBase.delete(eventLst, false);
        for(database.DeleteResult rslt:dResult){
            if((rslt.getErrors()).size()>0){
                for(Database.Error er:rslt.getErrors()){
                    message='In Record deletion Contains Error of'+er.getMessage();
                }
            }
        }
        return message;
    }
}