public class ABCCompanyHandler {
    public static string updateSalesRepToManager(List<Lead> scope){
        string ErrorMessages;
        Database.SaveResult[] srUpdate;
        Database.SaveResult[] srInsert;
        system.debug(scope.size());
        list<Task> taskLst=new list<Task>();
        list<string> errorLst=new list<string>();
        set<Id> LeadOwnerIds=new set<Id>();
        for(Lead ld:scope){
            LeadOwnerIds.add(ld.OwnerId);
        }
        Map<id,User> userLst=new Map<Id,User>([SELECT Id,ManagerId FROM User WHERE id in:LeadOwnerIds]);
        system.debug(userLst);
        for(Lead ld:scope){
            ld.OwnerId=userLst.get(ld.OwnerId).ManagerId;
            system.debug(ld.Id);
            Task obj=new Task();
            obj.OwnerId=ld.OwnerId;
            obj.WhoId=ld.Id;
            obj.Status='Not Started';
            obj.Subject='Other';
            taskLst.add(obj);
        }
        try{
            if(tasklst.size()>0){
                srUpdate=DataBase.update(scope, False);
                srInsert=DataBase.insert(tasklst, False);
                for(Database.SaveResult rslt:srInsert){
                    for(DataBase.Error er: rslt.getErrors()){
                        errorLst.add('Error jobId : '+rslt.getId()+'\n'+'Batch ABC company Job contains Error'+er.getMessage()+'\n');
                    }
                }
                for(Database.SaveResult rslt:srUpdate){
                    for(DataBase.Error er: rslt.getErrors()){
                        errorLst.add('Error jobId : '+rslt.getId()+'\n'+'Batch ABC company Job contains Error'+er.getMessage()+'\n');
                    }
                }
            }
        }
        catch(Exception er){
            errorLst.add('Batch ABC company Job contains Error'+er.getMessage()+'\n'+'Cause of job : '+er.getCause());
        }
        if(errorLst.size()>0){
            errorMessages=string.join(errorLst, ',');
        }
        return errorMessages;
    }
    
}