public class Mark {
    public integer mark1=51;
    public decimal mark2=70;
    public integer mark3=80;
    public void displayresult(){
        boolean resultpass=(mark1>=50 && mark2>=50 && mark3>=50);
        if (resultpass == true){
             system.debug('Result = Pass');
        }
        else {
            system.debug('Result = fail');
        }
     
    }
    public void displayGrade(){
        boolean resultpass=(mark1>=50 && mark2>=50 && mark3>=50);
        decimal average=((mark1+mark2+mark3)/300)*100;
        if(average>=90 && resultpass == true){
               system.debug('S grade');  
            }
            else if(average>=80 && resultpass == true){
                system.debug('A grade');
            }
            else if(average>=70 && resultpass == true){
                system.debug('B grade');
            }
            else if(average>=50 && resultpass == true){
                system.debug('C grade');
            }
            else{
                system.debug('No grade');
            }
    }
    
}