/*
* @Name=Test Class
* @Author=vetrivel
* @Date=11-01-2023
* @Description=case study day-11(1).To insert the department name and employee name.
* *************************************
* Modification log:-
* -----------------------------------------------------
* version		Developer		Date		Description
* 0.1			vetrivel		11-01-2023	case study
* ----------------------------------------------------
*/

public class RelSOQL {
    //public list<Department__c> deplst=new list<Department__c>();
    //public list<Employee__c> emplst=new list<Employee__c>();
    
    public integer insertDepm(string inputD){   
        //11-function for create records for Department
        list<Department__c> deplst=new list<Department__c>();
        system.debug('--------------Insert function----------');
        list<Department__c> Dlist=[
            SELECT
            Name
            FROM
            Department__c
            WHERE Name=:inputD
        ];
        
        if(Dlist.size()==0){
            Department__c objD=new Department__c();
            objD.Name=inputD;
            deplst.add(objD);
            insert deplst;
            system.debug('Department Name is inserting,ID ='+objD.Id);
        }
        else if(Dlist.size()>0){
            system.debug('Department Name is Already Exists');
        }
        return Dlist.size();
    }
    public list<Employee__c> insertEmp(string inputE){                           //1.2-function for insert records for Employee
        system.debug('--------------Insert function----------');
        list<Employee__c> emplst=new list<Employee__c>();
        list<Employee__c> Elist=[
            SELECT
            Name
            FROM
            Employee__c
            WHERE Name=:inputE
        ];
        
        if(Elist.size()==0){
            Employee__c objE=new Employee__c();
            objE.Name=inputE;
            emplst.add(objE);
            insert emplst;
            system.debug('Employee Name is inserted ,ID ='+objE.Id);
        }
        else if(Elist.size()>0){
            system.debug('Employee Name is Already Exists');
        }
        return emplst;
    }
    public integer updateEmp(string EmpName,string updateEmpName){                           //function for update records for Employee
        system.debug('--------------update function----------');
        list<Employee__c> Elist=[
            SELECT
            Name
            FROM
            Employee__c
            WHERE Name=:EmpName
        ];
        system.debug(Elist);
        if(Elist.size()>0){
            Employee__c objE=new Employee__c();
            objE.Name=updateEmpName;
            for (Employee__c empRecord:Elist){
                empRecord.name=updateEmpName;
                system.debug('Employee Name  updated ID ='+empRecord.Id);
            }
            update Elist;
            system.debug('updated Record ');
        }
        else if(Elist.size()==0) {
            system.debug('no such record exists ='+EmpName);
        }
        system.debug('update'+ Elist.size());
        return Elist.size(); 
    }
    public integer deletedep(string input4Del){                         //1.2-function for delete records 
        system.debug('--------------Delete function----------');
        list<Department__c> departLst=[
            SELECT
            Name
            FROM
            Department__c
            WHERE Name=:input4Del
        ];
        system.debug(departLst.size() +' Records to delete');
        if(departLst.size()>0){
            delete departLst;
            system.debug('record is deleted');
        }
        else{
            system.debug('No Record Exists');
        }
        return departLst.size();
    }
    
    public integer undeleteDep(string inputUnDel){                //1.3-function for undelete records
        system.debug('--------------UnDelete function----------');
        list<Employee__c> unLst=[
            SELECT
            Name
            FROM
            Employee__c
            WHERE Name=:inputUnDel
            ALL ROWS
        ];
        if(unLst.size()>0){
            UNDELETE unLst;
            system.debug('Retrived Records ='+ unLst.size());
        }
        else if(unLst.size()==0) {
            system.debug('no such record exists ='+inputUnDel);
        }
        return unLst.size();
    }
    //1.4-Employee created with out the position--------------------------------------------------------------------
    public list<Employee__c> empNoPosition(list<Employee__c> empNoPlst){
        list<Employee__c> emplist=new list<Employee__c>();
        for(Employee__c empRecord:empNoPlst){
            if(empRecord.Position__c==NULL){
                emplist.addall(empNoPlst);
                system.debug('Record inserted');
            }
            else if(empRecord.Position__c!=NULL){
                system.debug('Record contains position');  
            }
        }
        if(emplist.size()>0){
            insert emplist;
            system.debug('Employee Created');  
        }
        else{
            system.debug('Employee not Created'); 
        }
        return emplist;
    }
    /*RelSOQL obj=new RelSOQL();
list<Employee__c> inputE=new list<Employee__c>();
inputE.add(new Employee__c(Name='testK',Position__c=''));    
obj.empNoPosition(inputE);*/

    //1.5-Employee created with  the position--------------------------------------------------------------------
    public list<Employee__c> empPosition(list<Employee__c> inputE){
        list<Employee__c> emplist=new list<Employee__c>();
        for(Employee__c empRecord:inputE){
            if(empRecord.Salary__c<80000){
                emplist.addall(inputE);
                system.debug('Record inserted');
            }
            else if(empRecord.Position__c=='hod' && empRecord.Salary__c>80000){
                emplist.addall(inputE);
                system.debug('Record inserted');
            }
            
            else {
                system.debug('Salary should not be greater than 80000');
            }
            
        }
        if(emplist.size()>0){
            insert emplist;
            system.debug('Employee Created');  
        }
        else{
            system.debug('Employee not Created'); 
        }
        return emplist;
    }
    //2-to find the maximum salary for agiven position--------------------------------------------------------------------
    public decimal maxSalary(string inPosition){
        decimal amount;
        list<AggregateResult> salaryList=[
            SELECT
            Max(Salary__c)mSalary,Position__c
            FROM
            Employee__c
            WHERE Position__c=:inPosition
            GROUP BY Position__c
        ];
        if(salaryList.size()>0){
            for(AggregateResult sRecord:salaryList){
                system.debug('Position of employee =' +sRecord.get('Position__c'));
                system.debug('maximum salary of the position ='+ sRecord.get('mSalary'));
                system.debug('-------------------------');
                amount=(decimal)sRecord.get('mSalary');
            } 
        }
        else{
            system.debug('No such position');
        }
        return amount;
    }
    //3-to find the maximum minimum salary for agiven position--------------------------------------------------------------------
    public decimal maxMinSalary(){
        Decimal salary;
        list<AggregateResult> salaryList=[
            SELECT
            Max(Salary__c)maxSalary,MIN(Salary__c)minSalary,Position__c
            FROM
            Employee__c
            WHERE Position__c!=NULL AND Salary__c!=NULL
            GROUP BY Position__c
        ];
        for(AggregateResult sRecord:salaryList){
            system.debug('Position of employee =' +sRecord.get('Position__c'));
            system.debug('maximum salary of the position ='+ sRecord.get('maxSalary'));
            system.debug('minimum salary of the position ='+ sRecord.get('minSalary'));
            system.debug('-------------------------');
            salary=(Decimal)sRecord.get('minSalary');
        }
        
        return salary;
    }
    //4-to find the department with less number of employee--------------------------------------------------------------------
    public integer DepLsEmp(){
        integer size4Map;
        integer i=0;
        list<integer> minvalue=new list<integer>();
        map<string,list<string>> empMap=new map<string,list<string>>();
        map<string,integer> empMapCount=new map<string,integer>();
        system.debug('--------------Department with Less Number of Employee----------');
        list<Employee__c> Employeelist=[
            SELECT
            Name,Department__r.Id,Department__r.Name
            FROM
            Employee__c
            WHERE Department__r.Id!=NULL
        ];
        if(Employeelist.size()>0){
            for(Employee__c rec:Employeelist){
                if(!empMap.containsKey(rec.Department__c)){
                    empMap.put(rec.Department__c,new list<string>{rec.Name});
                }
                else{
                    empMap.get(rec.Department__c).add(rec.Name);
                }
                system.debug(rec.Department__c);
                size4Map=empMap.get(rec.Department__c).size();
                empMapCount.put(rec.Department__c,size4Map);
                
            }
            list<integer> sizes=new list<integer>(empMapCount.values());
            sizes.sort();
            integer sortSize=sizes[0];
            for(string key:empMapCount.keyset()){
                if(empMapCount.get(key)==sizes[i]){
                    system.debug(key+'='+empMapCount.get(key));
                }
            }
            system.debug(sortSize);
            system.debug(sizes);
            system.debug(Employeelist.size());
            system.debug(Employeelist);
            return sortSize;
        }
        else{
            system.debug('none of the record found');
            integer sortSize=0;
            return sortSize;
        }
    }  
}


/*RelSOQL obj=new RelSOQL();
obj.Depm();
list<Employee__c> inputE=new list<Employee__c>();
inputE.add(new Employee__c(Name='testK',Department__r.Name='production'));    
obj.empNoPosition(inputE);*/