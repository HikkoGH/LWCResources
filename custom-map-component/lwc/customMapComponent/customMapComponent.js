import { LightningElement, api, wire } from 'lwc';
import getCountryFieldValues from '@salesforce/apex/CustomMapComponentController.getCountryFieldValues';
import getFieldValue from '@salesforce/apex/CustomMapComponentController.getFieldValue';

export default class CustomMapComponent extends LightningElement {

  @api country = '';
  @api city = '';
  @api postalCode = '';
  @api state = '';
  @api street = '';
  @api recordId = '';
  @api objectName = '';
  @api title = '';
  @api description = '';
  mapMarkers = [];
  refreshComponent = false;

  renderedCallback() {
    if (this.mapMarkers.length === 0 || this.refreshComponent) {
      this.retrieveValues();
    }
  }

  retrieveValues() {
    const premisesList = [getCountryFieldValues({ 
      recordId: this.recordId, 
      fieldNames: [this.country, this.city, this.state, this.street, this.postalCode], 
      objectName: this.objectName 
    })];

    if (this.title) {
        premisesList.push(getFieldValue({ 
          recordId: this.recordId, 
          fieldName: this.title, 
          objectName: this.objectName 
        }));
    }
    if (this.description) {
        premisesList.push(getFieldValue({
           recordId: this.recordId,
           fieldName: this.description,
           objectName: this.objectName 
        }));
    }

    Promise.all(premisesList)
      .then(response => {
        this.refreshComponent = false;
        const city = response[0]['' + this.city];
        const country = response[0]['' + this.country];
        const postalCode = response[0]['' + this.postalCode];
        const state = response[0]['' + this.state];
        const street = response[0]['' + this.street];

        this.mapMarkers = [{
          location: {
            City: city,
            Country: country,
            PostalCode: postalCode,
            State: state,
            Street: street,
          },
          title: response[1],
          description: response[2],
        }];
      })
      .catch(error => {
        this.refreshComponent = false;
        this.mapMarkers = [];
        console.error(error);
      });
  }

  onRefreshClick() {
    this.mapMarkers = [];
    this.refreshComponent = true;
  }
}