public class deposite extends withdrawal {
    private integer dAmount;
    public  void depositeAmount(integer dAmount){
        openingBalance=openingBalance+dAmount;
        system.debug('Deposite Amount informatation :-');
        system.debug('Deposite Amount='+dAmount);
        system.debug('current Balance =' +openingBalance);
    }

}