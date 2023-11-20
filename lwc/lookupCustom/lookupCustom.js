import { LightningElement, api, wire } from 'lwc';
import searchEventRecord from '@salesforce/apex/EventController.searchEventRecord';

export default class LookupCustom extends LightningElement {
    isData = false;
    name;
    data;
    value;

    handleChange(event) {
        this.name = (event.target.value) + '*';
        console.log(this.name);
    }
    async handleClick(event) {
        if (event.target.name == 'search' && this.name != '') {
            await searchEventRecord({ Name: this.name })
                .then(response => {
                    this.isData = true;
                    response.forEach(element => {
                        this.data = element;
                        console.log(JSON.stringify(element));
                    });
                    console.log(JSON.stringify(response));
                }).catch(er => {
                    console.log(er);
                })
        } else if (event.target.name == 'clear') {

            this.value = '';
            this.name = '';
            this.data = [];
            this.isData = false
        }

    }
}