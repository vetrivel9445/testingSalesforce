import { LightningElement, track, wire } from 'lwc';
import getAllAccountData from '@salesforce/apex/AccountController.getAllAccountData';

export default class DataTablePagination extends LightningElement {
    @track data = [];
    sliceData;
    startLenght = 0;
    endLenght = 11;

    @track cols = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' }
    ];

    @wire(getAllAccountData)
    AccountLst(response) {
        if (response.data) {
            this.data = response.data;
            console.log(JSON.stringify(this.data.length));
            this.sliceData = this.data.slice(this.startLenght, this.endLenght);
            //console.log(JSON.stringify((this.data).slice(startLenght, startLenght)));
        }
    }
    handleclick(event) {
        console.log('Handle Click');
        console.log(event.target.name);
        console.log(this.startLenght, this.endLenght);
        if ((event.target.name == 'next') && this.data.length > this.endLenght) {
            this.startLenght = this.startLenght + 10;
            this.endLenght = this.endLenght + 10;
        } else if ((event.target.name == 'next') && this.data.length == this.endLenght) {
            this.startLenght = this.startLenght;
            this.endLenght = this.endLenght;
        } else if ((event.target.name == 'previuos') && this.startLenght > 0) {
            this.startLenght = this.startLenght - 10;
            this.endLenght = this.endLenght - 10;
        } else if ((event.target.name == 'previuos') && this.startLenght == 0) {
            this.startLenght = this.startLenght;
            this.endLenght = this.endLenght;
        }
        this.sliceData = this.data.slice(this.startLenght, this.endLenght);


    }
}