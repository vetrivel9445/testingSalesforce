import { LightningElement,track,api } from 'lwc';

export default class YaxisTaskFilter extends LightningElement {

    clickedButton='satGrading';
    checkedLst=[];
    isOpen=true;
     @track buttonLst=[
        {label:'Subject',dataName:'subject',class:"slds-button slds-button_neutral"},
        {label:'SAT Grading',dataName:'satGrading',class:"slds-button slds-button_brand"},
        {label:'Label 3',dataName:'label3',class:"slds-button slds-button_neutral"}
    ];

    // Select option1 by default
    @track value = ['S1-Eligible'];
    @track checkBoxLst=[
        {label:'All',value:false},
        {label:'S1-Eligible',value:true},
        {label:'S2-Maybe Eligible',value:false},
        {label:'Not Eligible',value:false},
        {label:'Not Graded',value:false}
    ];

    
    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.queryTerm = evt.target.value;
        }
    }

    handleButtonGroup(event){
        let a = event.target.getAttribute('data-name');
        this.handleButtonChange(a);  
    }

    handleButtonChange(event){
        this.clickedButton=event;
        let subject=this.template.querySelector('[data-name="subject"]').classList;
        let satGrading=this.template.querySelector('[data-name="satGrading"]').classList;
        let label3=this.template.querySelector('[data-name="label3"]').classList;
        let buttonLst=[{button:subject,label:'subject'},{button:satGrading,label:'satGrading'},{button:label3,label:'label3'}];
            buttonLst.forEach(btn => {
                if(btn.label==event){
                    (btn.button).add('slds-button_brand');
                    (btn.button).remove('slds-button_neutral');
                }
                else if(btn.label!=event){
                    (btn.button).remove('slds-button_brand');
                    (btn.button).add('slds-button_neutral');
                }
            });
    }
    handleCheckBox(event){
        if(event.target.label==this.checkBoxLst[0].label && event.target.checked==true){
            for (let index = 0; index < this.checkBoxLst.length; index++) {
                this.checkBoxLst[index].value=event.target.checked;
            }
        }
        else if(event.target.label==this.checkBoxLst[0].label && event.target.checked==false){
            for (let index = 0; index < this.checkBoxLst.length; index++) {
                this.checkBoxLst[index].value=event.target.checked;
            }
        }
        else{
            for (let index = 0; index < this.checkBoxLst.length; index++) {
                if(event.target.label==this.checkBoxLst[index].label){
                    this.checkBoxLst[index].value=event.target.checked;
                }
            }
        }
        this.checkedLst=[]; 
        this.checkBoxLst.forEach(element => {
            if(element.value==true){
                this.checkedLst.push({header:this.clickedButton,label:element.label});
            }
        });
         console.log(JSON.stringify(this.checkedLst));
    }

    handleApplyFilter(){
        console.log('Apply Filter');
        this.dispatchEvent(new CustomEvent('applyfilter',{detail:this.checkedLst}));
        this.handleCloseFilter();
    }
    handleSkipFilter(){
        console.log('skipfilter');
        this.dispatchEvent(new CustomEvent('skipfilter'));
    }
    handleCloseFilter(){
        this.isOpen=false;
        console.log('closefilter');
        this.dispatchEvent(new CustomEvent('closefilter'));
    }
          

}