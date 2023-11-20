public  class staticCase {
    list<integer>numbers=new list<integer>{1,5,10,12,25,2,0,3,5,95};
       public void biggerNumbers(){
        numbers.sort();
        integer index=numbers.size()-1;
        system.debug(numbers.size());
        system.debug('bigger value ='+numbers[index]);       
      }
       
    
}