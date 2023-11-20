import { LightningElement, api, track, wire } from 'lwc';
import LightningModal from 'lightning/modal';
import getAccountData from '@salesforce/apex/AccountController.getAccountData';

export default class DatatableModal extends LightningElement {
    data;
    @api content;
    isTrue = false;
    @track cols = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        {
            type: 'button',
            typeAttributes: {
                variant: 'brand',
                label: 'view',
                class: 'slds-var-p-around_medium'
            }
        }
    ];
    @wire(getAccountData)
    AccountLst(response) {
        if (response.data) {
            this.data = response.data;
            console.log('dataModal');
            console.log(this.data);
        }
    }
    handleAction(event) {
        console.log(event.detail.row);
        this.content = event.detail.row;
        this.isTrue = true;
    }
    handleCancel() {
        this.isTrue = false;
    }
}