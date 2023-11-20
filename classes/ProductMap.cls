public class ProductMap {
    public integer Code;
    public integer Stock;
    public string Name;//intialize datatype  for a variable string.
    public decimal Discount;//intialize datatype  for a variable decimal.
    public decimal Price;//intialize datatype  for a variable decimal.
    
     
    public productMap(integer Code,string Name,decimal Price,decimal Discount,integer Stock)
    {
        this.Code=Code;
        this.Name=Name;
        this.Price=Price;
        this.Discount=Discount;
        this.Stock=Stock; 
    }

}