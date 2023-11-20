import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAccountData';

export default class DataTableRating extends LightningElement {
    options = [{ label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' }
    ];
    data;
    columnsLst = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        {
            label: 'Rating picklist',
            fieldName: 'Rating',
            wrapText: true,
            //editable: true,
            type: 'comboboxType',
            typeAttributes: {
                label: 'Rating Picklist',
                placeholder: 'Select Stage',
                options: [{ label: 'Hot', value: 'Hot' },
                    { label: 'Warm', value: 'Warm' },
                    { label: 'Cold', value: 'Cold' }
                ],
                value: { fieldName: 'Rating' }
            }

        }
    ];
    @wire(getAccountData)
    AccountList(response) {
        if (response.data) {
            this.data = response.data;
        }
    }
}