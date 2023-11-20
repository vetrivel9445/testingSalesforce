public class Day8CaseStudy3 {
    list<integer>nums=new list<integer>{-5,-4,-3,-2,-1,0,1,2,3,4,5,6};
        list<integer>numbers=new list<integer>();
        public void findInteger(){

                for(integer i=0;i<nums.size();i++){
                    if(nums[i]<0){
                      numbers.add(nums[i]); 
                    }
                    
                }
             system.debug('negtive integers='+numbers);
        }
    public void countInteger(){
        system.debug('count of negative integers ='+ numbers.size());
    }
    

}