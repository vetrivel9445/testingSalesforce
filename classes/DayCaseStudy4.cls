public class DayCaseStudy4 {
        list<integer>nums=new list<integer>{-5,-4,-3,-2,-1,0,1,2,3,4,5,6};
        list<integer>numbers=new list<integer>();
    public void reverseList(){
        integer inx=nums.size()-1;
        for (integer i=inx;i>=0;i=i-1){
            numbers.add(nums[i]);
            
        }
        system.debug(numbers);
    }

}