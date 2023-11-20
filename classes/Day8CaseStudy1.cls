public class Day8CaseStudy1 {
    list<integer>nums=new list<integer>{1,5,10,12,25,2,0,3,5,95,10};
        
        public void findBigValue(){
            
            integer bigValue=0;
            for(integer i=0;i<nums.size();i++){
                if (nums[i]>bigValue){
                    bigValue=nums[i];   
                }                
            }            
            system.debug('biggest value is 2:'+ bigValue);  
        }
}