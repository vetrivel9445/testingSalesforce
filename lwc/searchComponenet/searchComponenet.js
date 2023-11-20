import { LightningElement } from "lwc";

export default class SearchComponenet extends LightningElement {
  searchLst = ["vetri", "vel", "ram", "krishna"];
  output = [];
  isMatch = false;
  value;

  options=[
    {label:'Australia',value:'Australia'},
    {label:'India',value:'India'}
  ];


  handleComboChange(event){
    console.log(event);
    this.value = event.target.value;
  }




  handleChange(event) {
    //console.log(event.detail.value);
    let input = event.detail.value;
    if (input) {
      this.searchLst.forEach((element) => {
        if (element.startsWith(input)) {
          this.output.push(element);
          this.isMatch = true;
          console.log(this.output);
        }
      });
    } else {
      this.isMatch = false;
      this.output = [];
    }
  }
}