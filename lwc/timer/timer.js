import { LightningElement, track } from "lwc";

export default class Timer extends LightningElement {
  queue = [
    "Assigned Queue",
    "Counseled Queue",
    "Evaluation Queue",
    "Full service Queue",
    "Sign-up Queue"
  ];
  @track queueTiming = [
    { queueName: "", date: "" },
    { queueName: "", date: "" },
    { queueName: "", date: "" },
    { queueName: "", date: "" },
    { queueName: "", date: "" }
  ];
  assignDate;
  CounseledDate;
  EvaluationDate;
  FullDate;
  SignDate;
  connectedCallback() {
    this.waitTime();
    /*
        setInterval(() => {
            console.log(this.assignDate);
            console.log(this.CounseledDate);
            console.log(this.EvaluationDate);
            console.log(this.FullDate);
            console.log(this.SignDate);
            console.log(JSON.stringify(this.queueTiming));
        }, 1000);*/
  }
  handleClick() {
    //console.log(this.template.querySelectorAll('[data-id="render"]'));
    setInterval(() => {
      console.log(this.template.querySelector('[data-id="render"]'));
      this.template.querySelector('[data-id="render"]');
    }, 1000);
  }
  waitTime() {
    this.queue.forEach((q) => {
      if (q === "Assigned Queue") {
        setInterval(() => {
          let leadAssignedDate = new Date(2023, 6, 10, 8, 30).getTime();
          this.assignDate = new Date().getTime() - leadAssignedDate;
          //this.queueTiming.push(this.makeObject('Assigned Queue', ));
          //this.queueTiming[0].queueName = "Assigned Queue";
          this.queueTiming[0].date = this.dateConverter(this.assignDate);
        }, 1000);
      } else if (q === "Counseled Queue") {
        setInterval(() => {
          let CreatedDate = new Date(2023, 6, 11, 9, 30).getTime();
          this.CounseledDate = new Date().getTime() - CreatedDate;
          this.queueTiming[1].queueName = "Counseled Queue";
          this.queueTiming[1].date = this.dateConverter(this.CounseledDate);
        }, 1000);
      } else if (q === "Evaluation Queue") {
        setInterval(() => {
          let CreatedDate = new Date(2023, 6, 11, 9, 30).getTime();
          let leadAssignedDate = new Date(2023, 6, 10, 8, 30).getTime();
          this.EvaluationDate = CreatedDate - leadAssignedDate;
          this.queueTiming[2].queueName = "Evaluation Queue";
          this.queueTiming[2].date = this.dateConverter(this.EvaluationDate);
        }, 1000);
      } else if (q === "Full service Queue") {
        setInterval(() => {
          let CreatedDate = new Date(2023, 6, 11, 9, 30).getTime();
          this.FullDate = new Date().getTime() - CreatedDate;
          this.queueTiming[3].queueName = "Full service Queue";
          this.queueTiming[3].date = this.dateConverter(this.FullDate);
        }, 1000);
      } else if (q === "Sign-up Queue") {
        setInterval(() => {
          let CreatedDate = new Date(2023, 6, 11, 9, 30).getTime();
          this.SignDate = new Date().getTime() - CreatedDate;
          this.queueTiming[4].queueName = "Sign-up Queue";
          this.queueTiming[4].date = this.dateConverter(this.SignDate);
        }, 1000);
      }
    });
  }
  dateConverter(distance) {
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    var hours = Math.floor(
      (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
    );
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    return (
      days +
      "D" +
      " " +
      hours +
      "H" +
      " " +
      minutes +
      "M" +
      " " +
      seconds +
      "MM"
    );
  }
}