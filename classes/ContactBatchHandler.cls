public class ContactBatchHandler {
    //AsyncApex DIY-1;
    public static String batchApexUpdateContactEmail(list<Contact> scope){
        String error;
        list<string> errorLst=new list<string>();
        for(Contact conRec:scope){
            conRec.Email=userInfo.getUserEmail();
        }
        list<database.SaveResult> srResult= database.update(scope,False);
        for(database.SaveResult result:srResult){
            if(!result.isSuccess()){
                for(Database.Error er:result.getErrors()){
                    errorLst.add(result.getId()+'- Contact RecordId Contains Error ::'+er.getMessage());
                }
            }
        }
        if(errorLst.size()>0){
            error=string.join(errorLst,'\n');
        }
        return error;
    }
}