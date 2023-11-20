public  virtual class bankClass {
    private string accountHolderName;
    private double contactNumber;
    public integer openingBalance;
    //public static integer currentBalance;
    
    public void accountInfo(string accountHolderName,double ContactNumber,integer openingBalance){
        this.accountHolderName=accountHolderName;
        this.contactNumber=contactNumber;
        this.openingBalance=openingBalance;
        //currentBalance=openingBalance;
        system.debug('Account informatation :-');
        system.debug('Account holder name =' +accountHolderName);
        system.debug('contact number =' +contactNumber);
        system.debug('Opening Balance =' +openingBalance);
    }

}