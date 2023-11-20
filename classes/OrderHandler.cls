public with sharing class OrderHandler {
    @AuraEnabled(Cacheable =true)
    public static List<Order> getOrder(string accountid) {
List<Order> ordList= [Select Id ,OrderNumber ,AccountId from Order WHERE AccountId =:accountid];
        System.debug(ordList);
        return ordlist;
    }
}