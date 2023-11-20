@isTest
public class SuperMarket_Test {
    
    @isTest
    public static void SuperMarket_Test(){
        productMap obj4=new productMap(101,'TV',10000,11,100);
        productMap obj5=new productMap(102,'AC',10000,10,100);
        productMap obj6=new productMap(103,'Fan',10000,5,100);
        
        SuperMarket3 objA=new SuperMarket3();
        objA.mProduct.put(101,obj4);
        objA.mProduct.put(102,obj5);
        objA.mProduct.put(103,obj5);
        
        double amount;
        double amount1;
        double amount2;
        amount= objA.order2Billing(101,101);
        system.assertEquals(0,amount,'Error in Amount');
        amount1= objA.order2Billing(101,50);
        system.assertEquals(445000.0,amount1,'Error in Amount');
        amount2= objA.order2Billing(105,50);
        system.assertEquals(0,amount2,'Error in Amount');
        objA.reOrderDisplay();
        objA.stockStatus();
    }
}