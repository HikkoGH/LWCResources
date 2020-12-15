import { LightningElement, wire, api } from 'lwc';
import messageChannel from '@salesforce/messageChannel/customProgressBar__c';
import {publish, MessageContext} from 'lightning/messageService'


export default class CustomProgressBarChannel extends LightningElement {

    @api activeStep;
    @wire(MessageContext)
    messageContext;

    renderedCallback() {
        const message = { activeStep: this.activeStep };
        publish(this.messageContext, messageChannel, message);
    }
}