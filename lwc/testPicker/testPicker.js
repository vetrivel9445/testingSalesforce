import { LightningElement } from 'lwc';
import mainJs from '@salesforce/resourceUrl/datePickerJs1';
import momentJs from '@salesforce/resourceUrl/datePickerJs2';
import pmJs from '@salesforce/resourceUrl/datePickerJs3';
import css from '@salesforce/resourceUrl/datePickerCss';
import { loadScript,loadStyle } from 'lightning/platformResourceLoader';

export default class TestPicker extends LightningElement {
    startDate;
    endDate;
    renderedCallback(){
        Promise.all([
            loadScript(this,mainJs),
            loadScript(this,momentJs),
            loadScript(this,pmJs),
            loadStyle(this,css)
        ]).then((res)=>{
            console.log('jquery loaded');
            this.jquery2();
        }).catch((er)=>{
            console.log(er);
        })
    }
    jquery2(){
        $(this.template.querySelector("input")).daterangepicker();
        $(this.template.querySelector("input")).on('apply.daterangepicker', function(ev, picker) {
            this.startDate=picker.startDate.format('YYYY-MM-DD');
            this.endDate=picker.endDate.format('YYYY-MM-DD');
          console.log(picker.startDate.format('YYYY-MM-DD'));
          console.log(picker.endDate.format('YYYY-MM-DD'));
        });
       
           /* $(this.template.querySelector("input")).daterangepicker({
                opens: 'center'
              },
              function(start, end, label) {
                this.startDate=start.format('YYYY-MM-DD');
                this.endDate=end.format('YYYY-MM-DD');
                console.log("Selected date : " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
              });*/
    }
    /*jquery(){
        $(this.template.querySelector("input")).daterangepicker();
        let output=$(this.template.querySelector("input")).on(click,daterangepicker());
        consoler.log(output);
        
    }*/
}