public virtual class withdrawal extends bankClass{
    private integer wAmount;
    
    public  void withdrawalAmount(integer wAmount){
        //currentBalance=openingBalance;
        system.debug('Withdrawal information:-');
        if (wAmount>OpeningBalance){
            system.debug('Insufficient fund');
        }
        else{
            openingBalance=openingBalance-wAmount;
            system.debug('withdrawal Amount='+wAmount);
            system.debug('current Balance=' +openingBalance);
            
        }
        
        
    }
    

}