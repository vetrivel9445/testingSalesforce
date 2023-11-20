/*
* @Name=Test Class
* @Author=vetrivel
* @Date=03-01-2023
* @Description=case study day-8(1).To find the student's result with grade.
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		03-01-2023	case study
* ----------------------------------------------------
*/

public class Test {
    public void display1(){//1
        list<Account> accountlist=[
            SELECT
            Id, RecordTypeId, Name
            FROM
            Account
        ];
        system.debug(accountlist);
        for(Account k:accountlist){
            system.debug(k.Name);
        }
    }
    public void display2(integer iAmount){//2
        
        list<Opportunity> opplst=[
            SELECT
            Id,Name,Amount
            FROM
            Opportunity
            WHERE Amount>=:iAmount
            
        ];
        system.debug(opplst);
        for(Opportunity o:opplst){
            
            system.debug(o.Name);
            system.debug(o.Id);
            system.debug(o.Amount);           
            system.debug('------------------------');
        }
        
    }
    public void display3(string sName){//3
        list<AggregateResult>oplst=[
            SELECT
            COUNT(Name)countName,StageName
            FROM
            Opportunity
            WHERE StageName=:sName
            GROUP BY StageName
        ];
        system.debug(oplst);
        for(AggregateResult o:oplst){
            system.debug(o.get('countName'));
            system.debug(o.get('StageName'));
            system.debug('------------------------');
        }
        
    }
    public void display4(string sName,string lSource){
        integer i=[SELECT COUNT() FROM Opportunity WHERE StageName=:sName AND LeadSource=:lSource];
       
        list<AggregateResult>oplist=[
            SELECT
            COUNT(Id) stagecount,Name,StageName,LeadSource
            FROM
            Opportunity
            WHERE StageName=:sName AND LeadSource=:lSource
            GROUP BY Name,StageName,LeadSource
           // HAVING LeadSource=:lSource
        ];
        system.debug(i);
        system.debug(oplist);
         
        for(AggregateResult s:oplist){
            integer Id=(integer)s.get('stagecount');
            system.debug(s.get('Name'));
            system.debug(s.get('StageName'));
            system.debug(s.get('LeadSource'));
            system.debug(id);
            system.debug('------------------------');
        }
    }
    public void display5(string sName){
        list<AggregateResult>oplist=[
            SELECT
            COUNT(Id),Name,StageName
            FROM
            Opportunity
            WHERE Name=:sName  
            GROUP BY Name,StageName
        ];
        system.debug(oplist);
        for(AggregateResult s:oplist){
            system.debug(s.get('Name'));
            system.debug(s.get('StageName'));
            system.debug('------------------------');
        }
    }
    public void display6(string sName){//6
        list<AggregateResult> opplst=[
            SELECT
            Sum(Amount)sAmount,COUNT(StageName)countStages
            FROM
            Opportunity
            WHERE StageName =:sName            
        ];
        system.debug(opplst);
        for(AggregateResult s:opplst){
            system.debug(s.get('countStages'));
            system.debug(s.get('sAmount'));
            system.debug('------------------------');
        }
    }
}