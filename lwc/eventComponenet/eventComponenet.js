import { LightningElement, track, wire } from 'lwc';
import getEventRecordForEventComp from '@salesforce/apex/EventController.getEventRecordForEventComp';

import { NavigationMixin } from 'lightning/navigation';

export default class EventComponenet extends NavigationMixin(LightningElement) {
    @track data;
    cols = [{
            label: 'Name__c',
            fieldName: 'Name__c',
            type: 'button',
            typeAttributes: {
                label: { fieldName: 'Name__c' },
                value: { fieldName: 'Id' }
            }
        },
        { label: 'Start_Date__c', fieldName: 'Start_Date__c' },
        { label: 'End_Date__c', fieldName: 'End_Date__c' },
        { label: 'Live__c', fieldName: 'Live__c' }
    ];
    @wire(getEventRecordForEventComp)
    eventLst(response) {
        console.log(response);
        console.log('event Componenet');
        if (response.data) {
            this.data = response.data;
            console.log(response.data);
        }
    }
    handleAction(event) {
        console.log(event.detail.row);
        console.log(event.detail.row.Id);
        let id = event.detail.row.Id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: id,
                actionName: 'view',
            },
        });
    }
}