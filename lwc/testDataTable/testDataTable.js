import { LightningElement, wire ,track} from "lwc";
import getAccountData from "@salesforce/apex/AccountController.getAllAccountData";
import { deleteRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";

export default class TestDataTable extends LightningElement {
  isChecked = true;
  index=0;
  boxSize=13;
  increment=11;
  y=0;
  isLoading=false;
  wireResponse;
  @track AccountData=[];
  ArrayLst=[];
  defaultSortDirection = "asc";
  sortDirection = "asc";
  columnsLst = [
    { label: "Id", fieldName: "Id" },
    { label: "Name", fieldName: "Name" },
    { label: "Rating", fieldName: "Rating", editable: true },
    {
      type: "button-icon",
      typeAttributes: {
        variant: "base",
        iconName: "utility:delete",
        title: "delete"
      }
    }
  ];

/*
    connectedCallback(){
        var self = this;
        this.template.addEventListener('scroll', event => {
          console.log(event);
            console.log('Connected Call back');
            console.log(this.template.scrollY);
            var div =self.template.querySelector('div');
            if (div){
                var rect= div.getBoundingClientRect();
                // calculations here
                console.log(rect.y);
                this.y=rect.y;
            }
        });
    }
    renderedCallback(){
      var self = this;
      //this.template.addEventListener('event-name', this.local-method-name.bind(this));
        window.addEventListener('scroll', event => {
            console.log('rendered Call back');
            console.log(window.scrollY);
            var div = self.template.querySelector('div');
            if (div){
                var rect= div.getBoundingClientRect();
                // calculations here
                console.log(rect.y);
                this.y=rect.y;
            }
            if(this.y=-17.5){
                for(let i=0;i<20;i++){
                    //this.AccountData.push(this.ArrayLst[i]);
                }
            }
        });
    }

 */
  @wire(getAccountData)
  AccountList(response) {
    this.wireResponse = response;
    if (response.data) {
      //this.AccountData = response.data;
      this.ArrayLst=[...(response.data)]
      //console.log('Account length::',this.ArrayLst.length);
      for(this.index;this.index<this.boxSize;this.index++){
        this.AccountData.push(this.ArrayLst[this.index]);
      }
    }
  }
  onHandleSort(event) {
    const { fieldName: sortedBy, sortDirection } = event.detail;
    const cloneData = [...this.data];

    cloneData.sort(this.sortBy(sortedBy, sortDirection === "asc" ? 1 : -1));
    this.data = cloneData;
    this.sortDirection = sortDirection;
    this.sortedBy = sortedBy;
  }
  handleScroll(event){
    //console.log(event.target);
    console.log("top",event.target.scrollTop);
    console.log("Account Data",this.AccountData.length);
    console.log("arrayLst",this.ArrayLst.length);
    //console.log(JSON.stringify(event.target));
    if(this.AccountData.length<=this.ArrayLst.length  && event.target.scrollTop>0){
      this.isLoading=true;
      setTimeout(() => {
        this.boxSize=this.boxSize+10;
        for(this.index;this.index<this.boxSize;this.index++){
          this.AccountData.push(this.ArrayLst[this.index]);
          this.isLoading=false;
          event.target.scrollTop=0;
        }
      }, 2000);
    }

    /*            let scrollHeight=event.target.scrollHeight;
            let offsetHeight=event.target.offsetHeight;
            let scrollEnd=(scrollHeight-offsetHeight);
            let scrollTop=Math.round(event.target.scrollTop);
            if(scrollTop===scrollEnd){
                console.log('End');
            }
            */
  /*
    else if((event.target.scrollTop)===200 && this.boxSize===23){
      this.isLoading=true;
      setTimeout(() => {
        this.boxSize=23;
        for(this.index;this.index<this.boxSize;this.index++){
          this.AccountData.push(this.ArrayLst[this.index]);
          this.isLoading=false;
          event.target.scrollTop=0;
        }
      }, 5000);
      console.log("increment",this.increment);
    }
    else if((event.target.scrollTop)>this.increment && this.boxSize<=33){
      this.isLoading=true;
      setTimeout(() => {
        this.boxSize=33;
        for(this.index;this.index<this.boxSize;this.index++){
          this.AccountData.push(this.ArrayLst[this.index]);
          this.isLoading=false;
          this.increment=this.increment+91;
        }
      }, 5000);
      this.boxSize=this.boxSize+14;
      //console.log("increment",this.increment);
      
    }/*
    else if((event.target.scrollTop)>=this.increment && this.boxSize<=47){
      this.isLoading=true;
      setTimeout(() => {
        this.boxSize=47;
        for(this.index;this.index<this.boxSize;this.index++){
          this.AccountData.push(this.ArrayLst[this.index]);
          this.isLoading=false;
          this.increment=this.increment+100;
        }
      }, 5000);
      console.log("increment",this.increment);
    }*/
  }
  /*
  handleMouse(event){
    console.log(event.target);
  }*/
  
}