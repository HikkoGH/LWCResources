import { LightningElement, wire } from 'lwc';
import getDependentPicklistValues from "@salesforce/apex/PicklistValuesUtils.getDependentPicklistValues";
import getPicklistValues from "@salesforce/apex/PicklistValuesUtils.getPicklistValues";

export default class InputAddressUsage extends LightningElement {
    _country = '';
    countryOptions = [];
    countryProvinceMap = {};

    @wire(getDependentPicklistValues, { dependentField: "Samples_Request__c.Ship_To_State__c" })
    countryPicklistValues({error, data}) {
        this.countryProvinceMap = data;
    }

    @wire(getPicklistValues, { picklistField: "Samples_Request__c.Ship_To_Country__c" })
    picklistValues({error, data}) {
        this.countryOptions = data;
    }

    get getProvinceOptions() {
        if (!this.countryProvinceMap) return [];
        return this.countryProvinceMap[this._country] || {};
    }

    get getCountryOptions() {
        return this.countryOptions;
    }

    handleAddressChange(event) {
        this._country = event.detail.country;
        this.dispatchEvent(new CustomEvent('change', {
            detail: {
                field: 'Address',
                value: JSON.parse(JSON.stringify(event.detail))
            }
        }));
    }
}