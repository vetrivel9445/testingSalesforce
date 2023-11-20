import { LightningElement,api } from 'lwc';

export default class CustomButtonGroup extends LightningElement {

    @api isSelected;
    variant;
    size='x-small';
    connectedCallback(){
       if(!this.isSelected==true)this.variant='default';
       else if(this.isSelected==true)this.variant='error';
    }

    favoriteClick(event){
        this.isSelected=(!this.isSelected);
        event.target.value=this.isSelected;
        this.dispatchEvent(new CustomEvent('favourite',{detail:this.isSelected}));
        console.log(this.isSelected);
        if(this.isSelected==true){this.variant='error';}
        else if(!this.isSelected==true){this.variant='default';}
        
    }
}