import { LightningElement } from 'lwc';

export default class ActionProgress extends LightningElement {
    // isFinish = false;
    i=0;
    handleClick(event) {
        if (event.target.name == 'start') {
            this.template.querySelector("c-child-action-progress").isFinish = false;
            console.log(event.target.name);
        }
        console.log('parent handleClick');
        this.template.querySelector("c-child-action-progress").handleClick();
        this.template.querySelector("lightning-button").disabled = true;
        this.template.querySelector("c-child-action-progress").handleCheck();
    }
    handleFinish() {
        console.log('form child to parent');
        this.template.querySelector("lightning-button").disabled = false;
        this.template.querySelector("c-child-action-progress").handleFinish();
        console.log(this.template.querySelector("c-child-action-progress"));
        this.template.querySelector("c-child-action-progress").handleCheck();

    }
    handleSecondChange(){
        console.log('Second Child Change');
        this.i++;
        console.log(this.template.querySelector("c-second-child-action-progress"));
        this.template.querySelector("c-second-child-action-progress").message=this.i;
    }

}