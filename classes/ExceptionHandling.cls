public class ExceptionHandling {
    public  ExceptionHandling(){
        try{
            list<Employee__c> EmpLst=new list<Employee__c>{
                new Employee__c(Name='testACB',Position__c='Hr'),
                    new Employee__c(Name='testACC',Position__c='testing'),
                    new Employee__c(Name='testACV')};
                        insert EmpLst;
        }
        Catch(Exception e){
            system.debug(e.getMessage());
        }
    }
    public void  ExceptionHandlingInertEmployee(){
        list<Employee__c> EmpLst=new list<Employee__c>{
            new Employee__c(Name='testACB1',Position__c='Hr'),
                new Employee__c(Name='testACC1',Position__c='testing'),
                new Employee__c(Name='testACV2')};
                    Database.SaveResult[] sResult=database.insert(EmpLst,False);
        for(Database.SaveResult result:sResult){
            if(!result.isSuccess()){
                for(Database.Error e:result.getErrors()){
                    system.debug(e.getMessage());
                    system.debug(e.getFields());
                }
            }
        }
        
   }
}