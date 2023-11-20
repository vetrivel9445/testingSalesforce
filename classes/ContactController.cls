public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static list<Contact> getContact(string accountId){
        list<contact> conLst=[SELECT
                            Id,Name,AccountId,Address__c
                            FROM
                            Contact
                            WHERE
                            AccountId=:accountId];
                            return conLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Contact> getContactAction(string contactId){
        list<contact> conLst=[SELECT
                            Id,Salutation,FirstName,LastName,Address__c,Phone,Email,AccountId
                            FROM
                            Contact
                            WHERE
                            Id=:contactId];
                            return conLst;
    }

    @AuraEnabled(cacheable=true)
    public static SObject getCloneRecord(string recordId,string objectName){

        string Id='\''+recordId+'\'';
        system.debug(recordId);
        list<string> fieldLst=new list<string>();
        Schema.SObjectType objectType=null;
        objectType=Schema.getGlobalDescribe().get(objectName);
        system.debug(objectType);
        Schema.DescribeSObjectResult d = objectType.getDescribe();
        Map<String, Schema.FieldSet> FsMap = d.fieldSets.getMap();
        system.debug(FsMap);
        for(string f:FsMap.keyset()){
            system.debug(f);
            system.debug(FsMap.get(f).getDescription());

            if(FsMap.get(f).getDescription()=='In LWC'){
                for(Schema.FieldSetMember r:FsMap.get(f).getFields()){
                    system.debug(r.getFieldPath());
                    fieldLst.add(r.getFieldPath());
                }
            }
        }
        string fieldsName=string.join(fieldLst,',');
        string query='SELECT '+fieldsName+' FROM '+objectName +' WHERE Id='+Id ;
        sobject obj=Database.query(query);
        return obj;
    }

}