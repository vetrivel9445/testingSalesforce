public class contactTriggerHandler {
    //2.Casestudy count of contact is updated in Account object
    public static void countOfContacts(List<Contact>accLst){
        set<Id> AccOldIds=new set<Id>();
        for(Contact oldId:accLst){
            AccOldIds.add(oldId.AccountId);
        }
        if(AccOldIds.size()>0){
            list<AggregateResult> conList=[
                SELECT
                COUNT(Id) idNo,AccountId
                FROM
                Contact
                WHERE AccountId in:AccOldIds
                GROUP BY AccountId
            ];
            list<Account> accUpdate=new list<Account>();
            for(AggregateResult conRec:conList){
                Account acc=new Account();
                acc.Id=(string)conRec.get('AccountId');
                acc.Count_of_Contacts__c=(integer)conRec.get('idNo');
                accUpdate.add(acc);
            }
            upsert accUpdate;
        }
    }
    //5.1,2-Casestudy when create contact relationship record with checkbox is true create contact for it
    public static void contactRelationshipUpsert(list<Contact> conInput){
        string contactName;
        boolean checkbox;
        list<Contact_Relationship__c> crLst=new list<Contact_Relationship__c>();
        for(Contact conIds:conInput){
            checkbox=conIds.Contact_Relationship__c;
            contactName=conIds.Name;
            if(checkbox==true){
                Contact_Relationship__c crObj=new Contact_Relationship__c();
                crObj.Name=contactName +'Related to contact';
                crObj.Contact__c=conIds.Id;
                crLst.add(crObj);
                
            }
        }
        if(crLst.size()>0){
            upsert crLst;
        } 
    }
    //5.3,4-Casestudy when delete/undelete contact relationship record contact record Also delete/undelete
    public static void contactRelationshipUndelete(list<Contact> inputCon){
        set<Id> conIds=new set<Id>();
        for(Contact Ids:inputCon){
            conIds.add(Ids.Id);
        }
        if(inputCon.size()>0){
            list<Contact_Relationship__c> crLst=[
                SELECT
                Id,Name,Contact__c
                FROM
                Contact_Relationship__c
                WHERE
                Contact__c in:conIds
                ALL ROWS
            ]; 
            list<Contact_Relationship__c> crDeLst=new list<Contact_Relationship__c>();
            system.debug(crLst.size());
            for(Contact_Relationship__c crRec:crLst){
                crDeLst.add(crRec);
            }
            if(crDeLst.size()>0 && Trigger.isDelete){
                Delete crDeLst;
            }
            if(crDeLst.size()>0 && Trigger.isundelete){
                undelete crDeLst;
            }
        }
        
    }
    public static void FutureCountContacts(list<Contact> conLst){
        string accRecId;
        list<string> recIds=new list<string>();
        for(Contact conRec:conLst){
            recIds.add((string)conRec.AccountId);
            accRecId = string.join(recIds,',');
        }
        contactFutureHandler.countOfContactsFuture(accRecId);
    }


}