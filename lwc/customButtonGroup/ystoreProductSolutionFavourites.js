import { LightningElement,api } from 'lwc';

export default class CustomButtonGroup extends LightningElement {

    @api isSelected;
    variant;
    size='x-small';
    connectedCallback(){
       if(!this.isSelected==true)this.variant='default';
       else if(this.isSelected==true)this.variant='error';
    }



    // handleStageTabClick(event){
    //     let getAllDataName = event.target.getAttribute('data-name');
    //     this.buttonChange(getAllDataName);
    // }

    // buttonChange(event){
    //     let task=this.template.querySelector('[data-name="task"]').classList;
    //     let clients=this.template.querySelector('[data-name="clients"]').classList;
    //     var buttonLst=[{button:task,label:'task'},{button:clients,label:'clients'}];

    //     buttonLst.forEach(btn => {
    //         if(btn.label==event){
    //             (btn.button).add('slds-button_brand');
    //             (btn.button).remove('slds-button_neutral');
    //         }
    //         else if(btn.label!=event){
    //             (btn.button).remove('slds-button_brand');
    //             (btn.button).add('slds-button_neutral');
    //         }
    //     });

    // }
    favoriteClick(event){
        this.isSelected=(!this.isSelected);
        event.target.value=this.isSelected;
        this.dispatchEvent(new CustomEvent('favourite',{detail:this.isSelected}));
        console.log(this.isSelected);
        if(this.isSelected==true){this.variant='error';}
        else if(!this.isSelected==true){this.variant='default';}
        
    }
}