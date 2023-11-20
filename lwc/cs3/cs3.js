import { LightningElement, api } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class Cs3 extends LightningElement {
    isSuccess = false;
    @api objectApiName = CONTACT_OBJECT;
    handleSubmit() {
        this.isSuccess = true;
    }
    handleSuccess(event) {
        this.isSuccess = false;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Contact created ' + event.detail.id,
                variant: 'success',
            }),
        );

    }

}