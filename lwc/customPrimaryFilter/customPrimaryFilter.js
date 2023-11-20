import { LightningElement ,api,track} from 'lwc';

export default class CustomPrimaryFilter extends LightningElement {

    isClicked=false;
    @api selectedValue='Any time';
    @api label='Best time to call'
    @track options=[];

    connectedCallback(){
        for (let index = 1; index <=12; index++) {
            this.options.push(String(index)+':00 AM');
            
        }
        for (let index = 1; index <=12; index++) {
            this.options.push(String(index)+':00 PM');
            
        }
    }

    handleClick(event){
        console.log('handleClick');
        this.isClicked=!this.isClicked;
    }

    handleListClick(event){
        this.selectedValue=event.target.name;
        this.dispatchEvent(new CustomEvent('singledatepicker',{detail:this.selectedValue}));
        this.handleClick();
    }

}