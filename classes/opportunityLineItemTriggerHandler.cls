/*
* @Name=Test Class
* @Author=vetrivel
* @Date=29-01-2023
* @Description= trigger case study day.
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		29-01-2023	case study
* ----------------------------------------------------
*/
public class opportunityLineItemTriggerHandler {
    //7.Casestudy when opportunity line item with product code will automatically update in opportunity
    public static void opportunityLineItemFunction(list<OpportunityLineItem> oppLineLst){
        string productCode;
        list<Opportunity> oppUpdate=new list<Opportunity>();
        list<string> productCodeLst=new list<string>();
        set<Id> oppId=new set<Id>();
        for(OpportunityLineItem Ids:oppLineLst){
            oppId.add(ids.OpportunityId);
        }
        list<OpportunityLineItem> oppLineLstNew=[SELECT id,ProductCode,OpportunityId
                                                 FROM OpportunityLineItem
                                                 WHERE OpportunityId in:oppId
                                                ];
        map<Id,list<string>> oppLineMap=new map<Id,list<string>>(); 
        for(OpportunityLineItem OpLineRec:oppLineLstNew){
            if(!oppLineMap.containsKey(OpLineRec.OpportunityId)){
                oppLineMap.put(OpLineRec.OpportunityId, new list<string>{OpLineRec.ProductCode});
            }
            else{
                oppLineMap.get(OpLineRec.OpportunityId).add(OpLineRec.ProductCode);
            }
        }
        for(OpportunityLineItem Ids:oppLineLst){
            if(Ids.ProductCode!=NULL){
                Opportunity oppObj=new Opportunity();
                oppObj.Id=Ids.OpportunityId;
                if(oppLineMap.get(Ids.OpportunityId)==NULL){
                    oppObj.Oppr_LineItems_ProductCode__c=' ';
                }
                if(oppLineMap.get(Ids.OpportunityId)!=NULL){
                    productCodeLst=oppLineMap.get(Ids.OpportunityId);
                    productCode=string.join(productCodeLst,',');
                    oppObj.Oppr_LineItems_ProductCode__c=productCode;
                }
                oppUpdate.add(oppObj);
            }
        }
        
        if (oppUpdate.size()>0 ){
            upsert oppUpdate;
        }     
    }
}