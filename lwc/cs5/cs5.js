import { LightningElement, api, track } from 'lwc';
import RECEIPT_OBJECT from '@salesforce/schema/Receipt__c'
import RECEIPTID_FIELD from '@salesforce/schema/Receipt__c.Receipt_ID__c'
import AMOUNT_FIELD from '@salesforce/schema/Receipt__c.Amount__c'
import MODEOFPAY_FIELD from '@salesforce/schema/Receipt__c.Mode_of_Pay__c'
import AMOUNTPAIDDATE_FIELD from '@salesforce/schema/Receipt__c.Amount_Paid_Date__c'
import CONTACT_FIELD from '@salesforce/schema/Receipt__c.Contact__c'
import { CloseActionScreenEvent } from 'lightning/actions';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Cs5 extends LightningElement {
    toCreate;
    @api recordId;
    objectApiName = RECEIPT_OBJECT;
    @track fields = {
        ReceiptId: RECEIPTID_FIELD,
        Amount: AMOUNT_FIELD,
        ModeOfPay: MODEOFPAY_FIELD,
        AmountPaidDate: AMOUNTPAIDDATE_FIELD,
        contact: CONTACT_FIELD
    }
    async handleSubmit(event) {
        console.log("submit");
        let data = [event.detail.fields];
        let recorInput = data.map(ele => {
            return {
                allowSaveOnDuplicate: true,
                apiName: RECEIPT_OBJECT.objectApiName,
                fields: {...ele }
            }
        });
        this.toCreate = recorInput.map(ele => { return createRecord(ele) });
        Promise.all(this.toCreate)
            .then(res => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Receipt Record created',
                        variant: 'success',
                    }),
                );
                this.dispatchEvent(new CloseActionScreenEvent());
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

    }
    handleClick(event) {
        console.log(event.target.name);
        if (event.target.name == 'cancel') {
            this.dispatchEvent(new CloseActionScreenEvent);
        }
    }

}