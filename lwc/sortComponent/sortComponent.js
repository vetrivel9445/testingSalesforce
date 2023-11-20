import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccountData'
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex'

export default class DataTableCmpt extends LightningElement {
arrayInfo=[];
isSelect=false;
array=[{label:'test1',rating:'hot',value:["ram","gokul","anbu","suresh"]},
{label:'test2',rating:'cold',value:["anbu","gokul","anbu","suresh"]},
{label:'test3',rating:'hot',value:["vel","gokul","anbu","suresh"]},
{label:'test4',rating:'Warm',value:["karan","gokul","anbu","suresh"]}];
sortArray=[];
wireResponse;
AccountData;
columnsLst = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
    { label: 'Rating', fieldName: 'Rating', editable: true }
];
connectedCallback(){

    this.arrayInfo=[...this.array];
}/*
renderedCallback(){
    var table = this.template.querySelector("lightning-datatable");
    console.log("table Style",table);
    // setTimeout(()=>{
    console.log(table.getElementsByClassName(".slds-hint-parent"));
    // },5000)
}*/
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
handleClick(event){
    console.log('Sort click');
    let arrayS=[];
    let filterArray=[];
    let ratingLst=["hot","warm","cold"];
    ratingLst.sort();
    (this.arrayInfo).forEach(ele => {
        console.log(ele);
        for (const key in ele) {
            if(key==="rating"){
                if(ele[key]===ratingLst[0]){
                    filterArray.push(ele);
                    console.log(ele);
                }
                else if(ele[key]===ratingLst[1]){
                    filterArray.push(ele);
                    console.log(ele);
                }
                else if(ele[key]===ratingLst[2]){
                    filterArray.push(ele);
                    console.log(ele);
                }
            }
        }  
    });
    console.log(JSON.stringify(filterArray));

}

}