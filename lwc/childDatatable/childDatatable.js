import { LightningElement } from 'lwc';
import LightningDatatable from 'lightning/datatable';
import combobox from './combobox.html'


export default class ChildDatatable extends LightningDatatable {

    /*options = [{ label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' }
    ];*/
    static customTypes = {
        comboboxType: {
            template: combobox,
            editTemplate: staticCombobox,
            //standardCellLayout: true,
            typeAttributes: ['placeholder', 'options', 'value']
        }
    }
}