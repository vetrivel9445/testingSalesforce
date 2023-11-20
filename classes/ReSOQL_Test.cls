@isTest
public class ReSOQL_Test {
    @Testsetup
    static void dataLoader(){
        integer i=0;
        integer j=0;
        integer k=0;
        list<Department__c> Dlist= new list<Department__c>{new Department__c(Name='hodA'),new Department__c(Name='testHtesting'),
            new Department__c(Name='testK')};
                insert Dlist;
        list<Employee__c> salaryList=new list<Employee__c>{
            new Employee__c(Name='testAAA',Position__c='production',Salary__c=70000),
                new Employee__c(Name='testB',Position__c='hod',Salary__c=100000),
                new Employee__c(Name='testP'),new Employee__c(Name='testK')};
                    for(Department__c rec:Dlist){
                        if(i<Dlist.size()){
                            Employee__c obj= new Employee__c(Name='test'+(i++),Department__c=rec.Id);
                            salaryList.add(obj);
                        }
                        if(j<(Dlist.size()-1)){
                            Employee__c obj1= new Employee__c(Name='testABC'+(j++),Department__c=rec.Id);
                            salaryList.add(obj1);
                        }
                        if(k<(Dlist.size()-2)){
                            Employee__c obj3= new Employee__c(Name='testACC'+(k++),Department__c=rec.Id);
                            salaryList.add(obj3);
                        }
                    }
        insert salaryList;
        list<Employee__c> empName=new list<Employee__c>();
        for(Employee__c s:salaryList){
            if(s.Name=='testAAA'){
                empName.add(s);
            }
        }
        delete empName;
    }
    
    TestMethod
        static void insertDepmTest(){
            RelSOQL obj=new RelSOQL();
            integer Dep=obj.insertDepm('testBJ');
            system.assertEquals(0,Dep,'Error on insert');
            integer Dep1=obj.insertDepm('testK');
            system.assertEquals(1,Dep1,'Error on insert,Already record Exist');
        }
    TestMethod
        static void insertEmpTest(){
            RelSOQL obj=new RelSOQL();
            list<Employee__c> emp=obj.insertEmp('testGJ');
            system.assertEquals(1,emp.size(),'Error on insert');
            list<Employee__c> emp1=obj.insertEmp('testK');
            system.assertEquals(0,emp1.size(),'Error on insert,Already record Exist');
        }
    TestMethod
        static void updateEmpTest(){
            RelSOQL obj=new RelSOQL();
            integer Emp=obj.updateEmp('testK','testAJ');
            system.assertEquals(1,Emp,'Error on update');
            integer EmpError=obj.updateEmp('testS','testAJ');
            system.assertEquals(0,EmpError,'Error on update,No such record to Update');
        }
    TestMethod
        static void deletedepTest(){
            RelSOQL obj=new RelSOQL();
            integer dep=obj.deletedep('testK');
            system.assertEquals(1,dep,'Error on delete');
            integer depError=obj.deletedep('testS');
            system.assertEquals(0,depError,'Error on delete');
        }
    
    TestMethod
        public static void undeleteTest(){
            RelSOQL obj=new RelSOQL();
            integer dep=obj.undeleteDep('testAAA');
            system.assertEquals(1,dep,'Error on undelete');
            integer depError=obj.undeleteDep('testAA');
            system.assertEquals(0,depError,'Error on undelete');
        }
    TestMethod
        public static void empNoPositionTest(){
            RelSOQL obj=new RelSOQL();
            list<Employee__c> eLst=new list<Employee__c>{new Employee__c(Name='testB')};
                list<Employee__c> empLst=obj.empNoPosition(eLst);
            system.assertEquals(1,empLst.size(),'Error on insert');
            list<Employee__c> eLstEr=new list<Employee__c>{new Employee__c(Name='testB',Position__c='hod')};
                list<Employee__c> empLstEr=obj.empNoPosition(eLstEr);
            system.assertEquals(0,empLstEr.size(),'Error on insert ,Having Position');
        }
    TestMethod
        public static void empPositionTest(){
            RelSOQL obj=new RelSOQL();
            list<Employee__c> eLst=new list<Employee__c>{new Employee__c(Name='testB',Position__c='hod',Salary__c=100000)};
                list<Employee__c> empLst=obj.empPosition(eLst);
            system.assertEquals(1,empLst.size(),'Error on insert');
            list<Employee__c> eLstEr=new list<Employee__c>{new Employee__c(Name='testB',Position__c='production',Salary__c=100000)};
                list<Employee__c> empLstEr=obj.empPosition(eLstEr);
            system.assertEquals(0,empLstEr.size(),'Error on insert,salary fields has greater than 80000');
            list<Employee__c> eLstError=new list<Employee__c>{new Employee__c(Name='testB',Position__c='production',Salary__c=70000)};
                list<Employee__c> empLstError=obj.empPosition(eLstError);
            system.assertEquals(1,empLstError.size(),'Error on insert');
        }
    TestMethod
        public static void maxSalaryTest(){
            RelSOQL obj=new RelSOQL();
            decimal amount=obj.maxSalary('hod');
            system.assertEquals(100000,amount,'Error in Salary');
        }
    TestMethod
        public static void maxMinSalaryTest(){
            RelSOQL obj=new RelSOQL();
            decimal amount=obj.maxMinSalary();
            system.assertEquals(100000,amount,'Error in Salary');
        }
    TestMethod
        public static void depLsEmpTest(){
            RelSOQL obj=new RelSOQL();
            integer sizes=obj.DepLsEmp();
            system.assertEquals(1,sizes,'Error in Sort,list does not contains values');
            //integer sizes1=obj.DepLsEmp();
            //system.assertEquals(0,sizes1,'Error in Sort ,list contains value');
            
        }
}