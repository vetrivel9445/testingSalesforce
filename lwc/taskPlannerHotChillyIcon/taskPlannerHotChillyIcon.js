import { LightningElement ,api} from 'lwc';

export default class TaskPlannerHotChillyIcon extends LightningElement {

    @api name;
     
    hotIconPrevious=true;
    @api hotIconNew;
    connectedCallback(){
        if(!this.hotIconNew)this.hotIconPrevious=true;
        else if(this.hotIconNew) this.hotIconPrevious=false;
    }

    hotIconClick(){
        this.hotIconPrevious=!this.hotIconPrevious;
        this.hotIconNew=!this.hotIconNew;
        this.dispatchEvent(new CustomEvent('chili',{detail:{name:this.name,value:this.hotIconNew}}));
    }
    hotIconNewClick(){
        this.hotIconPrevious=!this.hotIconPrevious;
        this.hotIconNew=!this.hotIconNew;
        this.dispatchEvent(new CustomEvent('chili',{detail:{name:this.name,value:this.hotIconNew}}));
    }
}