/*
* @Name=Test Class
* @Author=vetrivel
* @Date=14-01-2023
* @Description=case study day-12.To create the dynamic soql function.
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		14-01-2023	case study
* ----------------------------------------------------
*/

public class DySOQL {
    //1.1- Refactor update Employee name in Employee object prg--------------------------------------------------------------------
    public void refactorUpdate(){
        string reName='Refactor';
        list<Employee__c> emp=[SELECT
                               Id,Name
                               FROM
                               Employee__c];
        for(Employee__c empRec:emp){
            empRec.Name=empRec.Name+reName;
        }
        update emp;
        
    }
    //1.2- Refactor insert Account name in Account object prg--------------------------------------------------------------------
    public void refactorAccInsert(){
        string addName='Test';
        list<Account> accountList=new list<Account>();
        Account accountObject;
        for(integer i=0;i<150;i++){
            accountObject=new Account();
            accountObject.Name=addName+i;
            accountList.add(accountObject);
        }
        insert accountList;
    }
    //1.3- Refactor insert Contact name in Contact object prg--------------------------------------------------------------------
    public void refactorConInsert(){
        string addName='SureName';
        list<Contact> contactList=new list<Contact>();
        Contact contactObject;
        for(Account acc:[SELECT
                         Id,Name
                         FROM
                         Account]){
            contactObject=new Contact();
            contactObject.AccountId=acc.Id;
            contactObject.LastName='SureName'+acc.Name;
            contactList.add(contactObject);
        }
        insert contactList;
    }
    public void DySOQLwithoutOperator(list<string> fieldLst,string objects){
        //2.1- created the search function through prg--------------------------------------------------------------------
        string fields=string.join(fieldLst, ',');//changed to string.join instead of for loop
        string qureyLst='SELECT '+fields+' FROM '+objects;
        list<Sobject> searchLst=database.query(qureyLst );
        for(Sobject rec:searchLst){
            for(string f:fieldLst){
                system.debug(rec.get(f));
            }
            system.debug('---------------');
        }
    }
    public void DySOQLwithOperator(string objects,list<string> fieldLst,string seFields,string operator,string values){
        //2.2-created the search function through prg--------------------------------------------------------------------
        string fields=string.join(fieldLst, ',');
        
        string qList=' SELECT '+fields+' FROM '+objects+' WHERE '+seFields+operator+values;
        system.debug(qList);
        list<Sobject> searchLst=database.query(qList);
        for(Sobject rec:searchLst){
            for(string f:fieldLst){
                system.debug(rec.get(f));
            }
            system.debug('---------------');
        }
    }
    
}


//*******
/*list<string> j=new list<string>{'Name,Position__c,Salary__c '};
DySOQL obj=new  DySOQL('Employee__c',j,'Salary__c','>','1000');*/