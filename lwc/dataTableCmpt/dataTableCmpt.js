import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccountData'
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'

export default class DataTableCmpt extends LightningElement {


    wireResponse;
    AccountData;
    columnsLst=[
        { 
            iconName:'utility:heart',
            editable: true,
            wrapText: true,
            type: 'button-icon',
            actions: [{iconName:'utility:heart', checked: true, name:'favourite'}] ,
            typeAttributes: {
                variant: 'bare',
                iconName: 'utility:heart',
                title: 'favourite',
                onclick:this.handleFavouriteClick(),
            }
         },
         { 
            iconName:'utility:heart',
            editable: true,
            wrapText: true,
            type: 'button-icon',
            actions: [{iconName:'utility:heart', checked: true, name:'favourite'}] ,
            typeAttributes: {
                variant: 'bare',
                iconName: 'utility:heart',
                title: 'favourite',
                onclick:this.handleFavouriteClick(),
            }
         },
         { label: 'Id', fieldName: 'Id' },
         { label: 'Name', fieldName: 'Name' },
        { label: 'ClientName', fieldName: 'ClientName' },
        {label: 'Subject', fieldName: 'Subject'},
        {label: 'Task Type', fieldName: 'Task Type'},
        {label: 'Best Time to Call', fieldName: 'Best Time to Call'},
        {label: 'Opportunity Name', fieldName: 'Opportunity Name'},
        {label: 'SAT Grading', fieldName: 'SAT Grading'},
        {label: 'IC Grading', fieldName: 'IC Grading'},
        { 
            editable: true,
            wrapText: true,
            type: 'button-icon',
            typeAttributes: {
                variant: 'bare',
                iconName: 'utility:edit',
                title: 'favourite'
            }
         },
    ];
    // columnsLst = [
    //     { label: 'Id', fieldName: 'Id' },
    //     { label: 'Name', fieldName: 'Name' },
    //     { label: 'Rating', fieldName: 'Rating', editable: true },
    //     {
    //         type: 'button-icon',
    //         typeAttributes: {
    //             variant: 'base',
    //             iconName: 'utility:delete',
    //             title: 'delete'
    //         }
    //     }
    // ];
    @wire(getAccountData)
    AccountList(response) {
        this.wireResponse = response;
        if (response.data) {
            this.AccountData = response.data;
        }

    }
    handleRowAction(event) {
        console.log('delete');
        const rec = event.detail.row;
        console.log(rec);
        console.log(rec.Id);
        //console.log(JSON.stringify(event.detail.row));
        //console.log(this.template.querySelector('lightning-datatable').getSelectedRows());
        deleteRecord(rec.Id)
            .then(response => {
                console.log(response);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Record Delete',
                    message: 'Record Deleted' + response,
                    variant: 'success'
                }))
                refreshApex(this.wireResponse);
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    title: ' Error Delete',
                    message: error.message,
                    variant: 'error'
                }))
            })

    }

    handleFavouriteClick(){
        console.log('handleFavouriteClick');
    }
    headerAction(event){
        console.log('handleFavouriteClick');
        console.log(event);

    }
}