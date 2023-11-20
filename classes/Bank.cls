public class Bank {
    public integer curBalance=50000;
    public integer withdrawAmount=5000;
    public integer depositeAmount=10000;
    public string enterOption='1';
    public void displayOption(){
        system.debug('1.Withdraw');
        system.debug('2.Deposite');
    }
    public void displayBalance(){   
        if (enterOption=='1'){
            integer withdraw=(curBalance-withdrawAmount);
            curBalance=withdraw;
            system.debug('Entered Option ='+enterOption);
            system.debug('Withdrawal Amount ='+withdrawAmount);
            system.debug('Current Balance =' +curBalance);
        }
        else if(enterOption=='2'){
            integer deposite=(curBalance+depositeAmount);
            curBalance=deposite;
            system.debug('Entered Option ='+enterOption);
            system.debug('Deposite Amount ='+depositeAmount);
            system.debug('Current Balance =' +curBalance);
        }
        else{
            system.debug('Invalid Option');
        }
    }
    
    

}