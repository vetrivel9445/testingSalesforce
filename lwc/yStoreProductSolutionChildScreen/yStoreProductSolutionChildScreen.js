import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class YStoreProductSolutionChildScreen extends LightningElement {

    isModalOpen=true;
    @api componentName='JSS';
    modalHeader;
    backButton='Back';
    @api saveOrContinueButton='Save & Proceed';
    isJss=false;
    isEvaluation=false;
    isSoUg=false;
    isVisa=false;
    isCoaching=false;

    connectedCallback(){

        if(this.componentName=='JSS'){
            this.isJss=true;
            this.modalHeader='JSS';
        }
        else if(this.componentName=='EVALUATION'){
            this.isEvaluation=true;
            this.modalHeader='Evaluation';
        }
        else if(this.componentName=='SO UG'){
            this.isSoUg=true;
            this.modalHeader='SO UG';
        }
        else if(this.componentName=='VISA'){
            this.isVisa=true;
            this.modalHeader='Visa';
        }
        else if(this.componentName=='COACHING'){
            this.isCoaching=true;
            this.modalHeader='Coaching';
        }
    }

    closeModal(){
        this.isModalOpen=false;
    }
    handleBackButton(){
        console.log('Back');
        this.dispatchEvent(new CustomEvent('back',{detail:this.componentName}));
    }
    handleSaveOrContinueButton(){
        console.log('Save');
        this.dispatchEvent(new CustomEvent('save'));
    }

    navigateToAccountList(){

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            },
        });
    }
}