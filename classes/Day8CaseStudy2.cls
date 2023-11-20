public class Day8CaseStudy2 {
    list<integer>numbers=new list<integer>();
    list<integer>snumbers=new list<integer>();
    public void sumOdd()
    {
        integer addOdd=0;
        for(integer i=1;i<=10;i+=2){
            numbers.add(i);
        }
        for(integer odd:numbers){
            addOdd=odd+addOdd;
        }
        
        system.debug(addOdd);
    }
    public void sumEven(){
        integer sEven=0;
        for(integer i=2;i<=10;i+=2){
               snumbers.add(i);
        }
        for(integer even:snumbers){
            sEven=even+sEven;
        }
        system.debug(sEven);
    }

}