public class SOQL {
    public SOQL(){
        list<Contact> contactList=[
            SELECT
            Name,AccountId,Account.Name
            FROM
            Contact
        ];
        for(Contact conRecord:contactList)
        {
            system.debug(conRecord.Name);
            system.debug(conRecord.AccountId);
            system.debug(conRecord.Account.Name);
        }
        list<Account> accountList=[
            SELECT
            Name,
            (SELECT
             Name,Full_Name__c
             FROM
             Contacts)
            FROM
            Account
        ];
        for(Account contRecord:accountList)
        {
            system.debug(contRecord.Name);
            for(Contact accRecord:contRecord.Contacts){
                system.debug(accRecord.Name);
                system.debug(accRecord.Full_Name__c);
            }
        }
    }
    
}