import { LightningElement, api } from 'lwc';
import EVENT_OBJECT from '@salesforce/schema/Event__c'
import NAME_FIELD from '@salesforce/schema/Event__c.Name__c'
import ORGANIZER_FIELD from '@salesforce/schema/Event__c.Organizer__c'
import STARTDATE_FIELD from '@salesforce/schema/Event__c.Start_Date__c'
import ENDDATE_FIELD from '@salesforce/schema/Event__c.End_Date__c'
import MAXSEATS_FIELD from '@salesforce/schema/Event__c.Max_Seats__c'
import LOCATION_FIELD from '@salesforce/schema/Event__c.Location__c'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class EventDetail extends NavigationMixin(LightningElement) {
    @api object = EVENT_OBJECT;
    @api fields = [NAME_FIELD, ORGANIZER_FIELD, STARTDATE_FIELD, ENDDATE_FIELD, MAXSEATS_FIELD, LOCATION_FIELD];
    @api id;
    isRecived = false;

    handleSuccess(event) {

        try {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.id,
                    actionName: 'view'
                }
            });
        } catch (error) {
            const evt = new ShowToastEvent({
                title: 'Error in Account',
                message: 'Error in Account Creation',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }


    }

}