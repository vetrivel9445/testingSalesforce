public class contactRelationshipTriggerHandler {
    //5.3-Casestudy when change owner name contact relationship record is updated in Account manager field
    public static void contactRelationshipOwnerChaange(list<Contact_Relationship__c> crNew,map<Id,Contact_Relationship__c> croldMap){
        list<Contact_Relationship__c> crLst=new list<Contact_Relationship__c>();
        map<Id,Contact_Relationship__c> crMap=new map<Id,Contact_Relationship__c>([
            SELECT
            id,OwnerId,Owner.Name
            FROM
            Contact_Relationship__c
        ]);
        for(Contact_Relationship__c crRec:crNew){
            if(crRec.OwnerId!=croldMap.get(crRec.Id).OwnerId){
                Contact_Relationship__c obj=new Contact_Relationship__c();
                obj.Id=crRec.Id;
                obj.Name=crMap.get(crRec.Id).Owner.Name;
                crLst.add(obj);
               
                
            }
        }
        if(crLst.size()>0){
            upsert crLst;
        }
    }
}