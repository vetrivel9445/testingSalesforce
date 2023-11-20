/*
 * @Name=Test Class
 * @Author=vetrivel
 * @Date=05-01-2023
 * @Description=case study day-9(1).To find the student's result with grade.
 * *************************************
 * Modification log:-
 * -----------------------------------------------------
 * version		Developer		Date		Description
 * 0.1			vetrivel		05-01-2023	case study
 * ----------------------------------------------------
*/


public  class product {
    public integer productCode;//intialize datatype  for a variable integer.
    public integer productStock;
    public string productName;//intialize datatype  for a variable string.
    public decimal productDiscount;//intialize datatype  for a variable decimal.
    public decimal productPrice;//intialize datatype  for a variable decimal.
    
  

    public product(integer productCode,string productName,decimal productPrice,decimal productDiscount,integer productStock)
    {
        this.productCode= productCode;
        this.productName=productName;
        this.productPrice=productPrice;
        this.productDiscount=productDiscount;
        this.productStock=productStock; 
    }
    
}