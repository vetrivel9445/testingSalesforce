public class Calculator {
    public integer x=20;
    public integer y=30;
    public integer sum=x+y;
    public integer sub=x-y;
    public integer mul=x*y;
    public integer div=x/y;
    public string sOperator='+';
    
    public void display(){
        system.debug('x='+x);
        system.debug('y='+y);
        system.debug('Selected Operator ='+sOperator);
        if (sOperator=='+'){
            system.debug('Sum of numbers ='+sum);
        }
        else if (sOperator=='-'){
            system.debug('Subract of numbers ='+sub); 
        }
        else if (sOperator=='*'){
            system.debug('Multiple of numbers ='+mul);
        }
        else if (sOperator=='/'){
            system.debug('divide of numbers ='+div);
        }
        else{
            system.debug('invalid Operator');
        }
    }
       
}