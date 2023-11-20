/*
 * @Name=Test Class
 * @Author=vetrivel
 * @Date=06-01-2023
 * @Description=case study day-9(1).To find the student's result with grade.
 * *************************************
 * Modification log:-
 * -----------------------------------------------------
 * version		Developer		Date		Description
 * 0.1			vetrivel		06-01-2023	case study
 * ----------------------------------------------------
*/

//created a function class as supermarket class
public class SuperMarket{
    public list<product>AllProducts=new list<product>();//creating new list to store the input product details .
    final integer RESTOCK_LEVEL=20;//creating a constant.
    
    public void market(integer codeFrProduct){//creating the function to get product details.
        system.debug('-----Product Details---------');
        for(product sproduct:AllProducts){
            if(sproduct.productCode==codeFrProduct){               
                system.debug('Product Code='+ sproduct.productCode);
                system.debug('Product Name='+sproduct.productName);
                system.debug('Product Price='+sproduct.productPrice);
                system.debug('Product Discount='+sproduct.productDiscount+'%');
                system.debug('Product Stock='+sproduct.productStock);
                break;
            }  
        }
       
    }
    public void  orderFrBilling(integer codeFrProduct,integer quantity){//creating the function to get product billing details.
        system.debug('-----Billed Product Details---------');
        for(product sproduct:AllProducts){
            if(sproduct.productCode==codeFrProduct && sproduct.productStock>quantity){
                sproduct.productStock=sproduct.productStock-quantity;
                system.debug('Product Code='+ sproduct.productCode);
                system.debug('Product Name='+ sproduct.productName);
                system.debug('Final Product Price='+ (quantity*(sproduct.productPrice- (sproduct.productPrice*(sproduct.productDiscount/100)))));
                system.debug('Available Stock='+ (sproduct.productStock));
                break;
            }
            else if(sproduct.productCode==codeFrProduct && sproduct.productStock<=quantity){
                system.debug('Quantity should be below 100');
                break;
            }
            else if(sproduct.productCode!=codeFrProduct && sproduct.productStock<=quantity ){
                system.debug('Enter valid code');
                break;
            }

        }
    }
    public void reOrderDisplay(){//creating the function to get product reorder details.
       system.debug('-----Reordered Product Details---------');
        for(product sproduct:AllProducts){
            if(sproduct.productStock<=RESTOCK_LEVEL){
                system.debug(sproduct.productName+' '+'Re Order Needed ='+sproduct.productName);
            }
            else{
                system.debug(sproduct.productName+ '= No Reorder Needed');
                
            }
        }
    }
    public void stockDisplay(){//creating the function to get product stock details.
        system.debug('----- Product  Stock Details---------');
        for(product sproduct:AllProducts){
            system.debug(sproduct.productName +'Available Stock ='+sproduct.productStock);
        }
    }
}