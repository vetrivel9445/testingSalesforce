import { LightningElement,api } from 'lwc';

export default class SecondChildActionProgress extends LightningElement {

    @api message;
    handleClick(){
        console.log('Second Button');
        this.dispatchEvent(new CustomEvent('secondchange'));
    }
}