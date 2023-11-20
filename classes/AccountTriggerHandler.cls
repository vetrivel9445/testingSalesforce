public class AccountTriggerHandler {
    public static boolean isExecuted=False;
    public static set<Id> executedSet=new set<Id>();
    public static set<id> oppIds=new set<id>();
    //Day -2 DIY [when Account is created with rating 'hot' and Annual revenue is blank update annual revenue as 200000]
    public static void updateAnnualRevenue(list<Account> Accountnew){
        string rating='Hot';
        integer Amount=200000;
        for(Account accRecord:Accountnew){
            if(accRecord.Rating==rating && accRecord.AnnualRevenue==NULL){
                accRecord.AnnualRevenue=Amount;
            }
        }
    }
    //Day -3 caseStudy [prevent Account from deletion when it has parent record Associate with it]
    public static void preventDeletePatentAccount(list<Account> Accountold){
        for(Account accRecord:Accountold){
            if(accRecord.ParentId!=NULL){
                accRecord.addError('Unable to delete the Record , Account contains Parent Account');
            }
        }
    }
    //1.Casestudy prevent the user from deleting the Accounts
    public static void userFrmDeleteAccount(list<Account> AccountOld){
        string sProfile;
        list<User> userLst=[SELECT User.Profile.Name,User.ProfileId FROM User WHERE User.Profile.Name='System Administrator'];
        for(user ids:userLst){
            sProfile=ids.ProfileId ;
        }
        
        if(UserInfo.getProfileId()!=sProfile){
            for(Account rec:AccountOld){
                rec.addError('No Access to Delete the record');
            }
        }
    }
    //Day -3 DIY [whenever the the deleted Account is restored we need one set of excesting Account as 
    //'parentAccount'on the restored Account
    //4.DYI delete the Account record to restore Account record with Existing Parent Account
    public static void restoreParentAccount(list<Account> inputAcc){
        string accIds;
        list<Account> accUpdate=new list<Account>();
        list<Account> acSmap=[SELECT
                              Id 
                              FROM
                              Account 
                              LIMIT :1];
        for(Account accid:acSmap){
            accIds=accid.Id;
        }
        if(inputAcc.size()>0 && accIds!=NULL){
            for(Account recId:inputAcc){
                Account obj=new Account();
                obj.id=recId.Id;
                obj.ParentId=accIds;
                accUpdate.add(obj);
            }
        }
        if(accUpdate.size()>0){
            upsert accUpdate;
        }
    }
    //3.Casestudy create account which is equal to no.of.location in account field
    public static void createContactEqlToLocation(Map<Id,Account> accOldInput,list<Account> accInput){
        Decimal location;
        list<Contact> conUpdate=new list<Contact>();
        for(Account accId:accInput){
            location=accId.Number_of_Locations__c;
            if(location>10){
                accId.Number_of_Locations__c.addError('Enter less than 10');
            }
            else if(location>0 && (Trigger.isInsert ||accOldInput.get(accId.Id).Number_of_Locations__c!=location && Trigger.isUpdate)){
                for(integer i=0;i<accId.Number_of_Locations__c;i++){
                    Contact conObj=new Contact();
                    conObj.AccountId=accId.Id;
                    conObj.LastName='AccountRelatedCon'+i;
                    conObj.Phone='101010101'+i;
                    conUpdate.add(conObj);
                } 
            }
        }
        if(conUpdate.size()>0){
            upsert conUpdate; 
        }
    }
   /* public static void CreateContactInDescription(list<Account> oldAccLst,list<Account> accLst){
        list<string> accDesNew=new list<string>();
        list<string> accDesOld=new list<string>();
        list<string> deleteCon=new list<string>();
        list<Contact> conUpdate=new list<Contact>();
        for(Account accRec:accLst){
            accDesNew=accRec.Description.split(',');
        }
        for(Account accRec:oldAccLst){
            accDesOld=accRec.Description.split(',');
        }
        for(string des:accDesNew){
            if(!accDesold.contains(des)){
                deleteCon.add(des);
            }
        }
        list<Contact> conLst=[SELECT AccountId FROM Contact WHERE Accountid in:accLst AND Name in:deleteCon];
        if(!conLst.isEmpty() && Trigger.isUpdate &&isExecuted==false){
            isExecuted=true;
            delete conLst;
        }
        if(conLst.isEmpty() && Trigger.isupdate ||Trigger.isInsert){
            for(Account rec:accLst){
                for(string dec:accDesNew){
                    Contact obj=new Contact();
                    obj.LastName=dec;
                    obj.AccountId=rec.id;
                    obj.Phone='1010101010';
                    conUpdate.add(obj);
                }
            }
            if(!conUpdate.isEmpty() && isExecuted==false){
                isExecuted=true;
                upsert conUpdate;
            }
        } 
    }*/
    public static set<id> relatedOpportunity(list<Account> accLst){
        set<id> accId=new set<id>();
        for(Account rec:accLst){
            accId.add(rec.id);
        }
        list<Opportunity> accListQurey=[SELECT id from Opportunity WHERE AccountId in:accId];
        for(Opportunity opp:accListQurey){
            oppIds.add(opp.id);
        }
        return oppIds;
    }
    public static void deleteRelatedOpportunity(set<id> oppId){
        system.debug(oppId);
        list<Opportunity> oppLst=[SELECT id FROM Opportunity WHERE id in:oppId];
         system.debug(oppLst);
        if(!oppLst.isEmpty()){
            delete oppLst;
        }
    }
}