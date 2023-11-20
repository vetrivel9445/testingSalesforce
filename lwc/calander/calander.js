import { LightningElement, track } from "lwc";

export default class Calander extends LightningElement {
  isSelect = false;
  year = new Date().getUTCFullYear();
  day = new Date().getUTCDay();
  @track option = [];
  monthIndex = new Date().getUTCMonth();
  monthsArray = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  month = this.monthsArray[this.monthIndex];

  constructor() {
    super();
  }
  handleCombobox(event) {
    console.log(event);
  }
  connectedCallback() {
    for (let i = this.year; i > this.year - 10; i--) {
      this.option.push(i.toLocaleString());
      console.log(i);
    }
    for (let i = this.year; i < this.year + 10; i++) {
      this.option.push(i.toLocaleString());
      console.log(i);
    }
  }
  handleYear(event) {
    this.template.querySelector(".btnC").innerHTML = 2013;
    console.log(this.template.querySelector(".btnC").innerHTML);
    console.log(event);
  }
  handleButton() {
    console.log("select Date");
    this.isSelect = !this.isSelect;
  }
  handleTable(event) {
    console.log(event);
  }
}