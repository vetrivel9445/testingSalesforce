import { LightningElement, api } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';


export default class LookupComponent extends LightningElement {
    @api recordId;
    objectName = CONTACT_OBJECT;
    fields = ACCOUNTID_FIELD;
}