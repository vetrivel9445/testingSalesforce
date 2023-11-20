public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static list<Account> getAccount(string rating){
        List<Account> accLst=[SELECT Id,Name,Rating FROM Account WHERE Rating=:rating];
        return accLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Account> getAccountAddress(string accountId){
        list<Account> accLst=[SELECT BillingAddress FROM Account WHERE Id=:accountId];
        return accLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Account> getAccountData(){
        list<Account> accLst=[SELECT Id,Name,Rating FROM Account LIMIT 10];
        return accLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<Account> getAllAccountData(){
       List<Account> accLst=[SELECT Id,Name,Industry FROM Account];
       return accLst;
    }

    @AuraEnabled(cacheable=true)
    public static list<list<sObject>> getAllAccountForSearch(string input){
        list<list<sObject>> accLst=[FIND :input IN ALL FIELDS RETURNING Account(Name,Id,AccountNumber,BillingAddress)];
       return accLst;
    }
}