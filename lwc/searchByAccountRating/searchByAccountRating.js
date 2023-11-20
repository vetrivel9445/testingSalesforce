import { LightningElement, track, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccount'

export default class SearchByAccountRating extends LightningElement {
    rating;
    AccountLst;
    isChange = false;
    @track ratingOptions = [{ label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' }
    ];
    handleChange(event) {
        this.rating = event.detail.value;
        this.AccountLst = [];
        this.isChange = false;
    }
    @wire(getAccountData, { rating: '$rating' })
    getAccount({ data, error }) {
        if (data) {
            this.isChange = true;
            console.log(data);
            this.AccountLst = data;
        }

    }
}