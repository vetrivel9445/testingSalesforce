import LightningDatatable from 'lightning/datatable';
import { api } from 'lwc';
import picklistRating from './picklistRating.html'
import staticCombobox from './staticCombobox.html'


export default class ChildCustomDatatable extends LightningDatatable {

    static customTypes = {
        picklistType: {
            template: staticCombobox,
            editTemplate: picklistRating,
            standardCellLayout: true,
            typeAttributes: ['options', 'value']
        }
    }
}