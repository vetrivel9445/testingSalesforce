import { LightningElement,track } from 'lwc';

export default class TaskPlannerPrimaryFilter extends LightningElement {
    @track category= [
        { label: '8:00 PM', value: 'immigiration', checkValues:false },
        { label: '9:00 PM', value: 'jobsearch',checkValues:false },
        { label: '10:00 PM', value: 'coaching' ,checkValues:false }
    ];
    @track selectCategory ;

    handlecategoryFilter(){
        let categoryComboo = this.template.querySelector('.categoryCombo').classList.toggle('slds-is-open'); 
    
    }
    handleSelectCategory(event){
        let getAttributeName = event.target.getAttribute('data-name');
        console.log('getAttributeName ',getAttributeName);
    
        for(let i = 0;i<this.category.length;i++){
            if(getAttributeName == this.category[i].label){
                if(this.category[i].checkValues == true){
                    this.category[i].checkValues = false;
                }
                else{
                    this.selectCategory = this.category[i].label;
                    this.category[i].checkValues = true;
                }
            }    
            else{
                this.category[i].checkValues = false;
            }    
        }
    } 
}