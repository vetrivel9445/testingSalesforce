import { LightningElement } from 'lwc';

export default class LightningAppComponent extends LightningElement {
    firstInput;
    secondInput;
    output;
    handleChange(event) {
        if (event.target.name == 'input1') {
            this.firstInput = parseInt(event.target.value);
        }
        if (event.target.name == 'input2') {
            this.secondInput = parseInt(event.target.value);
        }
    }
    handleClick(event) {
        if (event.target.name == 'addButton') {
            this.output = this.firstInput + this.secondInput;
        }
        if (event.target.name == 'subButton') {
            if (this.firstInput > this.secondInput) {
                this.output = this.firstInput - this.secondInput;
            } else {
                this.output = this.secondInput - this.firstInput;
            }
        }
        if (event.target.name == 'mulButton') {
            this.output = this.firstInput * this.secondInput;
        }
        if (event.target.name == 'divButton') {
            this.output = this.firstInput / this.secondInput;
        }
        if (event.target.name == 'clearButton') {
            this.output = '';
            this.firstInput = '';
            this.secondInput = '';
        }


    }
}