public class SuperMarket3 {
    public map<integer,ProductMap>mProduct=new map<integer,ProductMap>();
    final integer RESTOCK_LEVEL=20;
    public  double order2Billing(integer pkey,integer quantity){
        system.debug('----------Product Billing----------:-');
        if (mProduct.containsKey(pkey) && quantity<100){
            mProduct.get(pkey).Stock-=quantity;
            ProductMap obj=mProduct.get(pkey);
            double fAmount=(quantity*(obj.Price -(obj.Price*(obj.Discount/100))));
            system.debug('Product Name =' +obj.Name);
            system.debug('Product Code =' +obj.Code);
            system.debug('Final Price ='+fAmount);
            system.debug('Available Stock ='+obj.Stock);
            return fAmount;
            /*for(ProductMap k:mProduct.get(pkey)){
/*  if(k.Code==pkey && k.Stock>quantity){
k.Stock-=quantity;
system.debug('Product Code =' +k.Code);
system.debug('Product Name =' +k.Name);
system.debug('Final Price ='+ (quantity*(k.Price -(k.Price*(k.Discount/100)))));
system.debug('Available Stock ='+k.Stock);
}
else if(k.Code==pkey && k.Stock<quantity){
system.debug('Quantity should be below 100');
}*/
        }
        else if(quantity>=100){
            system.debug('quantity should be below 100');
            double fAmount=0;
            return fAmount;
        }
        else{
            system.debug('Enter valid code');
            double fAmount=0;
            return fAmount;
        }
        
    }
    public void reOrderDisplay(){
        system.debug('----------Product to Reorder----------:-');
        for(ProductMap k:mProduct.values()){
            if(k.Stock<RESTOCK_LEVEL){
                system.debug('Reorder Needed =' +k.Name);
            }
            else{
                system.debug(' No Reorder Needed =' +k.Name);
            }
        }
    }
    public void stockStatus(){
        system.debug('----------Product Stock Status----------:-');
        for(ProductMap k:mProduct.values()){
            system.debug('Product Name =' +k.Name);
            system.debug('Product Price ='+k.Price);
            system.debug('Product Stock ='+k.Stock);
            system.debug('---------- ********----------:-');
        }
    }
}