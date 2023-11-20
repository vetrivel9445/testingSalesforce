import { LightningElement, api, track, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccountData';

import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import RATING_FIELD from '@salesforce/schema/Account.Rating'
export default class CustomDatatable extends LightningElement {

    @track draftValues = [];
    toUpdate;
    @track rvalue;
    @track accountData = [];
    @track data;
    recordTypeId;
    rating;
    @track columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name', editable: true },
        {
            label: 'Rating',
            fieldName: 'Ratingoptions',
            editable: true,
            wrapText: true,
            type: 'picklistType',
            typeAttributes: {
                label: { label: 'Rating' },
                options: { fieldName: 'Ratingoptions' },
                value: { fieldName: 'Rating' },
                //context: { fieldName: 'Rating' },
            }
        }
    ];
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    getObjectData(response) {
        if (response.data) {
            this.recordTypeId = response.data.defaultRecordTypeId;
            console.log('custom Datatable 1');
            console.log(this.recordTypeId);
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: RATING_FIELD })
    getRatingPicklist({ data, error }) {
        console.log('custom Datatable 2.0');
        if (data) {
            this.rating = data.values;
            console.log('custom Datatable 2');
            console.log(data);
            console.log(JSON.stringify(this.rating));
            this.getData();
        }
    }
    getData() {
        getAccountData()
            .then(response => {
                if (response) {
                    this.data = response;
                    let options = [];
                    for (let key in this.rating) {
                        options.push({ label: this.rating[key].label, value: this.rating[key].value })
                    }
                    console.log('custom Datatable 3');
                    console.log(JSON.stringify(options));
                    this.accountData = (this.data).map(record => {
                        return {
                            ...record,
                            'Ratingoptions': options
                        }
                    })
                    console.log('custom Datatable 4');
                    console.log(JSON.stringify(this.accountData));
                }
            }).catch(error => {
                console.log('error');
                console.log(error);
            })
    }
    handleCellChange(event) {
        console.log(event.detail.draftValues);
        this.rvalue = event.detail.draftValues[0].Ratingoptions;
        this.accountData.forEach(ele => {
            if (ele.Id == event.detail.draftValues[0].Id) {
                ele.Rating = this.rvalue;
            }
        })
        console.log(this.accountData);
        console.log(this.rvalue);
        //console.log(JSON.stringify(this.accountData));
    }
    async handleSave(event) {
        alert(event.detail.draftValues);
        console.log(event.detail.draftValues)
        console.log(typeof event.detail.draftValues)
        const records = event.detail.draftValues.slice().map((rec) => {
            const fields = { Id: rec.Id, Name: rec.Name, Rating: this.rvalue }
                //console.log(typeof draftValue)
                //const fields = draftValue;
                //console.log(fields)
            return { fields };
        });
        console.log(JSON.stringify(records));
        try {
            // Update all records in parallel thanks to the UI API

            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account Record updated',
                    variant: 'success'
                })
            );
            this.draftValues = [];
            refreshApex(this.data);
            /*
            // Report success with a toast
            await updateRecord(records)
                            .then(() => {
                                this.dispatchEvent(
                                    new ShowToastEvent({
                                        title: 'Success',
                                        message: 'Account updated',
                                        variant: 'success'
                                    })
                                );

                            })*/
            // Display fresh data in the datatable
            //await refreshApex(this.contacts);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading contacts',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }

    }

}