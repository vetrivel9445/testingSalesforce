import { LightningElement, track, api, wire } from 'lwc';
import getCloneRecord from '@salesforce/apex/ContactController.getCloneRecord';
import { createRecord } from 'lightning/uiRecordApi';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CsTest extends LightningElement {
    @api recordId;
    @api objectApiName;
    data;
    @track keyFields = [];
    @api invoke() {
        console.log("Hi, I'm an action.");
    }
    @wire(getCloneRecord, { recordId: '$recordId', objectName: '$objectApiName' })
    cloneReord(response) {
        if (response.data) {
            this.data = response.data;
            console.log(response.data);
            for (let key in response.data) {
                this.keyFields.push(key);
            }
        }
    }

    handleSubmit(event) {
        console.log(event.detail);
        let record = [event.detail.fields].map(fields => {
            return {
                allowSaveOnDuplicate: true,
                apiName: this.objectApiName,
                fields
            }
        });
        let toCreate = record.map(ele => { return createRecord(ele) });
        console.log(JSON.stringify(toCreate));
        Promise.all(toCreate)
            .then(res => {
                this.dispatchEvent(new CloseActionScreenEvent());
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created  :' + res[0].id,
                        variant: 'success',
                    }),
                );

            }).catch(er => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error in Contact created ',
                        variant: 'error',
                    }),
                );
            })
    }

}