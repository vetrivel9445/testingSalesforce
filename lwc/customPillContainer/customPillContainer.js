import { LightningElement,api,track } from 'lwc';

export default class CustomPillContainer extends LightningElement {

    isMore=false;
    @track  inputLst=[
        {header:'Subject1',label:'Some Value1'},
        {header:'Subject2',label:'Some Value2'},
        {header:'Subject3',label:'Some Value3'},
        {header:'Subject4',label:'Some Value4'},
        {header:'Subject5',label:'Some Value5'},
        {header:'Subject6',label:'Some Value6'},
    ];
    valueArr=[];
    @track pillList=[];

    connectedCallback(){
        this.toViewList();
    }

    toViewList(){
        if(this.inputLst.length>4){

            for (let index = 0; index < 3; index++) {
                this.pillList.push(this.inputLst[index]);
            }
            this.isMore=true;
        }
        else{
            this.pillList=[...this.inputLst];
            this.isMore=false;
        }
    }

    handleClick(event){
        console.log(event.target.name);
        for (let index = 0; index < this.pillList.length; index++) {
            if(this.pillList[index].label===event.target.name){
                this.pillList.splice(index,1);
                this.inputLst.splice(index,1);
            }
        }
        if(this.pillList.length<3 && this.pillList.length<this.inputLst.length){
            this.valueArr = this.pillList.map((item)=>{ return item.label});
            this.valueArr.push(event.target.name);
            console.log(JSON.stringify(this.valueArr));
            for (let index = 0; index < this.inputLst.length; index++) {
                if(this.inputLst[index].label!==event.target.name && !this.valueArr.includes(this.inputLst[index].label)){
                    this.pillList.push(this.inputLst[index]);
                    break;
                }
            }
        }
        if(this.pillList.length===3 && this.inputLst.length==3){
            this.pillList=[...this.inputLst];
            this.isMore=false;
        }
        this.dispatchEvent(new CustomEvent('save',{detail:this.pillList}));
    }
    handleAncer(event){
        console.log(event);
        console.log(event.target.name);
        this.pillList=[...this.inputLst];
        this.isMore=false;
    }

}