@RestResource(URLMapping='/AccountServicers/*')
Global class AccountManagment {
    
    @HttpGet
    Global static list<Account> getAccountRecord(){
        List<Account> accQurey=[SELECT Id,Name,Rating FROM Account LIMIT 10];
        return accQurey;
    }
    //for multiple record to make use of the RestContext.request.requestBody.ToString() to pass the parameter and deserilise to typecaste and Insert.
    @HttpPost
    Global static string createNewAccount(){

        string AccountName=RestContext.request.requestBody.ToString();
        if(AccountName!=null){
            return 'Success';
        }
        else{
            return 'Failed';
        }
        //for a single Parameter we have to do like This
        /*
         * 
         *         string AccountName=RestContext.request.requestBody.ToString();
       Account accLst=(Account)JSON.deserialize(AccountName, Account.class);
        for(Account name:accLst){
            Account acc=new Account();
            acc.Name=name.AccountName;
            insertLst.add(acc);
        }
        insert insertLst;
        if(insertLst!=NULL){
            return 'Account Created';
        }
        else{
            return 'Error in Account Creation';
        }*/
    }

}