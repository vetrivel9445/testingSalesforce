import { LightningElement, track, wire } from 'lwc';
import getAllAccountForSearch from '@salesforce/apex/AccountController.getAllAccountForSearch';

export default class Cs4 extends LightningElement {
    input;
    isSearch = false;
    @track data;
    handleClick(event) {
        if (event.target.name == 'search') {
            this.input = this.template.querySelector('lightning-input').value + '*';
            console.log(this.input);
            getAllAccountForSearch({ input: this.input })
                .then(res => {
                    this.data = res[0];
                    this.isSearch = true;
                    console.log(res);
                }).catch(er => {
                    console.log(er);
                })
        } else if (event.target.name == 'clear') {
            this.isSearch = false;
            this.template.querySelector('lightning-input').value = '';
        }

    }
}