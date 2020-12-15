import { api, LightningElement, wire } from 'lwc';
import messageChannel from '@salesforce/messageChannel/customProgressBar__c';
import { subscribe, MessageContext } from 'lightning/messageService';
import { loadStyle } from 'lightning/platformResourceLoader';
import ProgressBar from '@salesforce/resourceUrl/ProgressBar';

export default class CustomProgressBar extends LightningElement {
    @api firstLabel = "";
    @api secondLabel = "";
    @api thirdLabel = "";
    @api fourthLabel = "";
    @api activeStep = "1";

    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        Promise.all([
            loadStyle(this, ProgressBar),
        ]).then(() => { });

        this.handleSubscribe();
    }

    handleSubscribe() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.messageContext, messageChannel, (message) => {
            this.activeStep = message.activeStep;
        });
    }

    renderedCallback() {
        // console.log(this.activeStep);
        this.setTextStyles();
    }

    setTextStyles() {
        ["1", "2", "3", "4"].forEach(id => {
            const selector = `[data-id='${id}']`;
            const element = this.template.querySelector(selector);
            console.log(parseInt(id)); 
            console.log(parseInt(this.activeStep));
            if (parseInt(id) > parseInt(this.activeStep)) {
                element.className = `${element.className} grey-text`;
            }
            else {
                element.className = `${element.className.replaceAll("grey-text", "")}`;
            }

        })
    }
}