public class LeadScheduledHandler {
        //AsyncApex DAY =5;
        public static string scheduledBatchUpdateLead(list<Lead> scope){
        string emailBody;
        string body;
        list<string> returnLst=new list<string>();    
        list<string> leadNameLst=new list<string>();
        for(Lead ldRec:scope){
            leadNameLst.add(ldRec.Name);
        }
        string leadNames=string.join(leadNameLst, '\n');
        emailBody='Apex Job of Lead created with Open - Not Contacted Records are::'+leadNameLst.size()+'\n';
        emailBody+='list of leads created Today'+'\n'+leadNames;
        returnLst.add(emailBody);
        body=string.join(returnLst,',');
        return body;
    }
}