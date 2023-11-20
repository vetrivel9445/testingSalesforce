import { LightningElement, api, wire } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId'
import getAccountAddress from '@salesforce/apex/AccountController.getAccountAddress';

export default class CustomLookUp extends LightningElement {
    objectApiName = CONTACT_OBJECT;
    accountId = ACCOUNTID_FIELD;
    id;
    isKey = false;
    keys = [];
    address = {};
    accountData;
    @api recordId;
    handleChange(event) {
        console.log(event.target.value);
        this.id = event.target.value;
        this.isKey = false;
        this.keys = [];
    }
    @wire(getAccountAddress, { accountId: '$id' })
    getAddress({ data, error }) {
        if (data) {
            console.log(data);
            this.accountData = data;
            this.accountData.forEach(element => {
                console.log(element.BillingAddress);
                this.address = element.BillingAddress;
            });
            for (let key in this.address) {
                console.log(key);
                this.keys.push({ label: key, value: this.address[key] });
                this.isKey = true;
                console.log(this.address[key]);
            }
        }
    }
}