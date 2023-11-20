import { LightningElement, api } from 'lwc';
import getContact from '@salesforce/apex/ContactController.getContact';

export default class Cs1 extends LightningElement {
    isData = false;
    data;
    @api recordId;
    connectedCallback() {
        getContact({ accountId: this.recordId })
            .then(response => {
                this.data = response;
                console.log('CS1');
                console.log(JSON.stringify(response));
                response.forEach(ele => {
                    if (ele != undefined) {
                        this.isData = true;
                    }
                });

            })
            .catch(er => {
                console.log(er);
            })


    }
}