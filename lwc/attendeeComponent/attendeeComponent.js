import { LightningElement, api, track, wire } from 'lwc';
import getAttendeesForUpcoming from '@salesforce/apex/CustomObjectController.getAttendeesForUpcoming';
import getAttendeesForPastEvent from '@salesforce/apex/CustomObjectController.getAttendeesForPastEvent';


export default class AttendeeComponent extends LightningElement {
    @track columns = [{
            label: "Event Name",
            fieldName: "detailsPage",
            type: "url",
            wrapText: "true",
            typeAttributes: {
                label: {
                    fieldName: "Name"
                }
            }
        },
        {
            label: "Name",
            fieldName: "EVNTORG",
            cellAttributes: {
                iconName: "standard:user",
                iconPosition: "left"
            }
        },
        {
            label: "Event Date",
            fieldName: "StartDateTime",
            type: "date",
            typeAttributes: {
                weekday: "long",
                year: "numeric",
                month: "long"
            }
        },
        {
            label: "Location",
            fieldName: "Location",
            type: "text",
            cellAttributes: {
                iconName: "utility:location",
                iconPosition: "left"
            }
        }
    ];
    @api recordId;
    @track events;
    @track past_events;
    errors;
    connectedCallback() {
        this.upcomingEvetsFromApex();
        this.pastEvetsFromApex();
    }

    upcomingEvetsFromApex() {
        getAttendeesForUpcoming({
                attendeeId: this.recordId
            })
            .then((result) => {
                //window.console.log(" error ", result);
                result.forEach((record) => {
                    record.Name = record.Event__r.Name__c;
                    record.detailsPage =
                        "https://" + window.location.host + "/" + record.Event__c;
                    record.EVNTORG = record.Event__r.Organizer__r.Name;
                    record.StartDateTime = record.Event__r.Start_DateTime__c;
                    if (record.Event__r.Location__c) {
                        record.Location = record.Event__r.Location__r.Name;
                    } else {
                        record.Location = "This is a virtual event";
                    }
                });
                this.events = result;
                //window.console.log(" result ", result);
                this.errors = undefined;
            })
            .catch((error) => {
                this.events = undefined;
                this.errors = JSON.stringify(error);
            });
    }
    pastEvetsFromApex() {
        getAttendeesForPastEvent({
                attendeeId: this.recordId
            })
            .then((result) => {
                window.console.log(" past_events ", result);
                result.forEach((record) => {
                    record.Name = record.Event__r.Name__c;
                    record.detailsPage =
                        "https://" + window.location.host + "/" + record.Event__c;
                    record.EVNTORG = record.Event__r.Organizer__r.Name;
                    record.StartDateTime = record.Event__r.Start_Date__c;
                    if (record.Event__r.Location__c) {
                        record.Location = Event__r.Location__r.Name;
                    } else {
                        record.Location = "This is a virtual event";
                    }
                });
                this.past_events = result;
                window.console.log(" result ", result);
                this.errors = undefined;
            })
            .catch((error) => {
                this.events = undefined;
                this.errors = JSON.stringify(error);
            });
    }
}