import { LightningElement, api, wire, track } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { NavigationMixin } from 'lightning/navigation';

import getContactAction from '@salesforce/apex/ContactController.getContactAction';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import SALUTATION_FIELD from '@salesforce/schema/Contact.Salutation'
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName'
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName'
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId'
import PHONE_FIELD from '@salesforce/schema/Contact.Phone'
import EMAIL_FIELD from '@salesforce/schema/Contact.Email'

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';

export default class Cs2 extends NavigationMixin(LightningElement) {
    data;
    fieldData;
    @api objectApiName = CONTACT_OBJECT;
    @api recordId;
    @track fields = {
        FirstName: FIRSTNAME_FIELD,
        Salutation: SALUTATION_FIELD,
        LastName: LASTNAME_FIELD,
        AccountName: ACCOUNTID_FIELD,
        Phone: PHONE_FIELD,
        Email: EMAIL_FIELD,
    }

    @wire(getContactAction, { contactId: '$recordId' })
    getContact(response) {
        console.log(response);
        if (response.data) {
            console.log(response.data);
            this.data = response.data;
        }
    }
    handleChange(event) {
        console.log(event);
        console.log('On change');
    }
    async handleSubmit(event) {
        console.log('On Submit');
        let data = event.detail.fields;

        let record = [data].map(ele => {
            return {
                allowSaveOnDuplicate: true,
                apiName: CONTACT_OBJECT.objectApiName,
                fields: {...ele }
            }
        })
        console.log(record);
        console.log(JSON.stringify(record));

        let toCreate = record.map(ele => { return createRecord(ele) });

        Promise.all(toCreate)
            .then(res => {
                console.log(res[0].id);
                console.log('update Success');
                this.dispatchEvent(new CloseActionScreenEvent());
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created  :' + res[0].id,
                        variant: 'success',
                    }),
                );
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: res[0].id,
                        actionName: 'view',
                    },
                });
            }).catch(er => {
                console.log(er.body);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: er.body.message,
                        variant: 'error',
                    }),
                );
            })

        /*
        createRecord(record)
            .then(res => {
                console.log(res);
                console.log('update Success');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created',
                        variant: 'success',
                    }),
                );
            }).catch(er => {
                console.log(er.body);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: er.body.message,
                        variant: 'error',
                    }),
                );
            })*/
    }
    handleClick() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }


}