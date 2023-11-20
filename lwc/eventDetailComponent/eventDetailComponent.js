import { LightningElement, track, wire } from 'lwc';
import getEventRecord from '@salesforce/apex/EventController.getEventRecord';
import getEventSpeaker from '@salesforce/apex/CustomObjectController.getEventSpeaker';
import getEventAttendees from '@salesforce/apex/CustomObjectController.getEventAttendees';
import getLocation from '@salesforce/apex/CustomObjectController.getLocation';
import getEventDetailRecord from '@salesforce/apex/EventController.getEventDetailRecord';

import EVENTSPEAKER_OBJECT from '@salesforce/schema/Event_Speaker__c'

import SPEAKER_OBJECT from '@salesforce/schema/Speaker__c'
import NAME_FIELD from '@salesforce/schema/Speaker__c.Name'
import PHONE_FIELD from '@salesforce/schema/Speaker__c.Phone__c'
import EMAIL_FIELD from '@salesforce/schema/Speaker__c.Email__c'
import COMPANY_FIELD from '@salesforce/schema/Speaker__c.Company__c'

import { createRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { CloseActionScreenEvent } from 'lightning/actions';


export default class EventDetailComponent extends LightningElement {
    @track options;
    eventDetailData;
    @track locationResponse;
    @track speakerResponse;
    @track attendeeResponse;
    name = NAME_FIELD;
    phone = PHONE_FIELD;
    email = EMAIL_FIELD;
    company = COMPANY_FIELD;
    speaker = SPEAKER_OBJECT;
    isHandleClick = false;
    isChange = false;
    speakerId;
    toCreate;
    eventData;
    speakerResponse;

    cols = [{ label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        { label: 'Company__c', fieldName: 'Company__c' },
        { label: 'Phone__c', fieldName: 'Phone__c' }
    ];

    @wire(getEventRecord)
    EventLst(response) {
        if (response.data) {
            console.log('event Detail componenet');
            console.log(JSON.stringify(response.data));
            let eventData = response.data;
            let convertData = (eventData).map(rec => {
                return {
                    'label': rec.Name__c,
                    'value': rec.Id
                }
            })
            this.options = [...convertData];
            console.log(this.options);

        } else if (response.error) {
            console.log(JSON.stringify(response.error));
        }
    }
    handleChange(event) {
        console.log(event.detail.value);
        this.eventData = event.detail.value;
        this.getRecords(this.eventData);
    }
    async getRecords(id) {
        await getEventDetailRecord({ eventId: id })
            .then(response => {
                console.log(response[0]);
                this.eventDetailData = response[0];
                this.isChange = true;
            }).catch(er => {
                console.log(er)
            })

        await getEventSpeaker({ eventId: id })
            .then(response => {
                this.speakerResponse = response;
                console.log(response[0]);
                if (response[0] == undefined) {
                    this.isSpeaker = false;
                } else {
                    this.isSpeaker = true;
                    let data = response[0].Speaker__r;
                    console.log(data);
                    this.speakerResponse = [data];
                    console.log(JSON.stringify(this.speakerResponse));

                }
            }).catch(er => {
                console.log(er)
            })

        await getEventAttendees({ eventId: id })
            .then(response => {
                this.attendeeResponse = response;
                console.log(JSON.stringify(response));
            }).catch(er => {
                console.log(er)
            })

        await getLocation({ eventId: id })
            .then(response => {
                this.locationResponse = response;
                console.log(JSON.stringify(response));
            }).catch(er => {
                console.log(er)
            })

    }
    async handleSubmit(event) {

        let data = event.detail.fields;
        console.log(data);
        this.toCreate = [data].map(fields => {
            return {
                allowSaveOnDuplicate: true,
                apiName: SPEAKER_OBJECT.objectApiName,
                fields: {...fields }
            }

        });
        console.log(this.toCreate);
        console.log(JSON.stringify(this.toCreate));
        let record = this.toCreate.map(ele => {
            return createRecord(ele)
        })
        console.log(record);
        console.log(JSON.stringify(record));
        await Promise.all(record)
            .then(res => {
                let speakerId = res[0].id;
                console.log(res);
                this.dispatchEvent(new CloseActionScreenEvent);
                const evt = new ShowToastEvent({
                    title: 'Speaker Record created',
                    message: 'Record ID: ' + res[0].id,
                    variant: 'success',
                });
                this.dispatchEvent(evt);
                this.isHandleClick = false;
                this.isSpeaker = true;
                let record = {
                    allowSaveOnDuplicate: true,
                    apiName: EVENTSPEAKER_OBJECT.objectApiName,
                    fields: {
                        Speaker__c: speakerId,
                        Event__c: this.eventData,
                        Name: 'TestEvent',
                    }
                }
                console.log(speakerId);
                console.log(JSON.stringify(record));
                console.log(this.eventData);
                let create = record.map(ele => {
                    return createRecord(record)
                });
                console.log('Event Speaker 0');
                this.EventSpeaker(create);
            })
            .catch(er => {
                console.log(er);
                this.dispatchEvent(new CloseActionScreenEvent);
                const evt = new ShowToastEvent({
                    title: 'Error in Speaker created',
                    message: er.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
                this.isHandleClick = false;
                this.isSpeaker = true;
            });
    }
    async EventSpeaker(create) {
        //Promise.all(create)
        console.log('Event Speaker 1');
        await Promise.all(create)
            .then(res => {
                console.log('Event Speaker 2');
                console.log(res);
                const evt = new ShowToastEvent({
                    title: 'Event Speaker Record created',
                    message: 'Record ID: ' + res[0].id,
                    variant: 'success',
                });
                this.dispatchEvent(evt);
                refreshApex(this.speakerResponse);
            })
            .catch(er => {
                console.log(er);
                const evt = new ShowToastEvent({
                    title: 'Error in Speaker created',
                    message: er.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
    }
    handleSuccess(event) {
        console.log(this.toCreate);
        console.log('HandleSuccess');
        console.log(event);
    }
    handleSave() {
        console.log('HandleSave');

    }
    handleClick() {
        this.isHandleClick = true;
        console.log('Handle Click');
    }
    handleCancle() {
        console.log('handleCancle');
        this.dispatchEvent(new CloseActionScreenEvent);
        this.isHandleClick = false;
    }

}