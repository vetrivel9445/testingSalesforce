import { LightningElement,api } from 'lwc';

export default class ystoreProductSolutionFavouritesIcon extends LightningElement {

    @api isSelected;
    @api name;
    variant;
    size='x-small';
    connectedCallback(){
       if(!this.isSelected==true)this.variant='default';
       else if(this.isSelected==true)this.variant='error';
    }

    favoriteClick(event){
        this.isSelected=(!this.isSelected);
        event.target.value=this.isSelected;
        this.dispatchEvent(new CustomEvent('favourite',{detail:{name:this.name,value:this.isSelected}}));
        console.log(this.isSelected);
        if(this.isSelected==true){this.variant='error';}
        else if(!this.isSelected==true){this.variant='default';}
        
    }
}