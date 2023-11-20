import { LightningElement,api } from 'lwc';

export default class CustomDateRangePicker extends LightningElement {

    isClickedBox=false;
    yearsLst=[];
    monthNameLSt = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
                    ];
    weekLst=['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    currentMonth;
    MonthNumber;
    year;
    wholeMonthDate=[];
    @api selectedDate='Select any Date';


    firstNo;
    secondNo;
    
    @api firstDate={label:'',month:0,year:0};
    @api SecondDate={label:'',month:0,year:0};

    DateLstRow1=[];
    DateLstRow2=[];
    DateLstRow3=[];
    DateLstRow4=[];
    DateLstRow5=[];
    DateLstRow6=[];
    Count=0;

    connectedCallback(){
        this.getNoOfDaysInMonth();
        this.getYears();
        this.MonthNumber=this.getCurrentMonth();
        this.currentMonth=this.monthNameLSt[this.MonthNumber];
        this.year = new Date().getFullYear();
        this.generateDates(this.year,this.MonthNumber)
    }

    getNoOfDaysInMonth(year,month) {
        let noOfDaysInMonth=new Date(year, month, 0).getDate();
        console.log(noOfDaysInMonth);
        return noOfDaysInMonth;
    }

    getCurrentMonth(){
        let monthNumber = new Date().getMonth();
        return monthNumber;
    }

    getDayFormDate(year,month,date){
        const d = new Date();
        d.setFullYear(year,month,date);
        const day = d.getDay();
        return day;
    }

    setDate(year,month,day){
        const d = new Date();
        let date =d.setFullYear(year, month, day);
        return date;
    }
    
    getYears(){
        let year = new Date().getFullYear();
        for (let index =year;index >= year-40; index--) {
            this.yearsLst.push({ label: index, value: index });
        }
        for (let index =year;index < year+40; index++) {
            this.yearsLst.unshift({ label: index, value: index });
        }
        console.log(JSON.stringify(this.yearsLst));
    }
    handlePreviousMonthChange(){
        if(this.MonthNumber==0)this.MonthNumber=0;
        else  this.MonthNumber--;
        console.log(this.MonthNumber);
        this.currentMonth=this.monthNameLSt[this.MonthNumber];
        this.generateDates(this.year,this.MonthNumber);
        this.setButtonBrand();
    }
    handleNextMonthChange(){
        if(this.MonthNumber<11)this.MonthNumber++; 
        else  this.MonthNumber=11;
        console.log(this.MonthNumber);
        this.currentMonth=this.monthNameLSt[this.MonthNumber];
        this.generateDates(this.year,this.MonthNumber);
        this.setButtonBrand();
    }
    handleSelectYear(event){
        console.log('Year');
        console.log(event.target.value);
        event.target.selected=true;
        this.year =event.target.value;
        this.generateDates(this.year,this.MonthNumber);
    }
    handleBoxClick(){
        this.isClickedBox=!this.isClickedBox;
        this.Count=0;
        if(this.isClickedBox==true){
            this.setButtonBrand();
        }
    }
    generateDates(year,month){
        this.wholeMonthDate=[];
        this.DateLstRow1=[];
        this.DateLstRow2=[];
        this.DateLstRow3=[];
        this.DateLstRow4=[];
        this.DateLstRow5=[];
        this.DateLstRow6=[];
        let DayName=this.getDayFormDate(year,month,1);
        console.log('DayNAme'+DayName);
        let previousMonthDays=this.getNoOfDaysInMonth(year,month);
        console.log('previousMonthDays'+previousMonthDays);
        let currentMonthDays=this.getNoOfDaysInMonth(year,month+1);
        let decrementIndex=previousMonthDays-DayName;
        if(DayName!=0){
            for (let index = decrementIndex+1; index <=previousMonthDays ; index++) {
                console.log('index for Previous Month'+index);
                this.wholeMonthDate.push({disabled:true,class:'slds-day_adjacent-month',label:(String(index)+String(this.currentMonth.slice(0, 3))+String(year)),dateNo:index,variant:"base",style:'--slds-c-button-text-color:black;width: 100%;'});
            }
        }
        for (let index = 1; index <= currentMonthDays; index++) {
            this.wholeMonthDate.push({disabled:false,class:'',label:(String(index)+' '+String(this.currentMonth.slice(0, 3))+' '+String(year)),dateNo:index,variant:"base",style:'--slds-c-button-text-color:black;width: 100%;'});
        }
        
        for (let index = 0; index < this.wholeMonthDate.length; index++) {
            if(index<7) {
                this.DateLstRow1.push(this.wholeMonthDate[index]);
            }
            else if( index>=7 && index<14){
                this.DateLstRow2.push(this.wholeMonthDate[index]);
            }
            else if(index>=14 && index<21){
                this.DateLstRow3.push(this.wholeMonthDate[index]);
            }
            else if(index>=21 && index<28){
                this.DateLstRow4.push(this.wholeMonthDate[index]);
            }
            else if(index>=28 && index <35){
                this.DateLstRow5.push(this.wholeMonthDate[index]);
            }
            else if(index>=35 && index <42){
                this.DateLstRow6.push(this.wholeMonthDate[index]);
            }
            
        }
    }

    setButtonBrand(){
        this.wholeMonthDate.forEach(element => {
            if(this.firstDate.label===element.label ||this.SecondDate.label===element.label){
                element.variant='brand';
            }
            // else if(Number(this.firstDate.label.slice(0,2)) <Number(element.label.slice(0,2)) &&  Number(this.SecondDate.label.slice(0,2)) >Number(element.label.slice(0,2))){
            //     element.style='--slds-c-button-text-color: black;width: 0%;background-color: lightblue;border-radius: 1px;'
            // }
            else{
                element.variant='base';
            }


        });

    }

    handleTd(event){
        console.log('handleTd');
        console.log(event.target.name);
        console.log('f'+Number(this.firstDate.label.slice(0,2)),'e'+ Number(event.target.name.slice(0,2)));
        if(this.Count==0){
            this.wholeMonthDate.forEach(element => {
                this.template.querySelector('[data-name="'+element.label+'"]').variant='base';
                // this.template.querySelector('[data-name="'+element.label+'"]').style='--slds-c-button-text-color:black;width: 100%;';
            });
            this.firstDate.label=event.target.name;
            
            this.firstDate.month=this.MonthNumber;
            this.firstDate.year=this.year;
            event.target.variant='brand';
            this.Count++;
        }
        else if(this.Count==1 && Number(this.firstDate.label.slice(0,2)) <Number(event.target.name.slice(0,2))   && this.firstDate.month<=this.MonthNumber && this.firstDate.year<=this.year){
            this.SecondDate.label=event.target.name;
            this.SecondDate.month=this.MonthNumber;
            this.SecondDate.year=this.year;
            event.target.variant='brand';
            this.selectedDate=this.firstDate.label+' to '+ this.SecondDate.label;
            this.dispatchEvent(new CustomEvent('singledatapicker',{
                detail:{'fromDate':{'value':this.firstDate.label,
                'date':Number(this.firstDate.label.slice(0,2)),
                'monthNumber':this.firstDate.month,
                'monthName':this.monthNameLSt[this.firstDate.month],
                'year':this.firstDate.year
                },'toDate':{'value':this.SecondDate.label,
                    'date':Number(this.SecondDate.label.slice(0,2)),
                    'monthNumber':this.SecondDate.month,
                    'monthName':this.monthNameLSt[this.SecondDate.month],
                    'year':this.SecondDate.year}}
                }));
            this.handleBoxClick();
        }


    }
}