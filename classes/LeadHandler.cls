public class LeadHandler {
    //AsyncApex DAY =4 ,DIY-2;
    public static string batchApexUpdateLeadStatus(list<Lead> scope){
        string error;
        list<string> erLst=new list<string>();
        for(Lead ldRec:scope){
            ldRec.Status='Open - Not Contacted';
        }
            list<database.UpsertResult> srResult= database.upsert(scope,False);  
            for(database.UpsertResult rslt:srResult){
                if(!rslt.isSuccess()){
                    for(Database.Error er:rslt.getErrors()){
                        erLst.add(rslt.getId()+' - LeadId contains Error in Record :: ' +er.getMessage());
                    }
                }
            }
            if(erLst.size()>0){
                error=string.join(erLst, ',');
            }
       
        return error;
    }
}