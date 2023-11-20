import { LightningElement } from 'lwc';

export default class YaxisDatatadel extends LightningElement {



    inputData=[];
    isOpen=true;
    columnChili=false;
    columnFav=false;
    favouriteName;

    connectedCallback(){
        this.setData();
    }
    setData(){
        for (let index = 0; index < 20; index++) {
            this.inputData.push({
                id:index,
                clientName:'clientName'+index,
                subject:'subject'+index,
                taskType:'taskType'+index,
                bestTimeToCall:'12:00 AM',
                OpportunityName:'Test Opportunity'+index,
                satGrading:'satGrading'+index,
                icGrading:'icGrading'+index,
                chili:false,
                favourite:false,
                
            })
            
        }
    }

    handleChiliClick(event){

        console.log('handleChiliClick',event.detail.name);
        console.log('handleChiliClick',event.detail.value);
        if(event.detail.name=='columnChilli' && event.detail.value==true){
            this.isOpen=false;
            for (let index = 0; index < this.inputData.length; index++) {
                this.inputData[index].chili=true;
            }
            setTimeout(() => {
                this.isOpen=true;
            }, 5);
        }
        else if(event.detail.name=='columnChilli' && event.detail.value==false){
            this.isOpen=false;
            for (let index = 0; index < this.inputData.length; index++) {
                this.inputData[index].chili=false;
            }
            setTimeout(() => {
                this.isOpen=true;
            }, 5);
        }
    }

    handleEditIconClick(event){
        console.log('handleEditIconClick',event.target.name);
    }


    handleChildFavourite(event){
        console.log('handleChildFavourite',event.detail.name);
        console.log('handleChildFavourite',event.detail.value);
        if(event.target.name=='columnFavourite' && event.detail.value==true){
            this.isOpen=false;
            for (let index = 0; index < this.inputData.length; index++) {
                this.inputData[index].favourite=true;
            }
            setTimeout(() => {
                this.isOpen=true;
            }, 5);
        }
        else if(event.target.name=='columnFavourite' && event.detail.value==false){
            this.isOpen=false;
            for (let index = 0; index < this.inputData.length; index++) {
                this.inputData[index].favourite=false;
            }
            setTimeout(() => {
                this.isOpen=true;
            }, 5);
        }
    }
}